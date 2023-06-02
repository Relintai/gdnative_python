# Describe all base types (i.e. scalar such as int and Pandemonium builtins)

from dataclasses import dataclass


@dataclass
class TypeSpec:
    # Type used within Pandemonium api.json
    gdapi_type: str
    # Type used when calling C api functions
    c_type: str
    # Type used in Cython, basically similar to c_type for scalars&enums
    # and to py_type for Pandemonium objects&builtins
    cy_type: str
    # TODO: typing should be divided between argument and return (e.g. `Union[str, NodePath]` vs `NodePath`)
    # Type used for PEP 484 Python typing
    py_type: str = ""
    # Type is a Pandemonium object (i.e. defined in api.json)
    is_object: bool = False
    # Type is a Pandemonium builtin (e.g. Vector2)
    is_builtin: bool = False
    # Type is a scalar (e.g. int, float) or void
    is_base_type: bool = False
    # Type doesn't use the heap (hence no need for freeing it)
    is_stack_only: bool = False
    # Type is an enum (e.g. pandemonium_error, Camera::KeepAspect)
    is_enum: bool = False

    @property
    def is_void(self) -> bool:
        return self.c_type == "void"

    @property
    def is_variant(self) -> bool:
        return self.c_type == "pandemonium_variant"

    def __post_init__(self):
        self.py_type = self.py_type or self.cy_type
        if self.is_object:
            assert not self.is_builtin
            assert not self.is_base_type
            assert not self.is_stack_only
        if self.is_builtin:
            assert not self.is_base_type


# Base types
TYPE_VOID = TypeSpec(
    gdapi_type="void", c_type="void", cy_type="None", is_base_type=True, is_stack_only=True
)
TYPE_BOOL = TypeSpec(
    gdapi_type="bool",
    c_type="pandemonium_bool",
    cy_type="bint",
    py_type="bool",
    is_base_type=True,
    is_stack_only=True,
)
TYPE_INT = TypeSpec(
    gdapi_type="int", c_type="pandemonium_int", cy_type="int", is_base_type=True, is_stack_only=True
)
TYPE_FLOAT = TypeSpec(
    gdapi_type="float", c_type="pandemonium_real", cy_type="float", is_base_type=True, is_stack_only=True
)
TYPE_ERROR = TypeSpec(
    gdapi_type="enum.Error",
    c_type="pandemonium_error",
    cy_type="pandemonium_error",
    py_type="Error",
    is_base_type=True,
    is_stack_only=True,
    is_enum=True,
)
TYPE_VECTOR2_AXIS = TypeSpec(
    gdapi_type="enum.Vector2::Axis",
    c_type="pandemonium_vector2_axis",
    cy_type="pandemonium_vector2_axis",
    py_type="Vector2.Axis",
    is_base_type=True,
    is_stack_only=True,
    is_enum=True,
)
TYPE_VECTOR2I_AXIS = TypeSpec(
    gdapi_type="enum.Vector2i::Axis",
    c_type="pandemonium_vector2i_axis",
    cy_type="pandemonium_vector2i_axis",
    py_type="Vector2i.Axis",
    is_base_type=True,
    is_stack_only=True,
    is_enum=True,
)
TYPE_VECTOR3_AXIS = TypeSpec(
    gdapi_type="enum.Vector3::Axis",
    c_type="pandemonium_vector3_axis",
    cy_type="pandemonium_vector3_axis",
    py_type="Vector3.Axis",
    is_base_type=True,
    is_stack_only=True,
    is_enum=True,
)
TYPE_VECTOR3I_AXIS = TypeSpec(
    gdapi_type="enum.Vector3i::Axis",
    c_type="pandemonium_vector3i_axis",
    cy_type="pandemonium_vector3i_axis",
    py_type="Vector3i.Axis",
    is_base_type=True,
    is_stack_only=True,
    is_enum=True,
)
TYPE_VECTOR4_AXIS = TypeSpec(
    gdapi_type="enum.Vector4::Axis",
    c_type="pandemonium_vector4_axis",
    cy_type="pandemonium_vector4_axis",
    py_type="Vector4.Axis",
    is_base_type=True,
    is_stack_only=True,
    is_enum=True,
)
TYPE_VECTOR4I_AXIS = TypeSpec(
    gdapi_type="enum.Vector4i::Axis",
    c_type="pandemonium_vector4i_axis",
    cy_type="pandemonium_vector4i_axis",
    py_type="Vector4i.Axis",
    is_base_type=True,
    is_stack_only=True,
    is_enum=True,
)
TYPE_PROJECTION_PLANES = TypeSpec(
    gdapi_type="enum.Projection::Planes",
    c_type="pandemonium_projection_planes",
    cy_type="pandemonium_projection_planes",
    py_type="Projection.Planes",
    is_base_type=True,
    is_stack_only=True,
    is_enum=True,
)
TYPE_VARIANT_TYPE = TypeSpec(
    gdapi_type="enum.Variant::Type",
    c_type="pandemonium_variant_type",
    cy_type="pandemonium_variant_type",
    py_type="VariantType",
    is_base_type=True,
    is_stack_only=True,
    is_enum=True,
)
TYPE_VARIANT_OPERATOR = TypeSpec(
    gdapi_type="enum.Variant::Operator",
    c_type="pandemonium_variant_operator",
    cy_type="pandemonium_variant_operator",
    py_type="VariantOperator",
    is_base_type=True,
    is_stack_only=True,
    is_enum=True,
)

# Stack&heap types
TYPE_VARIANT = TypeSpec(
    gdapi_type="Variant", c_type="pandemonium_variant", cy_type="object", is_builtin=True
)
TYPE_STRING = TypeSpec(
    gdapi_type="String",
    c_type="pandemonium_string",
    cy_type="GDString",
    py_type="Union[str, GDString]",
    is_builtin=True,
)

# Stack only types
TYPE_AABB = TypeSpec(
    gdapi_type="AABB", c_type="pandemonium_aabb", cy_type="AABB", is_builtin=True, is_stack_only=True
)
TYPE_ARRAY = TypeSpec(
    gdapi_type="Array", c_type="pandemonium_array", cy_type="Array", is_builtin=True, is_stack_only=True
)
TYPE_BASIS = TypeSpec(
    gdapi_type="Basis", c_type="pandemonium_basis", cy_type="Basis", is_builtin=True, is_stack_only=True
)
TYPE_COLOR = TypeSpec(
    gdapi_type="Color", c_type="pandemonium_color", cy_type="Color", is_builtin=True, is_stack_only=True
)
TYPE_DICTIONARY = TypeSpec(
    gdapi_type="Dictionary",
    c_type="pandemonium_dictionary",
    cy_type="Dictionary",
    is_builtin=True,
    is_stack_only=True,
)
TYPE_NODEPATH = TypeSpec(
    gdapi_type="NodePath",
    c_type="pandemonium_node_path",
    cy_type="NodePath",
    py_type="Union[str, NodePath]",
    is_builtin=True,
    is_stack_only=True,
)
TYPE_STRING_NAME = TypeSpec(
    gdapi_type="StringName",
    c_type="pandemonium_string_name",
    cy_type="StringName",
    py_type="Union[str, StringName]",
    is_builtin=True,
    is_stack_only=True,
)
TYPE_PLANE = TypeSpec(
    gdapi_type="Plane", c_type="pandemonium_plane", cy_type="Plane", is_builtin=True, is_stack_only=True
)
TYPE_QUAT = TypeSpec(
    gdapi_type="Quat", c_type="pandemonium_quat", cy_type="Quat", is_builtin=True, is_stack_only=True
)
TYPE_RECT2 = TypeSpec(
    gdapi_type="Rect2", c_type="pandemonium_rect2", cy_type="Rect2", is_builtin=True, is_stack_only=True
)
TYPE_RECT2I = TypeSpec(
    gdapi_type="Rect2i", c_type="pandemonium_rect2i", cy_type="Rect2i", is_builtin=True, is_stack_only=True
)
TYPE_RID = TypeSpec(
    gdapi_type="RID", c_type="pandemonium_rid", cy_type="RID", is_builtin=True, is_stack_only=True
)
TYPE_TRANSFORM = TypeSpec(
    gdapi_type="Transform",
    c_type="pandemonium_transform",
    cy_type="Transform",
    is_builtin=True,
    is_stack_only=True,
)
TYPE_TRANSFORM2D = TypeSpec(
    gdapi_type="Transform2D",
    c_type="pandemonium_transform2d",
    cy_type="Transform2D",
    is_builtin=True,
    is_stack_only=True,
)
TYPE_PROJECTION = TypeSpec(
    gdapi_type="Projection",
    c_type="pandemonium_projection",
    cy_type="Projection",
    is_builtin=True,
    is_stack_only=True,
)
TYPE_VECTOR2 = TypeSpec(
    gdapi_type="Vector2",
    c_type="pandemonium_vector2",
    cy_type="Vector2",
    is_builtin=True,
    is_stack_only=True,
)
TYPE_VECTOR2I = TypeSpec(
    gdapi_type="Vector2i",
    c_type="pandemonium_vector2i",
    cy_type="Vector2i",
    is_builtin=True,
    is_stack_only=True,
)
TYPE_VECTOR3 = TypeSpec(
    gdapi_type="Vector3",
    c_type="pandemonium_vector3",
    cy_type="Vector3",
    is_builtin=True,
    is_stack_only=True,
)
TYPE_VECTOR3I = TypeSpec(
    gdapi_type="Vector3i",
    c_type="pandemonium_vector3i",
    cy_type="Vector3i",
    is_builtin=True,
    is_stack_only=True,
)
TYPE_VECTOR4 = TypeSpec(
    gdapi_type="Vector4",
    c_type="pandemonium_vector4",
    cy_type="Vector4",
    is_builtin=True,
    is_stack_only=True,
)
TYPE_VECTOR4I = TypeSpec(
    gdapi_type="Vector4i",
    c_type="pandemonium_vector4i",
    cy_type="Vector4i",
    is_builtin=True,
    is_stack_only=True,
)
TYPE_POOLBYTEARRAY = TypeSpec(
    gdapi_type="PoolByteArray",
    c_type="pandemonium_pool_byte_array",
    cy_type="PoolByteArray",
    is_builtin=True,
    is_stack_only=True,
)
TYPE_POOLINTARRAY = TypeSpec(
    gdapi_type="PoolIntArray",
    c_type="pandemonium_pool_int_array",
    cy_type="PoolIntArray",
    is_builtin=True,
    is_stack_only=True,
)
TYPE_POOLREALARRAY = TypeSpec(
    gdapi_type="PoolRealArray",
    c_type="pandemonium_pool_real_array",
    cy_type="PoolRealArray",
    is_builtin=True,
    is_stack_only=True,
)
TYPE_POOLSTRINGARRAY = TypeSpec(
    gdapi_type="PoolStringArray",
    c_type="pandemonium_pool_string_array",
    cy_type="PoolStringArray",
    is_builtin=True,
    is_stack_only=True,
)
TYPE_POOLVECTOR2ARRAY = TypeSpec(
    gdapi_type="PoolVector2Array",
    c_type="pandemonium_pool_vector2_array",
    cy_type="PoolVector2Array",
    is_builtin=True,
    is_stack_only=True,
)
TYPE_POOLVECTOR2IARRAY = TypeSpec(
    gdapi_type="PoolVector2iArray",
    c_type="pandemonium_pool_vector2i_array",
    cy_type="PoolVector2iArray",
    is_builtin=True,
    is_stack_only=True,
)
TYPE_POOLVECTOR3ARRAY = TypeSpec(
    gdapi_type="PoolVector3Array",
    c_type="pandemonium_pool_vector3_array",
    cy_type="PoolVector3Array",
    is_builtin=True,
    is_stack_only=True,
)
TYPE_POOLVECTOR3IARRAY = TypeSpec(
    gdapi_type="PoolVector3iArray",
    c_type="pandemonium_pool_vector3i_array",
    cy_type="PoolVector3iArray",
    is_builtin=True,
    is_stack_only=True,
)
TYPE_POOLVECTOR4ARRAY = TypeSpec(
    gdapi_type="PoolVector4Array",
    c_type="pandemonium_pool_vector4_array",
    cy_type="PoolVector4Array",
    is_builtin=True,
    is_stack_only=True,
)
TYPE_POOLVECTOR4IARRAY = TypeSpec(
    gdapi_type="PoolVector4iArray",
    c_type="pandemonium_pool_vector4i_array",
    cy_type="PoolVector4iArray",
    is_builtin=True,
    is_stack_only=True,
)
TYPE_POOLCOLORARRAY = TypeSpec(
    gdapi_type="PoolColorArray",
    c_type="pandemonium_pool_color_array",
    cy_type="PoolColorArray",
    is_builtin=True,
    is_stack_only=True,
)


ALL_TYPES_EXCEPT_OBJECTS = [
    TYPE_VOID,
    TYPE_BOOL,
    TYPE_INT,
    TYPE_FLOAT,
    TYPE_ERROR,
    TYPE_VECTOR2_AXIS,
    TYPE_VECTOR2I_AXIS,
    TYPE_VECTOR3_AXIS,
    TYPE_VECTOR3I_AXIS,
    TYPE_VECTOR4_AXIS,
    TYPE_VECTOR4I_AXIS,
    TYPE_PROJECTION_PLANES,
    TYPE_VARIANT_TYPE,
    TYPE_VARIANT_OPERATOR,
    TYPE_VARIANT,
    TYPE_STRING,
    TYPE_AABB,
    TYPE_ARRAY,
    TYPE_BASIS,
    TYPE_COLOR,
    TYPE_DICTIONARY,
    TYPE_NODEPATH,
    TYPE_STRING_NAME,
    TYPE_PLANE,
    TYPE_QUAT,
    TYPE_RECT2,
    TYPE_RECT2I,
    TYPE_RID,
    TYPE_TRANSFORM,
    TYPE_TRANSFORM2D,
    TYPE_PROJECTION,
    TYPE_VECTOR2,
    TYPE_VECTOR2I,
    TYPE_VECTOR3,
    TYPE_VECTOR3I,
    TYPE_VECTOR4,
    TYPE_VECTOR4I,
    TYPE_POOLBYTEARRAY,
    TYPE_POOLINTARRAY,
    TYPE_POOLREALARRAY,
    TYPE_POOLSTRINGARRAY,
    TYPE_POOLVECTOR2ARRAY,
    TYPE_POOLVECTOR2IARRAY,
    TYPE_POOLVECTOR3ARRAY,
    TYPE_POOLVECTOR3IARRAY,
    TYPE_POOLVECTOR4ARRAY,
    TYPE_POOLVECTOR4IARRAY,
    TYPE_POOLCOLORARRAY,
]
