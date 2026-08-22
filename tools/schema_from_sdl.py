#!/usr/bin/env python3
"""Build a GraphQL introspection document from a Stash SDL checkout."""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
from typing import Iterable

from graphql import build_ast_schema, parse
from graphql.utilities import introspection_from_schema


SCHEMA_PATTERNS = (
    "graphql/schema/types/*.graphql",
    "graphql/schema/*.graphql",
)
SOURCE_URL = "https://github.com/stashapp/stash"


def schema_files(source_root: Path, patterns: Iterable[str] = SCHEMA_PATTERNS) -> list[Path]:
    if not source_root.is_dir():
        raise ValueError(f"source root does not exist: {source_root}")

    files = {
        path.relative_to(source_root)
        for pattern in patterns
        for path in source_root.glob(pattern)
        if path.is_file()
    }
    if not files:
        raise ValueError("no Stash GraphQL schema files matched the configured patterns")
    return sorted(files)


def schema_document(
    source_root: Path,
    ref: str | None = None,
    commit: str | None = None,
    package_version: str | None = None,
    artifact: str | None = None,
) -> tuple[dict, dict]:
    files = schema_files(source_root)
    definitions = "\n\n".join(
        path.read_text(encoding="utf-8") for path in (source_root / file for file in files)
    )
    schema = build_ast_schema(parse(definitions), assume_valid=False)
    document = {"data": introspection_from_schema(schema)}
    provenance = {
        "source": SOURCE_URL,
        "ref": ref,
        "patterns": list(SCHEMA_PATTERNS),
        "files": [path.as_posix() for path in files],
        "fingerprints": {
            path.as_posix(): hashlib.md5(
                (source_root / path).read_bytes(), usedforsecurity=False
            ).hexdigest()
            for path in files
        },
        "parser": "graphql-core",
    }
    if commit is not None:
        provenance["commit"] = commit
    if package_version is not None:
        provenance["stashapi_version"] = package_version
    if artifact is not None:
        provenance["artifact"] = artifact
    return document, provenance


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Build a GraphQL introspection snapshot from a Stash SDL checkout."
    )
    parser.add_argument("--source-root", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True, help="snapshot JSON path")
    parser.add_argument(
        "--provenance-output", type=Path, help="optional provenance JSON path"
    )
    parser.add_argument("--ref", help="Stash tag or branch recorded as provenance")
    parser.add_argument("--commit", help="Stash commit recorded as provenance")
    parser.add_argument("--package-version", help="stashapi version recorded as provenance")
    parser.add_argument(
        "--artifact", help="package artifact path recorded as provenance"
    )
    args = parser.parse_args()

    document, provenance = schema_document(
        args.source_root,
        args.ref,
        args.commit,
        args.package_version,
        args.artifact,
    )
    args.output.write_text(json.dumps(document, indent=2) + "\n", encoding="utf-8")
    if args.provenance_output:
        args.provenance_output.write_text(
            json.dumps(provenance, indent=2) + "\n", encoding="utf-8"
        )


if __name__ == "__main__":
    main()