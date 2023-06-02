{%- block pxd_header %}
{% endblock -%}
{%- block pyx_header %}

# TODO

{{ force_mark_rendered("pandemonium_vector4i_abs") }}
{{ force_mark_rendered("pandemonium_vector4i_clamp") }}
{{ force_mark_rendered("pandemonium_vector4i_get_w") }}
{{ force_mark_rendered("pandemonium_vector4i_get_x") }}
{{ force_mark_rendered("pandemonium_vector4i_get_y") }}
{{ force_mark_rendered("pandemonium_vector4i_get_z") }}
{{ force_mark_rendered("pandemonium_vector4i_length") }}
{{ force_mark_rendered("pandemonium_vector4i_length_squared") }}
{{ force_mark_rendered("pandemonium_vector4i_linear_interpolate") }}
{{ force_mark_rendered("pandemonium_vector4i_max_axis") }}
{{ force_mark_rendered("pandemonium_vector4i_min_axis") }}
{{ force_mark_rendered("pandemonium_vector4i_operator_divide_scalar") }}
{{ force_mark_rendered("pandemonium_vector4i_operator_divide_vector") }}
{{ force_mark_rendered("pandemonium_vector4i_operator_index") }}
{{ force_mark_rendered("pandemonium_vector4i_operator_index_const") }}
{{ force_mark_rendered("pandemonium_vector4i_operator_multiply_scalar") }}
{{ force_mark_rendered("pandemonium_vector4i_operator_multiply_vector") }}
{{ force_mark_rendered("pandemonium_vector4i_set_all") }}
{{ force_mark_rendered("pandemonium_vector4i_set_w") }}
{{ force_mark_rendered("pandemonium_vector4i_set_x") }}
{{ force_mark_rendered("pandemonium_vector4i_set_y") }}
{{ force_mark_rendered("pandemonium_vector4i_set_z") }}
{{ force_mark_rendered("pandemonium_vector4i_sign") }}
{{ force_mark_rendered("pandemonium_vector4i_to_vector4") }}
{{ force_mark_rendered("pandemonium_vector4i_zero") }}

# END TODO

from pandemonium._hazmat.gdnative_api_struct cimport pandemonium_vector4i_axis
{% endblock -%}


@cython.final
cdef class Vector4i:
{% block cdef_attributes %}
    cdef pandemonium_vector4i _gd_data
{% endblock %}

{% block python_defs %}
    def __init__(self, pandemonium_int x=0, pandemonium_int y=0, pandemonium_int z=0, pandemonium_int w=0):
        {{ force_mark_rendered("pandemonium_vector4i_new") }}
        gdapi10.pandemonium_vector4i_new(&self._gd_data, x, y, z, w)

    def __repr__(self):
        return f"<Vector4i(x={self.x}, y={self.y}, z={self.z})>"

    @property
    def x(self) -> pandemonium_int:
        {{ force_mark_rendered("pandemonium_vector4i_get_axis") }}
        return gdapi10.pandemonium_vector4i_get_axis(&self._gd_data, pandemonium_vector4i_axis.PANDEMONIUM_VECTOR4I_AXIS_X)

    @x.setter
    def x(self, pandemonium_int val) -> None:
        {{ force_mark_rendered("pandemonium_vector4i_set_axis") }}
        gdapi10.pandemonium_vector4i_set_axis(&self._gd_data, pandemonium_vector4i_axis.PANDEMONIUM_VECTOR4I_AXIS_X, val)

    @property
    def y(self) -> pandemonium_int:
        {{ force_mark_rendered("pandemonium_vector4i_get_axis") }}
        return gdapi10.pandemonium_vector4i_get_axis(&self._gd_data, pandemonium_vector4i_axis.PANDEMONIUM_VECTOR4I_AXIS_Y)

    @y.setter
    def y(self, pandemonium_int val) -> None:
        {{ force_mark_rendered("pandemonium_vector4i_set_axis") }}
        gdapi10.pandemonium_vector4i_set_axis(&self._gd_data, pandemonium_vector4i_axis.PANDEMONIUM_VECTOR4I_AXIS_Y, val)

    @property
    def z(self) -> pandemonium_int:
        {{ force_mark_rendered("pandemonium_vector4i_get_axis") }}
        return gdapi10.pandemonium_vector4i_get_axis(&self._gd_data, pandemonium_vector4i_axis.PANDEMONIUM_VECTOR4I_AXIS_Z)

    @z.setter
    def z(self, pandemonium_int val) -> None:
        {{ force_mark_rendered("pandemonium_vector4i_set_axis") }}
        gdapi10.pandemonium_vector4i_set_axis(&self._gd_data, pandemonium_vector4i_axis.PANDEMONIUM_VECTOR4I_AXIS_Z, val)

    {{ render_operator_eq() | indent }}
    {{ render_operator_ne() | indent }}
    {{ render_operator_lt() | indent }}

    {{ render_method("operator_neg", py_name="__neg__") | indent }}

    def __pos__(Vector4i self):
        return self

    {{ render_method("operator_add", py_name="__add__") | indent }}
    {{ render_method("operator_subtract", py_name="__sub__") | indent }}

    def __mul__(Vector4i self, val):
        cdef Vector4i _val
        try:
            _val = <Vector4i?>val
        except TypeError:
            return Vector4i_multiply_scalar(self, val)
        else:
            return Vector4i_multiply_vector(self, _val)

    def __truediv__(Vector4i self, val):
        cdef Vector4i _val
        try:
            _val = <Vector4i?>val
        except TypeError:
            if val is 0:
                raise ZeroDivisionError()
            return Vector4i_divide_scalar(self, val)
        else:
            if _val.x == 0 or _val.y == 0 or _val.z == 0:
                raise ZeroDivisionError()
            return Vector4i_divide_vector(self, _val)

    {{ render_method("as_string") | indent }}
{% endblock %}

{%- block python_consts %}
    AXIS = IntEnum("AXIS", {
        "X": pandemonium_vector4i_axis.PANDEMONIUM_VECTOR4I_AXIS_X,
        "Y": pandemonium_vector4i_axis.PANDEMONIUM_VECTOR4I_AXIS_Y,
        "Z": pandemonium_vector4i_axis.PANDEMONIUM_VECTOR4I_AXIS_Z,
        "W": pandemonium_vector4_axis.PANDEMONIUM_VECTOR4_AXIS_W,
    })
{% endblock %}
