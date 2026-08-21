import unittest

from tools.schema_compatibility import compare_schemas


def field(name, return_type="String", args=None, description=None, deprecated=False, reason=None):
    return {
        "name": name,
        "description": description,
        "args": args or [],
        "type": {"kind": "SCALAR", "name": return_type},
        "isDeprecated": deprecated,
        "deprecationReason": reason,
    }


def document(query_fields, extra_types=None):
    return {
        "data": {
            "__schema": {
                "queryType": {"name": "Query"},
                "mutationType": None,
                "types": [
                    {"name": "Query", "kind": "OBJECT", "description": None, "fields": query_fields},
                    *(extra_types or []),
                ],
            }
        }
    }


class SchemaCompatibilityTest(unittest.TestCase):
    def test_classifies_additions_deprecations_and_documentation(self):
        baseline = document([field("old", description="before")])
        candidate = document(
            [
                field("old", description="after", deprecated=True, reason="Use new"),
                field("new"),
            ],
            [{"name": "Added", "kind": "OBJECT", "description": None, "fields": []}],
        )
        report = compare_schemas(baseline, candidate)
        self.assertEqual(report["added_types"], ["Added"])
        self.assertEqual(report["added_operations"], [{"operation": "query", "name": "new"}])
        self.assertEqual(report["deprecations"], [{"path": "query.old", "reason": "Use new"}])
        self.assertEqual(report["documentation_changes"][0]["path"], "query.old")

    def test_classifies_signature_changes_and_removals(self):
        baseline = document([field("gone"), field("changed", return_type="String")])
        candidate = document([field("changed", return_type="Int")])
        report = compare_schemas(baseline, candidate)
        self.assertEqual(report["removed_operations"], [{"operation": "query", "name": "gone"}])
        self.assertEqual(report["signature_changes"][0]["name"], "changed")

    def test_ignores_introspection_type_changes(self):
        baseline = document(
            [],
            [{"name": "__Type", "kind": "OBJECT", "description": None, "fields": [field("isOneOf")]}],
        )
        candidate = document([], [{"name": "__Type", "kind": "OBJECT", "description": None, "fields": []}])
        report = compare_schemas(baseline, candidate)
        self.assertEqual(report["removed_fields"], [])


if __name__ == "__main__":
    unittest.main()
