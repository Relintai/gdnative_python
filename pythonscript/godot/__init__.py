# Start with a sanity check to ensure the loading is done from Godot-Python
# (and not from a regular Python interpreter which would lead to a segfault).
# The idea is we should have the following loading order:
# pandemonium binary -> pythonscript.so -> _pandemonium.so -> pandemonium/__init__.py
import sys

if "_pandemonium" not in sys.modules:
    raise ImportError(
        "Cannot initialize pandemonium module given Godot GDNative API not available.\n"
        "This is most likely because you are running code from a regular Python interpreter"
        " (i.e. doing something like `python my_script.py`) while pandemonium module is only available"
        " to Python code loaded from Godot through Godot-Python plugin."
    )
del sys

from pandemonium._version import __version__
from pandemonium.tags import (
    MethodRPCMode,
    PropertyHint,
    PropertyUsageFlag,
    rpcdisabled,
    rpcremote,
    rpcmaster,
    rpcpuppet,
    rpcslave,
    rpcremotesync,
    rpcsync,
    rpcmastersync,
    rpcpuppetsync,
    signal,
    export,
    exposed,
)
from pandemonium.pool_arrays import (
    PoolIntArray,
    PoolRealArray,
    PoolByteArray,
    PoolVector2Array,
    PoolVector3Array,
    PoolColorArray,
    PoolStringArray,
)
from pandemonium.builtins import *
from pandemonium.bindings import *
