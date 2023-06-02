# `_pandemoniummonium` module contains all the callbacks needed by Pandemonium's Pluginscript
# system to expose Python as a language to Pandemonium (see pythonscript.c for
# more on this).
# Hence there is no point of importing this module from Python given it
# only expose C functions.
# Beside this module depend on the `pandemoniummonium.hazmat` module so it would be a bad
# idea to make the `pandemoniummonium` module depend on it...
include "_pandemonium_editor.pxi"
include "_pandemonium_profiling.pxi"
include "_pandemonium_script.pxi"
include "_pandemonium_instance.pxi"
include "_pandemonium_io.pxi"

from pandemoniummonium._hazmat.gdnative_api_struct cimport (
    pandemonium_gdnative_init_options,
    pandemonium_pluginscript_language_data,
)
from pandemoniummonium._hazmat.internal cimport set_pythonscript_verbose, get_pythonscript_verbose
from pandemoniummonium.builtins cimport GDString

import sys

# OS and ProjectSettings are singletons exposed as global python objects,
# hence there are not available from a cimport
from pandemoniummonium.bindings import OS, ProjectSettings
from pandemoniummonium._version import __version__ as pythonscript_version


def _setup_config_entry(name, default_value):
    gdname = GDString(name)
    if not ProjectSettings.has_setting(gdname):
        ProjectSettings.set_setting(gdname, default_value)
    ProjectSettings.set_initial_value(gdname, default_value)
    # TODO: `set_builtin_order` is not exposed by gdnative... but is it useful ?
    return ProjectSettings.get_setting(gdname)


cdef api pandemonium_pluginscript_language_data *pythonscript_init() with gil:
    # Pass argv arguments
    sys.argv = ["pandemoniummonium"] + [str(x) for x in OS.get_cmdline_args()]

    # Update PYTHONPATH according to configuration
    pythonpath = str(_setup_config_entry("python_script/path", "res://;res://lib"))
    for p in pythonpath.split(";"):
        p = ProjectSettings.globalize_path(GDString(p))
        sys.path.insert(0, str(p))

    # Redirect stdout/stderr to have it in the Pandemonium editor console
    if _setup_config_entry("python_script/io_streams_capture", True):
        # Note we don't have to remove the stream capture in `pythonscript_finish` given
        # Pandemonium print API is available until after the Python interpreter is teardown
        install_io_streams_capture()

    # Enable verbose output from pythonscript framework
    if _setup_config_entry("python_script/verbose", False):
        set_pythonscript_verbose(True)

    # Finally proudly print banner ;-)
    if _setup_config_entry("python_script/print_startup_info", True):
        cooked_sys_version = '.'.join(map(str, sys.version_info))
        print(f"Pythonscript {pythonscript_version} (CPython {cooked_sys_version})")

    if get_pythonscript_verbose():
        print(f"PYTHONPATH: {sys.path}")

    return NULL


cdef api void pythonscript_finish(pandemonium_pluginscript_language_data *data) with gil:
    # /!\ When this function is called, the Python interpreter is fully operational
    # and might be running user-created threads doing concurrent stuff.
    # That will continue until `pandemonium_gdnative_terminate` is called (which is
    # responsible for the actual teardown of the interpreter).
    pass
