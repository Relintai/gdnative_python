from libc.stddef cimport wchar_t
from libc.stdio cimport printf

from pandemonium._hazmat.gdapi cimport pythonscript_gdapi10 as gdapi10
from pandemonium._hazmat.gdnative_api_struct cimport (
    pandemonium_string,
    pandemonium_string_name,
    pandemonium_int,
    pandemonium_vector2,
    pandemonium_variant,
    pandemonium_variant_type,
)
from pandemonium.builtins cimport GDString, NodePath


# Strings are now char32_t
# TODO remove this id everything works
# Pandemonium string are basically a vector of wchar_t, each wchar_t representing
# a single unicode character (i.e. there is no surrogates support).
# The sad part is wchar_t is not portable: it is 16bits long on Windows and
# 32bits long on Linux and MacOS...
# So we end up with a UCS2 encoding on Windows and UCS4 everywhere else :'(
#IF UNAME_SYSNAME == "Windows":
#    # Specify endianess otherwise `encode` appends a BOM at the start of the converted string
#    DEF _STRING_ENCODING = "UTF-16-LE"
#    DEF _STRING_CODEPOINT_LENGTH = 2
#ELSE:
DEF _STRING_ENCODING = "UTF-32-LE"
DEF _STRING_CODEPOINT_LENGTH = 4


cdef inline str pandemonium_string_to_pyobj(const pandemonium_string *p_gdstr):
    # TODO: unicode&windows support is most likely broken...
    cdef char *raw = <char*>gdapi10.pandemonium_string_wide_str(p_gdstr)
    cdef pandemonium_int length = gdapi10.pandemonium_string_length(p_gdstr)
    return raw[:length * _STRING_CODEPOINT_LENGTH].decode(_STRING_ENCODING)

    # cdef char *raw = <char*>gdapi10.pandemonium_string_wide_str(p_gdstr)
    # cdef pandemonium_int length = gdapi10.pandemonium_string_length(p_gdstr)
    # printf("==========> pandemonium_string_to_pyobj ")
    # cdef int i
    # for i in range(length):
    #     printf("%c ", raw[i * 4]);
    # printf("\n")
    # cdef object ret = raw[:length * _STRING_CODEPOINT_LENGTH].decode(_STRING_ENCODING)
    # print('==>ret: %r' % ret)
    # return ret


cdef inline void pyobj_to_pandemonium_string(str pystr, pandemonium_string *p_gdstr):
    # TODO: unicode&windows support is most likely broken...
    cdef bytes raw = pystr.encode(_STRING_ENCODING)
    gdapi10.pandemonium_string_new_with_wide_string(
        p_gdstr, (<wchar_t*><char*>raw), len(pystr)
    )


cdef inline str pandemonium_string_name_to_pyobj(const pandemonium_string_name *p_gdname):
    cdef pandemonium_string strname = gdapi10.pandemonium_string_name_get_name(p_gdname)
    cdef ret = pandemonium_string_to_pyobj(&strname)
    gdapi10.pandemonium_string_destroy(&strname)
    return ret


cdef inline void pyobj_to_pandemonium_string_name(str pystr, pandemonium_string_name *p_gdname):
    cdef pandemonium_string strname
    pyobj_to_pandemonium_string(pystr, &strname)
    gdapi10.pandemonium_string_name_new(p_gdname, &strname)
    gdapi10.pandemonium_string_destroy(&strname)


cdef object pandemonium_variant_to_pyobj(const pandemonium_variant *p_gdvar)
cdef bint pyobj_to_pandemonium_variant(object pyobj, pandemonium_variant *p_var)

cdef bint is_pytype_compatible_with_pandemonium_variant(object pytype)
cdef object pandemonium_type_to_pytype(pandemonium_variant_type gdtype)
cdef pandemonium_variant_type pytype_to_pandemonium_type(object pytype)

cdef GDString ensure_is_gdstring(object gdstring_or_pystr)
cdef NodePath ensure_is_nodepath(object nodepath_or_pystr)


# TODO: finish this...

# cdef inline object cook_slice(slice slice_, pandemonium_int size, pandemonium_int *r_start, pandemonium_int *r_stop, pandemonium_int *r_step, pandemonium_int *r_items):
#     cdef pandemonium_int start
#     cdef pandemonium_int stop
#     cdef pandemonium_int step

#     step = slice_.step if slice_.step is not None else 1
#     if step == 0:
#         raise ValueError("range() arg 3 must not be zero")
#     elif step > 0:
#         start = slice_.start if slice_.start is not None else 0
#         stop = slice_.stop if slice_.stop is not None else size
#     else:
#         start = slice_.start if slice_.start is not None else size
#         stop = slice_.stop if slice_.stop is not None else -size - 1

#     r_start[0] = cook_slice_start(size, start)
#     r_stop[0] = cook_slice_stop(size, stop)
#     r_step[0] = step
#     r_items[0] = cook_slice_get_items(size, start, stop, step)

#     return None


# cdef inline pandemonium_int cook_slice_start(pandemonium_int size, pandemonium_int start):
#     if start > size - 1:
#         return size - 1
#     elif start < 0:
#         start += size
#         if start < 0:
#             return 0
#     return start


# cdef inline pandemonium_int cook_slice_stop(pandemonium_int size, pandemonium_int stop):
#     if stop > size:
#         return size
#     elif stop < -size:
#         return -1
#     elif stop < 0:
#         stop += size
#     return stop


# cdef inline pandemonium_int cook_slice_get_items(pandemonium_int size, pandemonium_int start, pandemonium_int stop, pandemonium_int step):
#     cdef pandemonium_int items
#     if step > 0:
#         if start >= stop:
#             return 0
#         items = 1 + (stop - start - 1) // step
#     else:
#         if start <= stop:
#             return 0
#         items = 1 + (stop - start + 1) // step
#     return items if items > 0 else 0
