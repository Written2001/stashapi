#!/usr/bin/env python3
"""Compare two GraphQL introspection documents for compatibility changes."""

from __future__ import annotations

import argparse
import json
from pathlib import Path
from typing import Any


def _schema(document: dict[str, Any]) -> dict[str, Any]:
    return document.get("data", document).get("__schema", {})


def _type_map(document: dict[str, Any]) -> dict[str, dict[str, Any]]:
    return {item["name"]: item for item in _schema(document).get("types", [])}


def _type_string(type_ref: dict[str, Any]) -> str:
    kind = type_ref["kind"]
    if kind == "NON_NULL":
        return f"{_type_string(type_ref['ofType'])}!"
    if kind == "LIST":
        return f"[{_type_string(type_ref['ofType'])}]"
    return type_ref["name"]


def _signature(field: dict[str, Any]) -> dict[str, Any]:
    return {
        "return_type": _type_string(field["type"]),
        "arguments": {
            argument["name"]: _type_string(argument["type"])
            for argument in field.get("args", [])
        },
    }


def _root_operations(document: dict[str, Any]) -> dict[str, dict[str, Any]]:
    roots = {}
    schema = _schema(document)
    types = _type_map(document)
    for operation, root in (("query", "queryType"), ("mutation", "mutationType")):
        root_type = schema.get(root)
        if root_type:
            roots[operation] = types.get(root_type["name"], {})
    return roots


def _compare_metadata(report: dict[str, Any], path: str, before: dict[str, Any], after: dict[str, Any]) -> None:
    if before.get("description") != after.get("description"):
        report["documentation_changes"].append(
            {"path": path, "before": before.get("description"), "after": after.get("description")}
        )
    before_deprecated = bool(before.get("isDeprecated"))
    after_deprecated = bool(after.get("isDeprecated"))
    if after_deprecated and (not before_deprecated or before.get("deprecationReason") != after.get("deprecationReason")):
        report["deprecations"].append({"path": path, "reason": after.get("deprecationReason")})


def compare_schemas(baseline: dict[str, Any], candidate: dict[str, Any]) -> dict[str, Any]:
    baseline_types = _type_map(baseline)
    candidate_types = _type_map(candidate)
    report: dict[str, Any] = {
        "added_types": sorted(set(candidate_types) - set(baseline_types)),
        "removed_types": sorted(set(baseline_types) - set(candidate_types)),
        "added_operations": [],
        "removed_operations": [],
        "added_fields": [],
        "removed_fields": [],
        "deprecations": [],
        "signature_changes": [],
        "documentation_changes": [],
    }

    baseline_roots = _root_operations(baseline)
    for operation, candidate_root in _root_operations(candidate).items():
        baseline_root = baseline_roots.get(operation, {})
        baseline_fields = {field["name"]: field for field in baseline_root.get("fields", [])}
        candidate_fields = {field["name"]: field for field in candidate_root.get("fields", [])}
        for name in sorted(set(candidate_fields) - set(baseline_fields)):
            report["added_operations"].append({"operation": operation, "name": name})
        for name in sorted(set(baseline_fields) - set(candidate_fields)):
            report["removed_operations"].append({"operation": operation, "name": name})
        for name in sorted(set(baseline_fields) & set(candidate_fields)):
            before = baseline_fields[name]
            after = candidate_fields[name]
            if _signature(before) != _signature(after):
                report["signature_changes"].append(
                    {"operation": operation, "name": name, "before": _signature(before), "after": _signature(after)}
                )
            _compare_metadata(report, f"{operation}.{name}", before, after)

    for type_name in sorted(set(candidate_types) & set(baseline_types)):
        before_type = baseline_types[type_name]
        after_type = candidate_types[type_name]
        _compare_metadata(report, type_name, before_type, after_type)
        before_fields = {field["name"]: field for field in (before_type.get("fields") or [])}
        after_fields = {field["name"]: field for field in (after_type.get("fields") or [])}
        for name in sorted(set(after_fields) - set(before_fields)):
            report["added_fields"].append({"type": type_name, "name": name})
        for name in sorted(set(before_fields) - set(after_fields)):
            report["removed_fields"].append({"type": type_name, "name": name})
        if type_name not in {root.get("name") for root in _schema(candidate).values() if isinstance(root, dict)}:
            for name in sorted(set(before_fields) & set(after_fields)):
                before = before_fields[name]
                after = after_fields[name]
                if _signature(before) != _signature(after):
                    report["signature_changes"].append(
                        {"type": type_name, "name": name, "before": _signature(before), "after": _signature(after)}
                    )
                _compare_metadata(report, f"{type_name}.{name}", before, after)

    return report


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--baseline", type=Path, required=True)
    parser.add_argument("--candidate", type=Path, required=True)
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    report = compare_schemas(
        json.loads(args.baseline.read_text(encoding="utf-8")),
        json.loads(args.candidate.read_text(encoding="utf-8")),
    )
    rendered = json.dumps(report, indent=2) + "\n"
    if args.output:
        args.output.write_text(rendered, encoding="utf-8")
    else:
        print(rendered, end="")
    breaking = report["removed_types"] or report["removed_operations"] or report["removed_fields"] or report["signature_changes"]
    raise SystemExit(1 if breaking else 0)


if __name__ == "__main__":
    main()