# cython: c_string_type=unicode, c_string_encoding=utf8

from libc.stddef cimport wchar_t

from godot._hazmat.gdnative_api_struct cimport (
    pandemonium_pluginscript_language_data,
    pandemonium_string,
    pandemonium_bool,
    pandemonium_array,
    pandemonium_pool_string_array,
    pandemonium_object,
    pandemonium_variant,
    pandemonium_error,
    pandemonium_dictionary
)
from godot._hazmat.gdapi cimport pythonscript_gdapi10 as gdapi10
from godot._hazmat.conversion cimport (
    pandemonium_string_to_pyobj,
    pyobj_to_pandemonium_string,
    pandemonium_variant_to_pyobj,
)


cdef api pandemonium_string pythonscript_get_template_source_code(
    pandemonium_pluginscript_language_data *p_data,
    const pandemonium_string *p_class_name,
    const pandemonium_string *p_base_class_name
) with gil:
    cdef str class_name
    if p_class_name == NULL:
        class_name = "MyExportedCls"
    else:
        class_name = pandemonium_string_to_pyobj(p_class_name)
    cdef str base_class_name = pandemonium_string_to_pyobj(p_base_class_name)
    cdef str src = f"""from godot import exposed, export
from godot import *


@exposed
class {class_name}({base_class_name}):

    # member variables here, example:
    a = export(int)
    b = export(str, default='foo')

    def _ready(self):
        \"\"\"
        Called every time the node is added to the scene.
        Initialization here.
        \"\"\"
        pass
"""
    cdef pandemonium_string ret
    pyobj_to_pandemonium_string(src, &ret)
    return ret


cdef api pandemonium_bool pythonscript_validate(
    pandemonium_pluginscript_language_data *p_data,
    const pandemonium_string *p_script,
    int *r_line_error,
    int *r_col_error,
    pandemonium_string *r_test_error,
    const pandemonium_string *p_path,
    pandemonium_pool_string_array *r_functions
) with gil:
    return True


cdef api int pythonscript_find_function(
    pandemonium_pluginscript_language_data *p_data,
    const pandemonium_string *p_function,
    const pandemonium_string *p_code
) with gil:
    return 0


cdef api pandemonium_string pythonscript_make_function(
    pandemonium_pluginscript_language_data *p_data,
    const pandemonium_string *p_class,
    const pandemonium_string *p_name,
    const pandemonium_pool_string_array *p_args
) with gil:
    cdef str name = pandemonium_string_to_pyobj(p_name)

    # TODO: replace this with PoolStringArray binding once implemented
    cdef int i
    cdef pandemonium_string gdarg
    cdef list args_names = []
    for i in range(gdapi10.pandemonium_pool_string_array_size(p_args)):
        gdarg = gdapi10.pandemonium_pool_string_array_get(p_args, i)
        arg = pandemonium_string_to_pyobj(&gdarg)
        gdapi10.pandemonium_string_destroy(&gdarg)
        args_names.append(arg.split(":", 1)[0])

    cdef str src = """\
    def {name}(self, { ','.join(args_names) }):
        pass
"""
    cdef pandemonium_string ret
    pyobj_to_pandemonium_string(src, &ret)
    return ret


cdef api pandemonium_error pythonscript_complete_code(
    pandemonium_pluginscript_language_data *p_data,
    const pandemonium_string *p_code,
    const pandemonium_string *p_base_path,
    pandemonium_object *p_owner,
    pandemonium_array *r_options,
    pandemonium_bool *r_force,
    pandemonium_string *r_call_hint
) with gil:
    return pandemonium_error.GODOT_OK


cdef api void pythonscript_auto_indent_code(
    pandemonium_pluginscript_language_data *p_data,
    pandemonium_string *p_code,
    int p_from_line,
    int p_to_line
) with gil:
    # TODO: use black for this job
#     try:
#         import autopep8
#     except ImportError:
#         print(
#             "[Pythonscript] Auto indent requires module `autopep8`, "
#             "install it with `pip install autopep8`"
#         )
#     pycode = pandemonium_string_to_pyobj(code).splitlines()
#     before = "\n".join(pycode[:from_line])
#     to_fix = "\n".join(pycode[from_line:to_line])
#     after = "\n".join(pycode[to_line:])
#     fixed = autopep8.fix_code(to_fix)
#     final_code = "\n".join((before, fixed, after))
#     # TODO: modify code instead of replace it when binding on pandemonium_string
#     # operation is available
#     lib.pandemonium_string_destroy(code)
#     lib.pandemonium_string_new_unicode_data(code, final_code, len(final_code))
    pass


__global_constants = {}


cdef api void pythonscript_add_global_constant(
    pandemonium_pluginscript_language_data *p_data,
    const pandemonium_string *p_variable,
    const pandemonium_variant *p_value
) with gil:
    # However, Godot add global constants very early (first as an empty variant
    # placeholder before any script is loaded, then as a proper loaded script).
    # So it's possible this function get called before `pythonscript_script_init`
    # (which is supposed to do the lazy `_initialize_bindings`).
    _initialize_bindings()
    name = pandemonium_string_to_pyobj(p_variable)
    value = pandemonium_variant_to_pyobj(p_value)
    __global_constants[name] = value


cdef api pandemonium_string pythonscript_debug_get_error(
    pandemonium_pluginscript_language_data *p_data
) with gil:
    cdef pandemonium_string ret
    pyobj_to_pandemonium_string("Nothing", &ret)
    return ret


cdef api int pythonscript_debug_get_stack_level_count(
    pandemonium_pluginscript_language_data *p_data
) with gil:
    return 1


cdef api int pythonscript_debug_get_stack_level_line(
    pandemonium_pluginscript_language_data *p_data,
    int p_level
) with gil:
    return 1


cdef api pandemonium_string pythonscript_debug_get_stack_level_function(
    pandemonium_pluginscript_language_data *p_data,
    int p_level
) with gil:
    cdef pandemonium_string ret
    pyobj_to_pandemonium_string("Nothing", &ret)
    return ret


cdef api pandemonium_string pythonscript_debug_get_stack_level_source(
    pandemonium_pluginscript_language_data *p_data,
    int p_level
) with gil:
    cdef pandemonium_string ret
    pyobj_to_pandemonium_string("Nothing", &ret)
    return ret


cdef api void pythonscript_debug_get_stack_level_locals(
    pandemonium_pluginscript_language_data *p_data,
    int p_level,
    pandemonium_pool_string_array *p_locals,
    pandemonium_array *p_values,
    int p_max_subitems,
    int p_max_depth
) with gil:
    pass


cdef api void pythonscript_debug_get_stack_level_members(
    pandemonium_pluginscript_language_data *p_data,
    int p_level,
    pandemonium_pool_string_array *p_members,
    pandemonium_array *p_values,
    int p_max_subitems,
    int p_max_depth
) with gil:
    pass


cdef api void pythonscript_debug_get_globals(
    pandemonium_pluginscript_language_data *p_data,
    pandemonium_pool_string_array *p_locals,
    pandemonium_array *p_values,
    int p_max_subitems,
    int p_max_depth
) with gil:
    pass


cdef api pandemonium_string pythonscript_debug_parse_stack_level_expression(
    pandemonium_pluginscript_language_data *p_data,
    int p_level,
    const pandemonium_string *p_expression,
    int p_max_subitems,
    int p_max_depth
) with gil:
    cdef pandemonium_string ret
    pyobj_to_pandemonium_string("Nothing", &ret)
    return ret


cdef api void pythonscript_get_public_functions(
    pandemonium_pluginscript_language_data *p_data,
    pandemonium_array *r_functions
) with gil:
    pass


cdef api void pythonscript_get_public_constants(
    pandemonium_pluginscript_language_data *p_data,
    pandemonium_dictionary *r_constants
) with gil:
    pass
