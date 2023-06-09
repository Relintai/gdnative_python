import traceback

from pandemonium import Node, exposed, export

try:
    from pandemonium.globals import global_gd, global_py

    global_import_outcome = "ok"
except Exception as exc:
    traceback.print_exc()
    global_import_outcome = (
        f"Error doing `from pandemonium.globals import global_gd, global_py` at module level: {exc!r}"
    )


@exposed
class access_from_python(Node):

    outcome = export(str, default=None)

    def _ready(self):
        try:
            self.do_test()
        except Exception as exc:
            self.outcome = f"Unexpected error: {exc!r}"
            raise  # Stacktrace will be displayed on stdout this way
        self.outcome = self.outcome or "ok"

    def do_test(self):
        # Test accessing from `Node.get_node`
        for name, type in (("global_py", "Python"), ("global_gd", "GDScript")):
            path = f"/root/{name}"
            node = self.get_node(path)
            if not node:
                self.outcome = f"Cannot retrieve node `{path}`"
                return
            if str(node.type) != type:
                self.outcome = (
                    f"Invalid Node type for `{path}` (expected `{type}`, got `{node.type}`)"
                )
                return
            node.set_accessed("Python")

        # Also test accessing from `pandemonium.globals` module
        if global_import_outcome != "ok":
            self.outcome = global_import_outcome
            return

        from pandemonium import globals as pandemonium_globals

        pandemonium_globals_dir = dir(pandemonium_globals)
        expected_pandemonium_globals_dir = ["global_gd", "global_py"]
        if pandemonium_globals_dir != expected_pandemonium_globals_dir:
            self.outcome = f"Invalid `dir(pandemonium.globals)` (expected: `{expected_pandemonium_globals_dir}`, got `{pandemonium_globals_dir}`)"
            return
        for name, type in (("global_py", "Python"), ("global_gd", "GDScript")):
            node_from_globals = getattr(pandemonium_globals, name)
            if str(node_from_globals.type) != type:
                self.outcome = (
                    f"Invalid Node type for `{path}` (expected `{type}`, got `{node.type}`)"
                )
                return
