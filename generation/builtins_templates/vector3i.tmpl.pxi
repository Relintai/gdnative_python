{%- block pxd_header %}
{% endblock -%}
{%- block pyx_header %}
from pandemonium._hazmat.gdnative_api_struct cimport pandemonium_vector3i_axis
{% endblock -%}


@cython.final
cdef class Vector3i:
{% block cdef_attributes %}
    cdef pandemonium_vector3i _gd_data
{% endblock %}

{% block python_defs %}
    def __init__(self, pandemonium_int x=0, pandemonium_int y=0, pandemonium_int z=0):
        {{ force_mark_rendered("pandemonium_vector3i_new") }}
        gdapi10.pandemonium_vector3i_new(&self._gd_data, x, y, z)

    def __repr__(self):
        return f"<Vector3i(x={self.x}, y={self.y}, z={self.z})>"

    @property
    def x(self) -> pandemonium_int:
        {{ force_mark_rendered("pandemonium_vector3i_get_axis") }}
        return gdapi10.pandemonium_vector3i_get_axis(&self._gd_data, pandemonium_vector3i_axis.PANDEMONIUM_VECTOR3I_AXIS_X)

    @x.setter
    def x(self, pandemonium_int val) -> None:
        {{ force_mark_rendered("pandemonium_vector3i_set_axis") }}
        gdapi10.pandemonium_vector3i_set_axis(&self._gd_data, pandemonium_vector3i_axis.PANDEMONIUM_VECTOR3I_AXIS_X, val)

    @property
    def y(self) -> pandemonium_int:
        {{ force_mark_rendered("pandemonium_vector3i_get_axis") }}
        return gdapi10.pandemonium_vector3i_get_axis(&self._gd_data, pandemonium_vector3i_axis.PANDEMONIUM_VECTOR3I_AXIS_Y)

    @y.setter
    def y(self, pandemonium_int val) -> None:
        {{ force_mark_rendered("pandemonium_vector3i_set_axis") }}
        gdapi10.pandemonium_vector3i_set_axis(&self._gd_data, pandemonium_vector3i_axis.PANDEMONIUM_VECTOR3I_AXIS_Y, val)

    @property
    def z(self) -> pandemonium_int:
        {{ force_mark_rendered("pandemonium_vector3i_get_axis") }}
        return gdapi10.pandemonium_vector3i_get_axis(&self._gd_data, pandemonium_vector3i_axis.PANDEMONIUM_VECTOR3I_AXIS_Z)

    @z.setter
    def z(self, pandemonium_int val) -> None:
        {{ force_mark_rendered("pandemonium_vector3i_set_axis") }}
        gdapi10.pandemonium_vector3i_set_axis(&self._gd_data, pandemonium_vector3i_axis.PANDEMONIUM_VECTOR3I_AXIS_Z, val)

    {{ render_operator_eq() | indent }}
    {{ render_operator_ne() | indent }}
    {{ render_operator_lt() | indent }}

    {{ render_method("operator_neg", py_name="__neg__") | indent }}

    def __pos__(Vector3i self):
        return self

    {{ render_method("operator_add", py_name="__add__") | indent }}
    {{ render_method("operator_subtract", py_name="__sub__") | indent }}

    def __mul__(Vector3i self, val):
        cdef Vector3i _val
        try:
            _val = <Vector3i?>val
        except TypeError:
            return Vector3i_multiply_scalar(self, val)
        else:
            return Vector3i_multiply_vector(self, _val)

    def __truediv__(Vector3i self, val):
        cdef Vector3i _val
        try:
            _val = <Vector3i?>val
        except TypeError:
            if val is 0:
                raise ZeroDivisionError()
            return Vector3i_divide_scalar(self, val)
        else:
            if _val.x == 0 or _val.y == 0 or _val.z == 0:
                raise ZeroDivisionError()
            return Vector3i_divide_vector(self, _val)

    {{ render_method("as_string") | indent }}
{% endblock %}

{%- block python_consts %}
    AXIS = IntEnum("AXIS", {
        "X": pandemonium_vector3i_axis.PANDEMONIUM_VECTOR3I_AXIS_X,
        "Y": pandemonium_vector3i_axis.PANDEMONIUM_VECTOR3I_AXIS_Y,
        "Z": pandemonium_vector3i_axis.PANDEMONIUM_VECTOR3I_AXIS_Z,
    })

    ZERO = Vector3i(0, 0, 0)  # Zero vector.
    ONE = Vector3i(1, 1, 1)  # One vector.
    INF = Vector3i(math.inf, math.inf, math.inf)  # Infinite vector.
    LEFT = Vector3i(-1, 0, 0)  # Left unit vector.
    RIGHT = Vector3i(1, 0, 0)  # Right unit vector.
    UP = Vector3i(0, 1, 0)  # Up unit vector.
    DOWN = Vector3i(0, -1, 0)  # Down unit vector.
    FORWARD = Vector3i(0, 0, -1)  # Forward unit vector.
    BACK = Vector3i(0, 0, 1)  # Back unit vector.
{% endblock %}
