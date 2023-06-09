# This test is in it own file to protect other tests from the `import *` side effects
from pandemonium import *

# Class with trailing underscore not are provided on star import
from pandemonium.bindings import _OS, _ProjectSettings


def test_starimport():
    assert issubclass(Node, Object)
    assert isinstance(OS, _OS)
    assert isinstance(ProjectSettings, _ProjectSettings)
