{%- block pxd_header %}
{% endblock -%}
{%- block pyx_header %}

# TODO

{{ force_mark_rendered("pandemonium_transform_affine_invert") }}
{{ force_mark_rendered("pandemonium_transform_interpolate_with") }}
{{ force_mark_rendered("pandemonium_transform_inverse_xform") }}
{{ force_mark_rendered("pandemonium_transform_invert") }}
{{ force_mark_rendered("pandemonium_transform_is_equal_approx") }}
{{ force_mark_rendered("pandemonium_transform_orthogonalize") }}
{{ force_mark_rendered("pandemonium_transform_orthogonalized") }}
{{ force_mark_rendered("pandemonium_transform_orthonormalize") }}
{{ force_mark_rendered("pandemonium_transform_rotate") }}
{{ force_mark_rendered("pandemonium_transform_rotate_basis") }}
{{ force_mark_rendered("pandemonium_transform_rotate_local") }}
{{ force_mark_rendered("pandemonium_transform_rotated_local") }}
{{ force_mark_rendered("pandemonium_transform_scale") }}
{{ force_mark_rendered("pandemonium_transform_scale_basis") }}
{{ force_mark_rendered("pandemonium_transform_scaled_local") }}
{{ force_mark_rendered("pandemonium_transform_set") }}
{{ force_mark_rendered("pandemonium_transform_set_look_at") }}
{{ force_mark_rendered("pandemonium_transform_spherical_interpolate_with") }}
{{ force_mark_rendered("pandemonium_transform_translate_localr") }}
{{ force_mark_rendered("pandemonium_transform_translate_localv") }}
{{ force_mark_rendered("pandemonium_transform_translated_local") }}
{{ force_mark_rendered("pandemonium_transform_xform_fast") }}
{{ force_mark_rendered("pandemonium_transform_xform_inv_fast") }}
{{ force_mark_rendered("pandemonium_transform_xform_inv_pool_vector2") }}
{{ force_mark_rendered("pandemonium_transform_xform_inv_pool_vector2i") }}
{{ force_mark_rendered("pandemonium_transform_xform_inv_pool_vector3") }}
{{ force_mark_rendered("pandemonium_transform_xform_inv_pool_vector3i") }}
{{ force_mark_rendered("pandemonium_transform_xform_inv_vector3i") }}
{{ force_mark_rendered("pandemonium_transform_xform_pool_vector2") }}
{{ force_mark_rendered("pandemonium_transform_xform_pool_vector2i") }}
{{ force_mark_rendered("pandemonium_transform_xform_pool_vector3") }}
{{ force_mark_rendered("pandemonium_transform_xform_pool_vector3i") }}
{{ force_mark_rendered("pandemonium_transform_xform_vector3i") }}

# END TODO

{% endblock -%}


@cython.final
cdef class Transform:
{% block cdef_attributes %}
    cdef pandemonium_transform _gd_data
{% endblock %}

{% block python_defs %}
    def __init__(self, x_axis=None, y_axis=None, z_axis=None, origin=None):
        if x_axis is None and y_axis is None and z_axis is None and origin is None:
            {{ force_mark_rendered("pandemonium_transform_new_identity") }}
            gdapi10.pandemonium_transform_new_identity(&self._gd_data)
        else:
            {{ force_mark_rendered("pandemonium_transform_new_with_axis_origin") }}
            gdapi10.pandemonium_transform_new_with_axis_origin(
                &self._gd_data,
                &(<Vector3?>x_axis)._gd_data,
                &(<Vector3?>y_axis)._gd_data,
                &(<Vector3?>z_axis)._gd_data,
                &(<Vector3?>origin)._gd_data,
            )

    @staticmethod
    def from_basis_origin(Basis basis not None, Vector3 origin not None):
        cdef Transform ret = Transform.__new__(Transform)
        {{ force_mark_rendered("pandemonium_transform_new") }}
        gdapi10.pandemonium_transform_new(&ret._gd_data, &basis._gd_data, &origin._gd_data)
        return ret

    @staticmethod
    def from_quaternion(Quaternion quat not None):
        cdef Transform ret = Transform.__new__(Transform)
        {{ force_mark_rendered("pandemonium_transform_new_with_quaternion") }}
        gdapi11.pandemonium_transform_new_with_quaternion(&ret._gd_data, &quat._gd_data)
        return ret

    def __repr__(Transform self):
        return f"<Transform({self.as_string()})>"

    {{ render_operator_eq() | indent }}
    {{ render_operator_ne() | indent }}

    {{ render_method("operator_multiply", py_name="__mul__") | indent }}

    {{ render_property("basis", getter="get_basis", setter="set_basis") | indent }}
    {{ render_property("origin", getter="get_origin", setter="set_origin") | indent }}

    {{ render_method("as_string") | indent }}
    {{ render_method("inverse") | indent }}
    {{ render_method("affine_inverse") | indent }}
    {{ render_method("orthonormalized") | indent }}
    {{ render_method("rotated") | indent }}
    {{ render_method("scaled") | indent }}
    {{ render_method("translated") | indent }}
    {{ render_method("looking_at") | indent }}
    {{ render_method("xform_plane") | indent }}
    {{ render_method("xform_inv_plane") | indent }}
    {{ render_method("xform_vector3") | indent }}
    {{ render_method("xform_inv_vector3") | indent }}
    {{ render_method("xform_aabb") | indent }}
    {{ render_method("xform_inv_aabb") | indent }}
{% endblock %}

{%- block python_consts %}
    IDENTITY = Transform(Vector3(1, 0, 0), Vector3(0, 1, 0), Vector3(0, 0, 1), Vector3(0, 0, 0))
    FLIP_X = Transform(Vector3(-1, 0, 0), Vector3(0, 1, 0), Vector3(0, 0, 1), Vector3(0, 0, 0))
    FLIP_Y = Transform(Vector3(1, 0, 0), Vector3(0, -1, 0), Vector3(0, 0, 1), Vector3(0, 0, 0))
    FLIP_Z = Transform(Vector3(1, 0, 0), Vector3(0, 1, 0), Vector3(0, 0, -1), Vector3(0, 0, 0))
{% endblock %}
