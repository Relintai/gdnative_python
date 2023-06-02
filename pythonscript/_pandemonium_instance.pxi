# cython: c_string_type=unicode, c_string_encoding=utf8

from libc.stddef cimport wchar_t
from cpython cimport Py_INCREF, Py_DECREF, PyObject

from pandemoniummonium._hazmat.gdnative_api_struct cimport (
    pandemonium_string,
    pandemonium_string_name,
    pandemonium_bool,
    pandemonium_array,
    pandemonium_pool_string_array,
    pandemonium_object,
    pandemonium_variant,
    pandemonium_variant_call_error,
    pandemonium_method_rpc_mode,
    pandemonium_pluginscript_script_data,
    pandemonium_pluginscript_instance_data,
    pandemonium_variant_call_error_error,
    pandemonium_variant_type,
)
from pandemoniummonium._hazmat.gdapi cimport pythonscript_gdapi10 as gdapi10
from pandemoniummonium._hazmat.conversion cimport (
    pandemonium_variant_to_pyobj,
    pyobj_to_pandemonium_variant,
    pandemonium_string_name_to_pyobj,
)


cdef api pandemonium_pluginscript_instance_data* pythonscript_instance_init(
    pandemonium_pluginscript_script_data *p_data,
    pandemonium_object *p_owner
) with gil:
    cdef object instance = (<object>p_data)()
    (<Object>instance)._gd_ptr = p_owner
    Py_INCREF(instance)
    return <void *>instance


cdef api void pythonscript_instance_finish(
    pandemonium_pluginscript_instance_data *p_data
) with gil:
    Py_DECREF(<object>p_data)


cdef api pandemonium_bool pythonscript_instance_set_prop(
    pandemonium_pluginscript_instance_data *p_data,
    const pandemonium_string *p_name,
    const pandemonium_variant *p_value
) with gil:
    cdef object instance = <object>p_data
    cdef str key = pandemonium_string_to_pyobj(p_name)

    # Should look among properties added by the script and it parents,
    # not Pandemonium native properties that are handled by the caller
    try:
        field = instance.__exported[key]
    except KeyError:
        return False
    if not isinstance(field, ExportedField):
        return False

    try:
        setattr(instance, key, pandemonium_variant_to_pyobj(p_value))
        return True
    except Exception:
        traceback.print_exc()
        return False


cdef api pandemonium_bool pythonscript_instance_get_prop(
    pandemonium_pluginscript_instance_data *p_data,
    const pandemonium_string *p_name,
    pandemonium_variant *r_ret
) with gil:
    cdef object instance = <object>p_data
    cdef object ret
    cdef object field
    cdef str key = pandemonium_string_to_pyobj(p_name)

    # Should look among properties added by the script and it parents,
    # not Pandemonium native properties that are handled by the caller
    try:
        field = instance.__exported[key]
    except KeyError:
        return False

    try:
        if isinstance(field, ExportedField):
            ret = getattr(instance, pandemonium_string_to_pyobj(p_name))
            pyobj_to_pandemonium_variant(ret, r_ret)
        elif isinstance(field, SignalField):
            # TODO: Not sure how to create a Variant::Signal from GDNative
            return False
        else:
            # TODO: Not sure how to create a Variant::Callable from GDNative
            return False
        return True

    except Exception:
        traceback.print_exc()
        return False


cdef api pandemonium_variant pythonscript_instance_call_method(
    pandemonium_pluginscript_instance_data *p_data,
    const pandemonium_string_name *p_method,
    const pandemonium_variant **p_args,
    int p_argcount,
    pandemonium_variant_call_error *r_error
) with gil:
    cdef pandemonium_variant var_ret
    cdef object instance = <object>p_data
    cdef object fn
    cdef str key = pandemonium_string_name_to_pyobj(p_method)

    # TODO: optimize this by caching pandemonium_string_name -> method lookup
    fn = instance.__exported.get(key)
    if not callable(fn):
        r_error.error = pandemonium_variant_call_error_error.PANDEMONIUM_CALL_ERROR_CALL_ERROR_INVALID_METHOD
        gdapi10.pandemonium_variant_new_nil(&var_ret)
        return var_ret

    cdef int i
    cdef list pyargs
    cdef object ret
    try:
        pyargs = [pandemonium_variant_to_pyobj(p_args[i]) for i in range(p_argcount)]
        ret = fn(instance, *pyargs)
        r_error.error = pandemonium_variant_call_error_error.PANDEMONIUM_CALL_ERROR_CALL_OK
        pyobj_to_pandemonium_variant(ret, &var_ret)
        return var_ret

    except NotImplementedError:
        r_error.error = pandemonium_variant_call_error_error.PANDEMONIUM_CALL_ERROR_CALL_ERROR_INVALID_METHOD

    except TypeError:
        traceback.print_exc()
        # TODO: handle errors here
        r_error.error = pandemonium_variant_call_error_error.PANDEMONIUM_CALL_ERROR_CALL_ERROR_INVALID_ARGUMENT
        r_error.argument = 1
        r_error.expected = pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_NIL
    except Exception:
        traceback.print_exc()
        r_error.error = pandemonium_variant_call_error_error.PANDEMONIUM_CALL_ERROR_CALL_ERROR_INVALID_METHOD

    # TODO: also catch other exceptions types ?

    # Something bad occured, return a default None variant
    gdapi10.pandemonium_variant_new_nil(&var_ret)
    return var_ret


cdef api void pythonscript_instance_notification(
    pandemonium_pluginscript_instance_data *p_data,
    int p_notification
) with gil:
    cdef object instance = <object>p_data
    # Pandemonium's notification should call all parent `_notification`
    # methods (better not use `super()._notification` in those methods...)
    # TODO: cache the methods to call ?
    for parentcls in instance.__class__.__mro__:
        try:
            fn = parentcls.__exported["_notification"]
        except (AttributeError, KeyError):
            pass
        else:
            fn(instance, p_notification)


# Useful ?

# cdef api void pythonscript_instance_refcount_incremented(
#     pandemonium_pluginscript_instance_data *p_data
# ) with gil:
#     pass


# cdef api bool pythonscript_instance_refcount_decremented(
#     pandemonium_pluginscript_instance_data *p_data
# ) with gil:
#     pass
