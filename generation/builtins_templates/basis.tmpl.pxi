{%- block pxd_header -%}
{%- endblock -%}
{%- block pyx_header -%}

# TODO

{{ force_mark_rendered("pandemonium_basis_diagonalize") }}
{{ force_mark_rendered("pandemonium_basis_from_scale") }}
{{ force_mark_rendered("pandemonium_basis_from_z") }}
{{ force_mark_rendered("pandemonium_basis_get_axis_angle") }}
{{ force_mark_rendered("pandemonium_basis_get_column") }}
{{ force_mark_rendered("pandemonium_basis_get_euler_xyz") }}
{{ force_mark_rendered("pandemonium_basis_get_euler_xzy") }}
{{ force_mark_rendered("pandemonium_basis_get_euler_yxz") }}
{{ force_mark_rendered("pandemonium_basis_get_euler_yzx") }}
{{ force_mark_rendered("pandemonium_basis_get_euler_zxy") }}
{{ force_mark_rendered("pandemonium_basis_get_euler_zyx") }}
{{ force_mark_rendered("pandemonium_basis_get_main_diagonal") }}
{{ force_mark_rendered("pandemonium_basis_get_normal_xform_basis") }}
{{ force_mark_rendered("pandemonium_basis_get_rotation") }}
{{ force_mark_rendered("pandemonium_basis_get_rotation_axis_angle") }}
{{ force_mark_rendered("pandemonium_basis_get_rotation_axis_angle_local") }}
{{ force_mark_rendered("pandemonium_basis_get_rotation_euler") }}
{{ force_mark_rendered("pandemonium_basis_get_rotation_quaternion") }}
{{ force_mark_rendered("pandemonium_basis_get_scale_abs") }}
{{ force_mark_rendered("pandemonium_basis_get_scale_local") }}
{{ force_mark_rendered("pandemonium_basis_get_uniform_scale") }}
{{ force_mark_rendered("pandemonium_basis_invert") }}
{{ force_mark_rendered("pandemonium_basis_is_diagonal") }}
{{ force_mark_rendered("pandemonium_basis_is_equal_approx") }}
{{ force_mark_rendered("pandemonium_basis_is_equal_approx_ratio") }}
{{ force_mark_rendered("pandemonium_basis_is_equal_approx_ratio_eps") }}
{{ force_mark_rendered("pandemonium_basis_is_orthogonal") }}
{{ force_mark_rendered("pandemonium_basis_is_rotation") }}
{{ force_mark_rendered("pandemonium_basis_is_symmetric") }}
{{ force_mark_rendered("pandemonium_basis_lerp") }}
{{ force_mark_rendered("pandemonium_basis_looking_at") }}
{{ force_mark_rendered("pandemonium_basis_looking_at_up") }}
{{ force_mark_rendered("pandemonium_basis_make_scale_uniform") }}
{{ force_mark_rendered("pandemonium_basis_new_axis_phi_scale") }}
{{ force_mark_rendered("pandemonium_basis_new_euler_scale") }}
{{ force_mark_rendered("pandemonium_basis_new_floats") }}
{{ force_mark_rendered("pandemonium_basis_new_quaternion_scale") }}
{{ force_mark_rendered("pandemonium_basis_orthogonalize") }}
{{ force_mark_rendered("pandemonium_basis_orthogonalized") }}
{{ force_mark_rendered("pandemonium_basis_orthonormalize") }}
{{ force_mark_rendered("pandemonium_basis_rotate") }}
{{ force_mark_rendered("pandemonium_basis_rotate_euler") }}
{{ force_mark_rendered("pandemonium_basis_rotate_local") }}
{{ force_mark_rendered("pandemonium_basis_rotate_quat") }}
{{ force_mark_rendered("pandemonium_basis_rotate_sh") }}
{{ force_mark_rendered("pandemonium_basis_rotate_to_align") }}
{{ force_mark_rendered("pandemonium_basis_rotated_euler") }}
{{ force_mark_rendered("pandemonium_basis_rotated_local") }}
{{ force_mark_rendered("pandemonium_basis_rotated_quat") }}
{{ force_mark_rendered("pandemonium_basis_rotatedq") }}
{{ force_mark_rendered("pandemonium_basis_rotatedv") }}
{{ force_mark_rendered("pandemonium_basis_rotateq") }}
{{ force_mark_rendered("pandemonium_basis_rotatev") }}
{{ force_mark_rendered("pandemonium_basis_rotref_posscale_decomposition") }}
{{ force_mark_rendered("pandemonium_basis_scale") }}
{{ force_mark_rendered("pandemonium_basis_scale_local") }}
{{ force_mark_rendered("pandemonium_basis_scale_orthogonal") }}
{{ force_mark_rendered("pandemonium_basis_scaled_local") }}
{{ force_mark_rendered("pandemonium_basis_scaled_orthogonal") }}
{{ force_mark_rendered("pandemonium_basis_set_axis_angle") }}
{{ force_mark_rendered("pandemonium_basis_set_column") }}
{{ force_mark_rendered("pandemonium_basis_set_columns") }}
{{ force_mark_rendered("pandemonium_basis_set_diagonal") }}
{{ force_mark_rendered("pandemonium_basis_set_euler") }}
{{ force_mark_rendered("pandemonium_basis_set_euler_xyz") }}
{{ force_mark_rendered("pandemonium_basis_set_euler_xzy") }}
{{ force_mark_rendered("pandemonium_basis_set_euler_yxz") }}
{{ force_mark_rendered("pandemonium_basis_set_euler_yzx") }}
{{ force_mark_rendered("pandemonium_basis_set_euler_zxy") }}
{{ force_mark_rendered("pandemonium_basis_set_euler_zyx") }}
{{ force_mark_rendered("pandemonium_basis_set_orthogonal_index") }}
{{ force_mark_rendered("pandemonium_basis_set_real") }}
{{ force_mark_rendered("pandemonium_basis_set_vector3") }}
{{ force_mark_rendered("pandemonium_basis_set_zero") }}
{{ force_mark_rendered("pandemonium_basis_transpose") }}
{{ force_mark_rendered("pandemonium_basis_transpose_xform") }}
{{ force_mark_rendered("pandemonium_basis_xform_inv_v3i") }}
{{ force_mark_rendered("pandemonium_basis_xform_normal") }}
{{ force_mark_rendered("pandemonium_basis_xform_normal_fast") }}
{{ force_mark_rendered("pandemonium_basis_xform_v3i") }}

# END TODO

cdef inline Basis Basis_multiply(Basis self, Basis b):
    cdef Basis ret  = Basis.__new__(Basis)
    {{ force_mark_rendered("pandemonium_basis_operator_multiply") }}
    ret._gd_data = gdapi10.pandemonium_basis_operator_multiply(&self._gd_data, &b._gd_data)
    return ret

cdef inline Basis Basis_multiply_scalar(Basis self, pandemonium_real b):
    cdef Basis ret  = Basis.__new__(Basis)
    {{ force_mark_rendered("pandemonium_basis_operator_multiply_scalar") }}
    ret._gd_data = gdapi10.pandemonium_basis_operator_multiply_scalar(&self._gd_data, b)
    return ret

{%- endblock %}

@cython.final
cdef class Basis:
{% block cdef_attributes %}
    cdef pandemonium_basis _gd_data
{% endblock %}

{% block python_defs %}
    def __init__(self, Vector3 x not None=Vector3.RIGHT, Vector3 y not None=Vector3.UP, Vector3 z not None=Vector3.BACK):
        {{ force_mark_rendered("pandemonium_basis_new") }} {# We always use the `with_rows` version #}
        {{ force_mark_rendered("pandemonium_basis_new_with_rows") }}
        gdapi10.pandemonium_basis_new_with_rows(&self._gd_data, &(<Vector3>x)._gd_data, &(<Vector3>y)._gd_data, &(<Vector3>z)._gd_data)

    @staticmethod
    def from_euler(from_):
        cdef Basis ret = Basis.__new__(Basis)
        try:
            {{ force_mark_rendered("pandemonium_basis_new_with_euler") }}
            gdapi10.pandemonium_basis_new_with_euler(&ret._gd_data, &(<Vector3?>from_)._gd_data)
            return ret
        except TypeError:
            pass
        try:
            {{ force_mark_rendered("pandemonium_basis_new_with_euler_quaternion") }}
            gdapi10.pandemonium_basis_new_with_euler_quaternion(&ret._gd_data, &(<Quaternion?>from_)._gd_data)
            return ret
        except TypeError:
            raise TypeError('`from_` must be Quaternion or Vector3')

    @staticmethod
    def from_axis_angle(Vector3 axis not None, phi):
        cdef Basis ret = Basis.__new__(Basis)
        {{ force_mark_rendered("pandemonium_basis_new_with_axis_and_angle") }}
        gdapi10.pandemonium_basis_new_with_axis_and_angle(&ret._gd_data, &axis._gd_data, phi)
        return ret

    def __repr__(self):
        return f"<Basis({self.as_string()})>"

    @property
    def x(Basis self) -> Vector3:
        cdef Vector3 ret = Vector3.__new__(Vector3)
        {{ force_mark_rendered("pandemonium_basis_get_axis") }}
        ret._gd_data = gdapi10.pandemonium_basis_get_axis(&self._gd_data, 0)
        return ret

    @x.setter
    def x(Basis self, Vector3 val not None) -> None:
        {{ force_mark_rendered("pandemonium_basis_set_axis") }}
        gdapi10.pandemonium_basis_set_axis(&self._gd_data, 0, &val._gd_data)

    @property
    def y(Basis self) -> Vector3:
        cdef Vector3 ret = Vector3.__new__(Vector3)
        {{ force_mark_rendered("pandemonium_basis_get_axis") }}
        ret._gd_data = gdapi10.pandemonium_basis_get_axis(&self._gd_data, 1)
        return ret

    @y.setter
    def y(Basis self, Vector3 val not None) -> None:
        {{ force_mark_rendered("pandemonium_basis_set_axis") }}
        gdapi10.pandemonium_basis_set_axis(&self._gd_data, 1, &val._gd_data)

    @property
    def z(Basis self) -> Vector3:
        cdef Vector3 ret = Vector3.__new__(Vector3)
        {{ force_mark_rendered("pandemonium_basis_get_axis") }}
        ret._gd_data = gdapi10.pandemonium_basis_get_axis(&self._gd_data, 2)
        return ret

    @z.setter
    def z(Basis self, Vector3 val not None) -> None:
        {{ force_mark_rendered("pandemonium_basis_set_axis") }}
        gdapi10.pandemonium_basis_set_axis(&self._gd_data, 2, &val._gd_data)

    {{ render_operator_eq() | indent }}
    {{ render_operator_ne() | indent }}

    {{ render_method("operator_add", py_name="__add__") | indent }}
    {{ render_method("operator_subtract", py_name="__sub__") | indent }}

    def __mul__(Basis self, val):
        cdef Basis _val

        try:
            _val = <Basis?>val

        except TypeError:
            return Basis_multiply_scalar(self, val)

        else:
            return Basis_multiply(self, _val)

    {{ render_method("as_string") | indent }}
    {{ render_method("inverse") | indent }}
    {{ render_method("transposed") | indent }}
    {{ render_method("orthonormalized") | indent }}
    {{ render_method("determinant") | indent }}
    {{ render_method("rotated") | indent }}
    {{ render_method("scaled") | indent }}
    {{ render_method("get_scale") | indent }}
    {{ render_method("get_euler") | indent }}
    {{ render_method("get_quaternion") | indent }}
    {{ render_method("set_quaternion") | indent }}
    {{ render_method("set_axis_angle_scale") | indent }}
    {{ render_method("set_euler_scale") | indent }}
    {{ render_method("set_quaternion_scale") | indent }}
    {{ render_method("tdotx") | indent }}
    {{ render_method("tdoty") | indent }}
    {{ render_method("tdotz") | indent }}
    {{ render_method("xform") | indent }}
    {{ render_method("xform_inv") | indent }}
    {{ render_method("get_orthogonal_index") | indent }}
    {{ render_method("get_elements") | indent }}
    {{ render_method("get_row") | indent }}
    {{ render_method("set_row") | indent }}
    {{ render_method("slerp") | indent }}
{% endblock %}
