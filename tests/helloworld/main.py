from pandemonium import exposed
from pandemonium.bindings import Node, OS


@exposed
class Main(Node):
    def _ready(self):
        # Exit pandemonium
        OS.set_exit_code(0)
        self.get_tree().quit()
