import tempfile
import unittest
from pathlib import Path

from tools.schema_from_sdl import schema_document, schema_files


class SchemaFromSdlTest(unittest.TestCase):
    def test_builds_introspection_document_and_provenance(self):
        with tempfile.TemporaryDirectory() as temporary_directory:
            root = Path(temporary_directory)
            (root / "graphql/schema/types").mkdir(parents=True)
            (root / "graphql/schema/schema.graphql").write_text(
                'schema { query: Query }\n\ntype Query { hello: String! }\n',
                encoding="utf-8",
            )
            (root / "graphql/schema/types/scene.graphql").write_text(
                'type Scene { id: ID! }\n', encoding="utf-8"
            )

            document, provenance = schema_document(root, ref="test-sha")

            types = document["data"]["__schema"]["types"]
            self.assertEqual(provenance["ref"], "test-sha")
            self.assertEqual(
                provenance["files"],
                ["graphql/schema/schema.graphql", "graphql/schema/types/scene.graphql"],
            )
            self.assertEqual(
                next(item for item in types if item["name"] == "Query")["fields"][0]["name"],
                "hello",
            )

    def test_rejects_empty_schema_source(self):
        with tempfile.TemporaryDirectory() as temporary_directory:
            with self.assertRaisesRegex(ValueError, "no Stash GraphQL schema files"):
                schema_files(Path(temporary_directory))


if __name__ == "__main__":
    unittest.main()