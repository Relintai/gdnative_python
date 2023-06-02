from pandemonium._hazmat.gdnative_api_struct cimport (
    pandemonium_gdnative_core_api_struct,
    pandemonium_gdnative_ext_nativescript_api_struct,
    pandemonium_gdnative_ext_pluginscript_api_struct,
    pandemonium_gdnative_ext_android_api_struct,
)


cdef extern from * nogil:
    # Global variables defined in pythonscript.c
    # Just easier to inline the definitions instead of use a header file
    # and having to tweak compile flags.
    """
    #include <gdnative_api_struct.gen.h>
    #ifdef _WIN32
    # define PYTHONSCRIPT_IMPORT __declspec(dllimport)
    #else
    # define PYTHONSCRIPT_IMPORT
    #endif
    PYTHONSCRIPT_IMPORT extern const pandemonium_gdnative_core_api_struct *pythonscript_gdapi10;
    PYTHONSCRIPT_IMPORT extern const pandemonium_gdnative_ext_nativescript_api_struct *pythonscript_gdapi_ext_nativescript;
    PYTHONSCRIPT_IMPORT extern const pandemonium_gdnative_ext_pluginscript_api_struct *pythonscript_gdapi_ext_pluginscript;
    PYTHONSCRIPT_IMPORT extern const pandemonium_gdnative_ext_android_api_struct *pythonscript_gdapi_ext_android;
    """

    cdef const pandemonium_gdnative_core_api_struct *pythonscript_gdapi10
    cdef const pandemonium_gdnative_ext_nativescript_api_struct *pythonscript_gdapi_ext_nativescript
    cdef const pandemonium_gdnative_ext_pluginscript_api_struct *pythonscript_gdapi_ext_pluginscript
    cdef const pandemonium_gdnative_ext_android_api_struct *pythonscript_gdapi_ext_android
