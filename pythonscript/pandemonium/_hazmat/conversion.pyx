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
from pandemonium.bindings cimport Object
from pandemonium.builtins cimport (
    Vector2,
    Vector2i,
    Rect2,
    Rect2i,
    Vector3,
    Vector3i,
    Vector4,
    Vector4i,
    Transform2D,
    Plane,
    Quaternion,
    AABB,
    Basis,
    Transform,
    Projection,
    Color,
    NodePath,
    StringName,
    RID,
    Dictionary,
    Array,
    GDString,
    PoolByteArray,
    PoolIntArray,
    PoolRealArray,
    PoolStringArray,
    PoolVector2Array,
    PoolVector2iArray,
    PoolVector3Array,
    PoolVector3iArray,
    PoolVector4Array,
    PoolVector4iArray,
    PoolColorArray,
)

from warnings import warn


GD_PY_TYPES = (
    (pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_NIL, type(None)),
    (pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_BOOL, bool),
    (pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_INT, int),
    (pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_REAL, float),
    (pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_STRING, GDString),
    (pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_OBJECT, Object),
    (pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_VECTOR2, Vector2),
    (pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_VECTOR2I, Vector2i),
    (pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_RECT2, Rect2),
    (pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_RECT2I, Rect2i),
    (pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_VECTOR3, Vector3),
    (pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_VECTOR3I, Vector3i),
    (pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_VECTOR4, Vector4),
    (pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_VECTOR4I, Vector4i),
    (pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_TRANSFORM2D, Transform2D),
    (pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_PLANE, Plane),
    (pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_QUATERNION, Quaternion),
    (pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_AABB, AABB),
    (pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_BASIS, Basis),
    (pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_TRANSFORM, Transform),
    (pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_PROJECTION, Projection),
    (pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_COLOR, Color),
    (pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_NODE_PATH, NodePath),
    (pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_STRING_NAME, StringName),
    (pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_RID, RID),
    (pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_DICTIONARY, Dictionary),
    (pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_ARRAY, Array),
    (
        pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_POOL_BYTE_ARRAY,
        PoolByteArray,
    ),
    (pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_POOL_INT_ARRAY, PoolIntArray),
    (
        pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_POOL_REAL_ARRAY,
        PoolRealArray,
    ),
    (pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_POOL_STRING_ARRAY, PoolStringArray),
    (
        pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_POOL_VECTOR2_ARRAY,
        PoolVector2Array,
    ),
    (
        pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_POOL_VECTOR2I_ARRAY,
        PoolVector2iArray,
    ),
    (
        pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_POOL_VECTOR3_ARRAY,
        PoolVector3Array,
    ),
    (
        pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_POOL_VECTOR3I_ARRAY,
        PoolVector3iArray,
    ),
    (
        pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_POOL_VECTOR4_ARRAY,
        PoolVector4Array,
    ),
    (
        pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_POOL_VECTOR4I_ARRAY,
        PoolVector4iArray,
    ),
    (
        pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_POOL_COLOR_ARRAY,
        PoolColorArray,
    ),
)


cdef bint is_pytype_compatible_with_pandemonium_variant(object pytype):
    return next((True for _, py in GD_PY_TYPES if py == pytype), issubclass(pytype, Object))


cdef object pandemonium_type_to_pytype(pandemonium_variant_type gdtype):
    cdef pytype = next((py for gd, py in GD_PY_TYPES if gd == gdtype), None)
    if pytype is None:
        warn(f"No Python equivalent for Pandemonium type `{gdtype}`")
        return None

    return pytype


cdef pandemonium_variant_type pytype_to_pandemonium_type(object pytype):
    cdef gdtype = next((gd for gd, py in GD_PY_TYPES if py == pytype), None)
    if gdtype is None:
        if issubclass(pytype, Object):
            return pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_OBJECT
        else:
            warn(f"No Pandemonium equivalent for Python type `{pytype}`")
            return pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_NIL

    return gdtype


cdef object pandemonium_variant_to_pyobj(const pandemonium_variant *p_gdvar):
    cdef pandemonium_variant_type gdtype = gdapi10.pandemonium_variant_get_type(p_gdvar)

    if gdtype == pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_NIL:
        return None

    elif gdtype == pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_BOOL:
        return bool(gdapi10.pandemonium_variant_as_bool(p_gdvar))

    elif gdtype == pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_INT:
        return int(gdapi10.pandemonium_variant_as_int(p_gdvar))

    elif gdtype == pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_REAL:
        return float(gdapi10.pandemonium_variant_as_real(p_gdvar))

    elif gdtype == pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_STRING:
        return _pandemonium_variant_to_pyobj_string(p_gdvar)

    elif gdtype == pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_VECTOR2:
        return _pandemonium_variant_to_pyobj_vector2(p_gdvar)

    elif gdtype == pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_VECTOR2I:
        return _pandemonium_variant_to_pyobj_vector2i(p_gdvar)

    elif gdtype == pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_RECT2:
        return _pandemonium_variant_to_pyobj_rect2(p_gdvar)

    elif gdtype == pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_RECT2I:
        return _pandemonium_variant_to_pyobj_rect2i(p_gdvar)

    elif gdtype == pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_VECTOR3:
        return _pandemonium_variant_to_pyobj_vector3(p_gdvar)

    elif gdtype == pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_VECTOR3I:
        return _pandemonium_variant_to_pyobj_vector3i(p_gdvar)

    elif gdtype == pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_VECTOR4:
        return _pandemonium_variant_to_pyobj_vector4(p_gdvar)

    elif gdtype == pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_VECTOR4I:
        return _pandemonium_variant_to_pyobj_vector4i(p_gdvar)

    elif gdtype == pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_TRANSFORM2D:
        return _pandemonium_variant_to_pyobj_transform2d(p_gdvar)

    elif gdtype == pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_PLANE:
        return _pandemonium_variant_to_pyobj_plane(p_gdvar)

    elif gdtype == pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_QUATERNION:
        return _pandemonium_variant_to_pyobj_quat(p_gdvar)

    elif gdtype == pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_AABB:
        return _pandemonium_variant_to_pyobj_aabb(p_gdvar)

    elif gdtype == pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_BASIS:
        return _pandemonium_variant_to_pyobj_basis(p_gdvar)

    elif gdtype == pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_TRANSFORM:
        return _pandemonium_variant_to_pyobj_transform(p_gdvar)

    elif gdtype == pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_PROJECTION:
        return _pandemonium_variant_to_pyobj_projection(p_gdvar)

    elif gdtype == pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_COLOR:
        return _pandemonium_variant_to_pyobj_color(p_gdvar)

    elif gdtype == pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_NODE_PATH:
        return _pandemonium_variant_to_pyobj_node_path(p_gdvar)

    elif gdtype == pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_STRING_NAME:
        return _pandemonium_variant_to_pyobj_string_name(p_gdvar)

    elif gdtype == pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_RID:
        return _pandemonium_variant_to_pyobj_rid(p_gdvar)

    elif gdtype == pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_OBJECT:
        return _pandemonium_variant_to_pyobj_object(p_gdvar)

    elif gdtype == pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_DICTIONARY:
        return _pandemonium_variant_to_pyobj_dictionary(p_gdvar)

    elif gdtype == pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_ARRAY:
        return _pandemonium_variant_to_pyobj_array(p_gdvar)

    elif gdtype == pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_POOL_BYTE_ARRAY:
        return _pandemonium_variant_to_pyobj_pool_byte_array(p_gdvar)

    elif gdtype == pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_POOL_INT_ARRAY:
        return _pandemonium_variant_to_pyobj_pool_int_array(p_gdvar)

    elif gdtype == pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_POOL_REAL_ARRAY:
        return _pandemonium_variant_to_pyobj_pool_real_array(p_gdvar)

    elif gdtype == pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_POOL_STRING_ARRAY:
        return _pandemonium_variant_to_pyobj_pool_string_array(p_gdvar)

    elif gdtype == pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_POOL_VECTOR2_ARRAY:
        return _pandemonium_variant_to_pyobj_pool_vector2_array(p_gdvar)

    elif gdtype == pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_POOL_VECTOR2I_ARRAY:
        return _pandemonium_variant_to_pyobj_pool_vector2i_array(p_gdvar)

    elif gdtype == pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_POOL_VECTOR3_ARRAY:
        return _pandemonium_variant_to_pyobj_pool_vector3_array(p_gdvar)

    elif gdtype == pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_POOL_VECTOR3I_ARRAY:
        return _pandemonium_variant_to_pyobj_pool_vector3i_array(p_gdvar)

    elif gdtype == pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_POOL_VECTOR4_ARRAY:
        return _pandemonium_variant_to_pyobj_pool_vector4_array(p_gdvar)

    elif gdtype == pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_POOL_VECTOR4I_ARRAY:
        return _pandemonium_variant_to_pyobj_pool_vector4i_array(p_gdvar)

    elif gdtype == pandemonium_variant_type.PANDEMONIUM_VARIANT_TYPE_POOL_COLOR_ARRAY:
        return _pandemonium_variant_to_pyobj_pool_color_array(p_gdvar)

    else:
        warn(f"Unknown Variant type `{gdtype}` (this should never happen !)")
        return None


cdef inline GDString _pandemonium_variant_to_pyobj_string(const pandemonium_variant *p_gdvar):
    cdef GDString ret = GDString.__new__(GDString)
    ret._gd_data = gdapi10.pandemonium_variant_as_string(p_gdvar)
    return ret


cdef inline Vector2 _pandemonium_variant_to_pyobj_vector2(const pandemonium_variant *p_gdvar):
    cdef Vector2 ret = Vector2.__new__(Vector2)
    ret._gd_data = gdapi10.pandemonium_variant_as_vector2(p_gdvar)
    return ret

cdef inline Vector2i _pandemonium_variant_to_pyobj_vector2i(const pandemonium_variant *p_gdvar):
    cdef Vector2i ret = Vector2i.__new__(Vector2i)
    ret._gd_data = gdapi10.pandemonium_variant_as_vector2i(p_gdvar)
    return ret

cdef inline Rect2 _pandemonium_variant_to_pyobj_rect2(const pandemonium_variant *p_gdvar):
    cdef Rect2 ret = Rect2.__new__(Rect2)
    ret._gd_data = gdapi10.pandemonium_variant_as_rect2(p_gdvar)
    return ret

cdef inline Rect2i _pandemonium_variant_to_pyobj_rect2i(const pandemonium_variant *p_gdvar):
    cdef Rect2i ret = Rect2i.__new__(Rect2i)
    ret._gd_data = gdapi10.pandemonium_variant_as_rect2i(p_gdvar)
    return ret

cdef inline Vector3 _pandemonium_variant_to_pyobj_vector3(const pandemonium_variant *p_gdvar):
    cdef Vector3 ret = Vector3.__new__(Vector3)
    ret._gd_data = gdapi10.pandemonium_variant_as_vector3(p_gdvar)
    return ret

cdef inline Vector3i _pandemonium_variant_to_pyobj_vector3i(const pandemonium_variant *p_gdvar):
    cdef Vector3i ret = Vector3i.__new__(Vector3i)
    ret._gd_data = gdapi10.pandemonium_variant_as_vector3i(p_gdvar)
    return ret

cdef inline Vector4 _pandemonium_variant_to_pyobj_vector4(const pandemonium_variant *p_gdvar):
    cdef Vector4 ret = Vector4.__new__(Vector4)
    ret._gd_data = gdapi10.pandemonium_variant_as_vector4(p_gdvar)
    return ret

cdef inline Vector4i _pandemonium_variant_to_pyobj_vector4i(const pandemonium_variant *p_gdvar):
    cdef Vector4i ret = Vector4i.__new__(Vector4i)
    ret._gd_data = gdapi10.pandemonium_variant_as_vector4i(p_gdvar)
    return ret

cdef inline Transform2D _pandemonium_variant_to_pyobj_transform2d(const pandemonium_variant *p_gdvar):
    cdef Transform2D ret = Transform2D.__new__(Transform2D)
    ret._gd_data = gdapi10.pandemonium_variant_as_transform2d(p_gdvar)
    return ret


cdef inline Transform _pandemonium_variant_to_pyobj_transform(const pandemonium_variant *p_gdvar):
    cdef Transform ret = Transform.__new__(Transform)
    ret._gd_data = gdapi10.pandemonium_variant_as_transform(p_gdvar)
    return ret

cdef inline Projection _pandemonium_variant_to_pyobj_projection(const pandemonium_variant *p_gdvar):
    cdef Projection ret = Projection.__new__(Projection)
    ret._gd_data = gdapi10.pandemonium_variant_as_projection(p_gdvar)
    return ret

cdef inline Plane _pandemonium_variant_to_pyobj_plane(const pandemonium_variant *p_gdvar):
    cdef Plane ret = Plane.__new__(Plane)
    ret._gd_data = gdapi10.pandemonium_variant_as_plane(p_gdvar)
    return ret


cdef inline Quaternion _pandemonium_variant_to_pyobj_quat(const pandemonium_variant *p_gdvar):
    cdef Quaternion ret = Quaternion.__new__(Quaternion)
    ret._gd_data = gdapi10.pandemonium_variant_as_quaternion(p_gdvar)
    return ret


cdef inline AABB _pandemonium_variant_to_pyobj_aabb(const pandemonium_variant *p_gdvar):
    cdef AABB ret = AABB.__new__(AABB)
    ret._gd_data = gdapi10.pandemonium_variant_as_aabb(p_gdvar)
    return ret


cdef inline Basis _pandemonium_variant_to_pyobj_basis(const pandemonium_variant *p_gdvar):
    cdef Basis ret = Basis.__new__(Basis)
    ret._gd_data = gdapi10.pandemonium_variant_as_basis(p_gdvar)
    return ret


cdef inline Color _pandemonium_variant_to_pyobj_color(const pandemonium_variant *p_gdvar):
    cdef Color ret = Color.__new__(Color)
    ret._gd_data = gdapi10.pandemonium_variant_as_color(p_gdvar)
    return ret


cdef inline NodePath _pandemonium_variant_to_pyobj_node_path(const pandemonium_variant *p_gdvar):
    cdef NodePath ret = NodePath.__new__(NodePath)
    ret._gd_data = gdapi10.pandemonium_variant_as_node_path(p_gdvar)
    return ret

cdef inline StringName _pandemonium_variant_to_pyobj_string_name(const pandemonium_variant *p_gdvar):
    cdef StringName ret = StringName.__new__(StringName)
    ret._gd_data = gdapi10.pandemonium_variant_as_string_name(p_gdvar)
    return ret

cdef inline RID _pandemonium_variant_to_pyobj_rid(const pandemonium_variant *p_gdvar):
    cdef RID ret = RID.__new__(RID)
    ret._gd_data = gdapi10.pandemonium_variant_as_rid(p_gdvar)
    return ret


cdef inline Object _pandemonium_variant_to_pyobj_object(const pandemonium_variant *p_gdvar):
    # TODO: This conversion relies on pandemonium String and lookup into bindings
    # modules, wouldn't it be better to create a `ObjectFromVariant` lazy
    # class instead ?
    return Object.cast_from_variant(p_gdvar)


cdef inline Dictionary _pandemonium_variant_to_pyobj_dictionary(const pandemonium_variant *p_gdvar):
    cdef Dictionary d = Dictionary.__new__(Dictionary)
    d._gd_data = gdapi10.pandemonium_variant_as_dictionary(p_gdvar)
    return d


cdef inline Array _pandemonium_variant_to_pyobj_array(const pandemonium_variant *p_gdvar):
    cdef Array a = Array.__new__(Array)
    a._gd_data = gdapi10.pandemonium_variant_as_array(p_gdvar)
    return a


cdef inline PoolByteArray _pandemonium_variant_to_pyobj_pool_byte_array(const pandemonium_variant *p_gdvar):
    cdef PoolByteArray a = PoolByteArray.__new__(PoolByteArray)
    a._gd_data = gdapi10.pandemonium_variant_as_pool_byte_array(p_gdvar)
    return a


cdef inline PoolIntArray _pandemonium_variant_to_pyobj_pool_int_array(const pandemonium_variant *p_gdvar):
    cdef PoolIntArray a = PoolIntArray.__new__(PoolIntArray)
    a._gd_data = gdapi10.pandemonium_variant_as_pool_int_array(p_gdvar)
    return a


cdef inline PoolRealArray _pandemonium_variant_to_pyobj_pool_real_array(const pandemonium_variant *p_gdvar):
    cdef PoolRealArray a = PoolRealArray.__new__(PoolRealArray)
    a._gd_data = gdapi10.pandemonium_variant_as_pool_real_array(p_gdvar)
    return a


cdef inline PoolStringArray _pandemonium_variant_to_pyobj_pool_string_array(const pandemonium_variant *p_gdvar):
    cdef PoolStringArray a = PoolStringArray.__new__(PoolStringArray)
    a._gd_data = gdapi10.pandemonium_variant_as_pool_string_array(p_gdvar)
    return a


cdef inline PoolVector2Array _pandemonium_variant_to_pyobj_pool_vector2_array(const pandemonium_variant *p_gdvar):
    cdef PoolVector2Array a = PoolVector2Array.__new__(PoolVector2Array)
    a._gd_data = gdapi10.pandemonium_variant_as_pool_vector2_array(p_gdvar)
    return a

cdef inline PoolVector2iArray _pandemonium_variant_to_pyobj_pool_vector2i_array(const pandemonium_variant *p_gdvar):
    cdef PoolVector2iArray a = PoolVector2iArray.__new__(PoolVector2iArray)
    a._gd_data = gdapi10.pandemonium_variant_as_pool_vector2i_array(p_gdvar)
    return a

cdef inline PoolVector3Array _pandemonium_variant_to_pyobj_pool_vector3_array(const pandemonium_variant *p_gdvar):
    cdef PoolVector3Array a = PoolVector3Array.__new__(PoolVector3Array)
    a._gd_data = gdapi10.pandemonium_variant_as_pool_vector3_array(p_gdvar)
    return a

cdef inline PoolVector3iArray _pandemonium_variant_to_pyobj_pool_vector3i_array(const pandemonium_variant *p_gdvar):
    cdef PoolVector3iArray a = PoolVector3iArray.__new__(PoolVector3iArray)
    a._gd_data = gdapi10.pandemonium_variant_as_pool_vector3i_array(p_gdvar)
    return a

cdef inline PoolVector4Array _pandemonium_variant_to_pyobj_pool_vector4_array(const pandemonium_variant *p_gdvar):
    cdef PoolVector4Array a = PoolVector4Array.__new__(PoolVector4Array)
    a._gd_data = gdapi10.pandemonium_variant_as_pool_vector4_array(p_gdvar)
    return a

cdef inline PoolVector4iArray _pandemonium_variant_to_pyobj_pool_vector4i_array(const pandemonium_variant *p_gdvar):
    cdef PoolVector4iArray a = PoolVector4iArray.__new__(PoolVector4iArray)
    a._gd_data = gdapi10.pandemonium_variant_as_pool_vector4i_array(p_gdvar)
    return a

cdef inline PoolColorArray _pandemonium_variant_to_pyobj_pool_color_array(const pandemonium_variant *p_gdvar):
    cdef PoolColorArray a = PoolColorArray.__new__(PoolColorArray)
    a._gd_data = gdapi10.pandemonium_variant_as_pool_color_array(p_gdvar)
    return a


cdef bint pyobj_to_pandemonium_variant(object pyobj, pandemonium_variant *p_var):
    if pyobj is None:
        gdapi10.pandemonium_variant_new_nil(p_var)
    elif isinstance(pyobj, bool):
        gdapi10.pandemonium_variant_new_bool(p_var, pyobj)
    elif isinstance(pyobj, int):
        gdapi10.pandemonium_variant_new_int(p_var, pyobj)
    elif isinstance(pyobj, float):
        gdapi10.pandemonium_variant_new_real(p_var, pyobj)
    elif isinstance(pyobj, str):
        _pyobj_to_pandemonium_variant_convert_string(pyobj, p_var)
    elif isinstance(pyobj, GDString):
        gdapi10.pandemonium_variant_new_string(p_var, &(<GDString>pyobj)._gd_data)
    elif isinstance(pyobj, Vector2):
        gdapi10.pandemonium_variant_new_vector2(p_var, &(<Vector2>pyobj)._gd_data)
    elif isinstance(pyobj, Vector2i):
        gdapi10.pandemonium_variant_new_vector2i(p_var, &(<Vector2i>pyobj)._gd_data)
    elif isinstance(pyobj, Vector3):
        gdapi10.pandemonium_variant_new_vector3(p_var, &(<Vector3>pyobj)._gd_data)
    elif isinstance(pyobj, Vector3i):
        gdapi10.pandemonium_variant_new_vector3i(p_var, &(<Vector3i>pyobj)._gd_data)
    elif isinstance(pyobj, Vector4):
        gdapi10.pandemonium_variant_new_vector4(p_var, &(<Vector4>pyobj)._gd_data)
    elif isinstance(pyobj, Vector4i):
        gdapi10.pandemonium_variant_new_vector4i(p_var, &(<Vector4i>pyobj)._gd_data)
    elif isinstance(pyobj, Plane):
        gdapi10.pandemonium_variant_new_plane(p_var, &(<Plane>pyobj)._gd_data)
    elif isinstance(pyobj, Quaternion):
        gdapi10.pandemonium_variant_new_quaternion(p_var, &(<Quaternion>pyobj)._gd_data)
    elif isinstance(pyobj, AABB):
        gdapi10.pandemonium_variant_new_aabb(p_var, &(<AABB>pyobj)._gd_data)
    elif isinstance(pyobj, Basis):
        gdapi10.pandemonium_variant_new_basis(p_var, &(<Basis>pyobj)._gd_data)
    elif isinstance(pyobj, Color):
        gdapi10.pandemonium_variant_new_color(p_var, &(<Color>pyobj)._gd_data)
    elif isinstance(pyobj, NodePath):
        gdapi10.pandemonium_variant_new_node_path(p_var, &(<NodePath>pyobj)._gd_data)
    elif isinstance(pyobj, StringName):
        gdapi10.pandemonium_variant_new_string_name(p_var, &(<StringName>pyobj)._gd_data)
    elif isinstance(pyobj, RID):
        gdapi10.pandemonium_variant_new_rid(p_var, &(<RID>pyobj)._gd_data)
    elif isinstance(pyobj, Rect2):
        gdapi10.pandemonium_variant_new_rect2(p_var, &(<Rect2>pyobj)._gd_data)
    elif isinstance(pyobj, Rect2i):
        gdapi10.pandemonium_variant_new_rect2i(p_var, &(<Rect2i>pyobj)._gd_data)
    elif isinstance(pyobj, Transform2D):
        gdapi10.pandemonium_variant_new_transform2d(p_var, &(<Transform2D>pyobj)._gd_data)
    elif isinstance(pyobj, Transform):
        gdapi10.pandemonium_variant_new_transform(p_var, &(<Transform>pyobj)._gd_data)
    elif isinstance(pyobj, Projection):
        gdapi10.pandemonium_variant_new_projection(p_var, &(<Projection>pyobj)._gd_data)
    elif isinstance(pyobj, Dictionary):
        gdapi10.pandemonium_variant_new_dictionary(p_var, &(<Dictionary>pyobj)._gd_data)
    elif isinstance(pyobj, Array):
        gdapi10.pandemonium_variant_new_array(p_var, &(<Array>pyobj)._gd_data)
    elif isinstance(pyobj, PoolByteArray):
        gdapi10.pandemonium_variant_new_pool_byte_array(p_var, &(<PoolByteArray>pyobj)._gd_data)
    elif isinstance(pyobj, PoolIntArray):
        gdapi10.pandemonium_variant_new_pool_int_array(p_var, &(<PoolIntArray>pyobj)._gd_data)
    elif isinstance(pyobj, PoolRealArray):
        gdapi10.pandemonium_variant_new_pool_real_array(p_var, &(<PoolRealArray>pyobj)._gd_data)
    elif isinstance(pyobj, PoolStringArray):
        gdapi10.pandemonium_variant_new_pool_string_array(p_var, &(<PoolStringArray>pyobj)._gd_data)
    elif isinstance(pyobj, PoolVector2Array):
        gdapi10.pandemonium_variant_new_pool_vector2_array(p_var, &(<PoolVector2Array>pyobj)._gd_data)
    elif isinstance(pyobj, PoolVector2iArray):
        gdapi10.pandemonium_variant_new_pool_vector2i_array(p_var, &(<PoolVector2iArray>pyobj)._gd_data)
    elif isinstance(pyobj, PoolVector3Array):
        gdapi10.pandemonium_variant_new_pool_vector3_array(p_var, &(<PoolVector3Array>pyobj)._gd_data)
    elif isinstance(pyobj, PoolVector3iArray):
        gdapi10.pandemonium_variant_new_pool_vector3i_array(p_var, &(<PoolVector3iArray>pyobj)._gd_data)
    elif isinstance(pyobj, PoolVector4Array):
        gdapi10.pandemonium_variant_new_pool_vector4_array(p_var, &(<PoolVector4Array>pyobj)._gd_data)
    elif isinstance(pyobj, PoolVector4iArray):
        gdapi10.pandemonium_variant_new_pool_vector4i_array(p_var, &(<PoolVector4iArray>pyobj)._gd_data)
    elif isinstance(pyobj, PoolColorArray):
        gdapi10.pandemonium_variant_new_pool_color_array(p_var, &(<PoolColorArray>pyobj)._gd_data)
    elif isinstance(pyobj, Object):
        gdapi10.pandemonium_variant_new_object(p_var, (<Object>pyobj)._gd_ptr)
    else:
        warn(f"Cannot convert `{type(pyobj)}` to Pandemonium's Variant")
        gdapi10.pandemonium_variant_new_nil(p_var)
        return False
    return True


# Needed to define gdstr in it own scope
cdef inline void _pyobj_to_pandemonium_variant_convert_string(object pyobj, pandemonium_variant *p_var):
    cdef pandemonium_string gdstr
    pyobj_to_pandemonium_string(pyobj, &gdstr)
    try:
        gdapi10.pandemonium_variant_new_string(p_var, &gdstr)
    finally:
        gdapi10.pandemonium_string_destroy(&gdstr)


cdef GDString ensure_is_gdstring(object gdstring_or_pystr):
    cdef GDString gdstring_converted
    try:
        return <GDString?>gdstring_or_pystr
    except TypeError:
        try:
            return GDString(gdstring_or_pystr)
        except TypeError:
            raise TypeError(f"Invalid value {gdstring_or_pystr!r}, must be str or GDString")


cdef NodePath ensure_is_nodepath(object nodepath_or_pystr):
    cdef NodePath NodePath_converted
    try:
        return <NodePath?>nodepath_or_pystr
    except TypeError:
        try:
            return NodePath(nodepath_or_pystr)
        except TypeError:
            raise TypeError(f"Invalid value {nodepath_or_pystr!r}, must be str or NodePath")

cdef StringName ensure_is_string_name(object string_name_or_pystr):
    cdef StringName StringName_converted
    try:
        return <StringName?>string_name_or_pystr
    except TypeError:
        try:
            return StringName(string_name_or_pystr)
        except TypeError:
            raise TypeError(f"Invalid value {string_name_or_pystr!r}, must be str or StringName")