{%- block pxd_header %}
{% endblock -%}
{%- block pyx_header %}
from pandemonium._hazmat.gdnative_api_struct cimport pandemonium_vector4_axis

import math
from enum import IntEnum


cdef inline Vector4_multiply_vector(Vector4 self, Vector4 b):
    cdef Vector4 ret  = Vector4.__new__(Vector4)
    {{ force_mark_rendered("pandemonium_vector4_operator_multiply_vector") }}
    ret._gd_data = gdapi10.pandemonium_vector4_operator_multiply_vector(&self._gd_data, &b._gd_data)
    return ret

cdef inline Vector4_multiply_scalar(Vector4 self, pandemonium_real b):
    cdef Vector4 ret  = Vector4.__new__(Vector4)
    {{ force_mark_rendered("pandemonium_vector4_operator_multiply_scalar") }}
    ret._gd_data = gdapi10.pandemonium_vector4_operator_multiply_scalar(&self._gd_data, b)
    return ret

cdef inline Vector4_divide_vector(Vector4 self, Vector4 b):
    cdef Vector4 ret  = Vector4.__new__(Vector4)
    {{ force_mark_rendered("pandemonium_vector4_operator_divide_vector") }}
    ret._gd_data = gdapi10.pandemonium_vector4_operator_divide_vector(&self._gd_data, &b._gd_data)
    return ret

cdef inline Vector4_divide_scalar(Vector4 self, pandemonium_real b):
    cdef Vector4 ret  = Vector4.__new__(Vector4)
    {{ force_mark_rendered("pandemonium_vector4_operator_divide_scalar") }}
    ret._gd_data = gdapi10.pandemonium_vector4_operator_divide_scalar(&self._gd_data, b)
    return ret

{% endblock -%}


@cython.final
cdef class Vector4:
{% block cdef_attributes %}
    cdef pandemonium_vector4 _gd_data
{% endblock %}

{% block python_defs %}
    def __init__(self, pandemonium_real x=0.0, pandemonium_real y=0.0, pandemonium_real z=0.0, pandemonium_real w=0.0):
        {{ force_mark_rendered("pandemonium_vector4_new") }}
        gdapi10.pandemonium_vector4_new(&self._gd_data, x, y, z, w)

    def __repr__(self):
        return f"<Vector4(x={self.x}, y={self.y}, z={self.z})>"

    @property
    def x(self) -> pandemonium_real:
        {{ force_mark_rendered("pandemonium_vector4_get_axis") }}
        return gdapi10.pandemonium_vector4_get_axis(&self._gd_data, pandemonium_vector4_axis.PANDEMONIUM_VECTOR4_AXIS_X)

    @x.setter
    def x(self, pandemonium_real val) -> None:
        {{ force_mark_rendered("pandemonium_vector4_set_axis") }}
        gdapi10.pandemonium_vector4_set_axis(&self._gd_data, pandemonium_vector4_axis.PANDEMONIUM_VECTOR4_AXIS_X, val)

    @property
    def y(self) -> pandemonium_real:
        {{ force_mark_rendered("pandemonium_vector4_get_axis") }}
        return gdapi10.pandemonium_vector4_get_axis(&self._gd_data, pandemonium_vector4_axis.PANDEMONIUM_VECTOR4_AXIS_Y)

    @y.setter
    def y(self, pandemonium_real val) -> None:
        {{ force_mark_rendered("pandemonium_vector4_set_axis") }}
        gdapi10.pandemonium_vector4_set_axis(&self._gd_data, pandemonium_vector4_axis.PANDEMONIUM_VECTOR4_AXIS_Y, val)

    @property
    def z(self) -> pandemonium_real:
        {{ force_mark_rendered("pandemonium_vector4_get_axis") }}
        return gdapi10.pandemonium_vector4_get_axis(&self._gd_data, pandemonium_vector4_axis.PANDEMONIUM_VECTOR4_AXIS_Z)

    @z.setter
    def z(self, pandemonium_real val) -> None:
        {{ force_mark_rendered("pandemonium_vector4_set_axis") }}
        gdapi10.pandemonium_vector4_set_axis(&self._gd_data, pandemonium_vector4_axis.PANDEMONIUM_VECTOR4_AXIS_Z, val)

    {{ render_operator_eq() | indent }}
    {{ render_operator_ne() | indent }}
    {{ render_operator_lt() | indent }}

    {{ render_method("operator_neg", py_name="__neg__") | indent }}

    def __pos__(Vector4 self):
        return self

    {{ render_method("operator_add", py_name="__add__") | indent }}
    {{ render_method("operator_subtract", py_name="__sub__") | indent }}

    def __mul__(Vector4 self, val):
        cdef Vector4 _val
        try:
            _val = <Vector4?>val
        except TypeError:
            return Vector4_multiply_scalar(self, val)
        else:
            return Vector4_multiply_vector(self, _val)

    def __truediv__(Vector4 self, val):
        cdef Vector4 _val
        try:
            _val = <Vector4?>val
        except TypeError:
            if val is 0:
                raise ZeroDivisionError()
            return Vector4_divide_scalar(self, val)
        else:
            if _val.x == 0 or _val.y == 0 or _val.z == 0:
                raise ZeroDivisionError()
            return Vector4_divide_vector(self, _val)

    {{ render_method("as_string") | indent }}
{% endblock %}

{%- block python_consts %}
    AXIS = IntEnum("AXIS", {
        "X": pandemonium_vector4_axis.PANDEMONIUM_VECTOR4_AXIS_X,
        "Y": pandemonium_vector4_axis.PANDEMONIUM_VECTOR4_AXIS_Y,
        "Z": pandemonium_vector4_axis.PANDEMONIUM_VECTOR4_AXIS_Z,
        "W": pandemonium_vector4_axis.PANDEMONIUM_VECTOR4_AXIS_W,
    })
{% endblock %}
