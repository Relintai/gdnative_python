{%- block pxd_header %}
{% endblock -%}
{%- block pyx_header %}

# TODO

{{ force_mark_rendered("pandemonium_transform2d_affine_invert") }}
{{ force_mark_rendered("pandemonium_transform2d_basis_determinant") }}
{{ force_mark_rendered("pandemonium_transform2d_basis_scaled") }}
{{ force_mark_rendered("pandemonium_transform2d_basis_xform") }}
{{ force_mark_rendered("pandemonium_transform2d_basis_xform_inv") }}
{{ force_mark_rendered("pandemonium_transform2d_get_axis") }}
{{ force_mark_rendered("pandemonium_transform2d_get_column") }}
{{ force_mark_rendered("pandemonium_transform2d_get_skew") }}
{{ force_mark_rendered("pandemonium_transform2d_invert") }}
{{ force_mark_rendered("pandemonium_transform2d_is_equal_approx") }}
{{ force_mark_rendered("pandemonium_transform2d_looking_at") }}
{{ force_mark_rendered("pandemonium_transform2d_orthonormalize") }}
{{ force_mark_rendered("pandemonium_transform2d_rotate") }}
{{ force_mark_rendered("pandemonium_transform2d_rotated_local") }}
{{ force_mark_rendered("pandemonium_transform2d_scale") }}
{{ force_mark_rendered("pandemonium_transform2d_scale_basis") }}
{{ force_mark_rendered("pandemonium_transform2d_scaled_local") }}
{{ force_mark_rendered("pandemonium_transform2d_set_axis") }}
{{ force_mark_rendered("pandemonium_transform2d_set_column") }}
{{ force_mark_rendered("pandemonium_transform2d_set_origin") }}
{{ force_mark_rendered("pandemonium_transform2d_set_rotation") }}
{{ force_mark_rendered("pandemonium_transform2d_set_rotation_and_scale") }}
{{ force_mark_rendered("pandemonium_transform2d_set_rotation_scale_and_skew") }}
{{ force_mark_rendered("pandemonium_transform2d_set_scale") }}
{{ force_mark_rendered("pandemonium_transform2d_set_skew") }}
{{ force_mark_rendered("pandemonium_transform2d_tdotx") }}
{{ force_mark_rendered("pandemonium_transform2d_tdoty") }}
{{ force_mark_rendered("pandemonium_transform2d_translate_localr") }}
{{ force_mark_rendered("pandemonium_transform2d_translate_localv") }}
{{ force_mark_rendered("pandemonium_transform2d_translated_local") }}
{{ force_mark_rendered("pandemonium_transform2d_translater") }}
{{ force_mark_rendered("pandemonium_transform2d_translatev") }}
{{ force_mark_rendered("pandemonium_transform2d_untranslated") }}
{{ force_mark_rendered("pandemonium_transform2d_xform_inv_vector2i") }}
{{ force_mark_rendered("pandemonium_transform2d_xform_vector2i") }}

# END TODO

{% endblock -%}


@cython.final
cdef class Transform2D:
{% block cdef_attributes %}
    cdef pandemonium_transform2d _gd_data
{% endblock %}

{% block python_defs %}
    def __init__(self, x_axis=None, y_axis=None, origin=None):
        if x_axis is None and y_axis is None and origin is None:
            {{ force_mark_rendered("pandemonium_transform2d_new_identity") }}
            gdapi10.pandemonium_transform2d_new_identity(&self._gd_data)
        else:
            {{ force_mark_rendered("pandemonium_transform2d_new_axis_origin") }}
            gdapi10.pandemonium_transform2d_new_axis_origin(
                &self._gd_data,
                &(<Vector2?>x_axis)._gd_data,
                &(<Vector2?>y_axis)._gd_data,
                &(<Vector2?>origin)._gd_data,
            )

    @staticmethod
    def from_rot_pos(pandemonium_real rot, Vector2 pos not None):
        cdef Transform2D ret = Transform2D.__new__(Transform2D)
        {{ force_mark_rendered("pandemonium_transform2d_new") }}
        gdapi10.pandemonium_transform2d_new(&ret._gd_data, rot, &pos._gd_data)
        return ret

    def __repr__(Transform2D self):
        return f"<Transform2D({self.as_string()})>"

    {{ render_operator_eq() | indent }}
    {{ render_operator_ne() | indent }}

    {{ render_method("operator_multiply", py_name="__mul__") | indent }}

    # TODO: add axis properties once gdnative is updated
    {{ render_property("origin", getter="get_origin") | indent }}

    {{ render_method("as_string") | indent }}
    {{ render_method("inverse") | indent }}
    {{ render_method("affine_inverse") | indent }}
    {{ render_method("get_rotation") | indent }}
    {{ render_method("get_scale") | indent }}
    {{ render_method("orthonormalized") | indent }}
    {{ render_method("rotated") | indent }}
    {{ render_method("scaled") | indent }}
    {{ render_method("translated") | indent }}

    def xform(Transform2D self, v):
        cdef Vector2 ret_v2
        cdef Rect2 ret_r2
        try:
            ret_v2 = Vector2.__new__(Vector2)
            {{ force_mark_rendered("pandemonium_transform2d_xform_vector2") }}
            ret_v2._gd_data = gdapi10.pandemonium_transform2d_xform_vector2(&self._gd_data, &(<Vector2?>v)._gd_data)
            return ret_v2
        except TypeError:
            pass
        try:
            ret_r2 = Rect2.__new__(Rect2)
            {{ force_mark_rendered("pandemonium_transform2d_xform_rect2") }}
            ret_r2._gd_data = gdapi10.pandemonium_transform2d_xform_rect2(&self._gd_data, &(<Rect2?>v)._gd_data)
            return ret_r2
        except TypeError:
            raise TypeError("`v` must be Vector2 or Rect2")

    def xform_inv(Transform2D self, v):
        cdef Vector2 ret_v2
        cdef Rect2 ret_r2
        try:
            ret_v2 = Vector2.__new__(Vector2)
            {{ force_mark_rendered("pandemonium_transform2d_xform_inv_vector2") }}
            ret_v2._gd_data = gdapi10.pandemonium_transform2d_xform_inv_vector2(&self._gd_data, &(<Vector2?>v)._gd_data)
            return ret_v2
        except TypeError:
            pass
        try:
            ret_r2 = Rect2.__new__(Rect2)
            {{ force_mark_rendered("pandemonium_transform2d_xform_inv_rect2") }}
            ret_r2._gd_data = gdapi10.pandemonium_transform2d_xform_inv_rect2(&self._gd_data, &(<Rect2?>v)._gd_data)
            return ret_r2
        except TypeError:
            raise TypeError("`v` must be Vector2 or Rect2")

    {{ render_method("basis_xform_vector2", py_name="basis_xform") | indent }}
    {{ render_method("basis_xform_inv_vector2", py_name="basis_xform_inv") | indent }}
    {{ render_method("interpolate_with") | indent }}
{% endblock %}

{%- block python_consts %}
{% endblock %}
