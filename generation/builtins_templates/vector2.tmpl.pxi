{%- block pxd_header %}
{% endblock -%}
{%- block pyx_header %}

# TODO

{{ force_mark_rendered("pandemonium_vector2_bezier_interpolate") }}
{{ force_mark_rendered("pandemonium_vector2_ceil") }}
{{ force_mark_rendered("pandemonium_vector2_cross") }}
{{ force_mark_rendered("pandemonium_vector2_get_axis") }}
{{ force_mark_rendered("pandemonium_vector2_is_equal_approx") }}
{{ force_mark_rendered("pandemonium_vector2_max") }}
{{ force_mark_rendered("pandemonium_vector2_max_axis") }}
{{ force_mark_rendered("pandemonium_vector2_min") }}
{{ force_mark_rendered("pandemonium_vector2_min_axis") }}
{{ force_mark_rendered("pandemonium_vector2_normalize") }}
{{ force_mark_rendered("pandemonium_vector2_operator_index") }}
{{ force_mark_rendered("pandemonium_vector2_operator_index_const") }}
{{ force_mark_rendered("pandemonium_vector2_orthogonal") }}
{{ force_mark_rendered("pandemonium_vector2_plane_project") }}
{{ force_mark_rendered("pandemonium_vector2_posmod") }}
{{ force_mark_rendered("pandemonium_vector2_posmodv") }}
{{ force_mark_rendered("pandemonium_vector2_project") }}
{{ force_mark_rendered("pandemonium_vector2_round") }}
{{ force_mark_rendered("pandemonium_vector2_set_all") }}
{{ force_mark_rendered("pandemonium_vector2_set_axis") }}
{{ force_mark_rendered("pandemonium_vector2_set_rotation") }}
{{ force_mark_rendered("pandemonium_vector2_sign") }}
{{ force_mark_rendered("pandemonium_vector2_slerp") }}


# END TODO


from pandemonium._hazmat.gdnative_api_struct cimport pandemonium_vector2_axis
import math

cdef inline Vector2 Vector2_multiply_vector(Vector2 self, Vector2 b):
    cdef Vector2 ret  = Vector2.__new__(Vector2)
    {{ force_mark_rendered("pandemonium_vector2_operator_multiply_vector") }}
    ret._gd_data = gdapi10.pandemonium_vector2_operator_multiply_vector(&self._gd_data, &b._gd_data)
    return ret

cdef inline Vector2 Vector2_multiply_scalar(Vector2 self, pandemonium_real b):
    cdef Vector2 ret  = Vector2.__new__(Vector2)
    {{ force_mark_rendered("pandemonium_vector2_operator_multiply_scalar") }}
    ret._gd_data = gdapi10.pandemonium_vector2_operator_multiply_scalar(&self._gd_data, b)
    return ret

cdef inline Vector2 Vector2_divide_vector(Vector2 self, Vector2 b):
    cdef Vector2 ret  = Vector2.__new__(Vector2)
    {{ force_mark_rendered("pandemonium_vector2_operator_divide_vector") }}
    ret._gd_data = gdapi10.pandemonium_vector2_operator_divide_vector(&self._gd_data, &b._gd_data)
    return ret

cdef inline Vector2 Vector2_divide_scalar(Vector2 self, pandemonium_real b):
    cdef Vector2 ret  = Vector2.__new__(Vector2)
    {{ force_mark_rendered("pandemonium_vector2_operator_divide_scalar") }}
    ret._gd_data = gdapi10.pandemonium_vector2_operator_divide_scalar(&self._gd_data, b)
    return ret
{% endblock -%}


@cython.final
cdef class Vector2:
{% block cdef_attributes %}
    cdef pandemonium_vector2 _gd_data
{% endblock %}

{% block python_defs %}
    def __init__(self, pandemonium_real x=0.0, pandemonium_real y=0.0):
        {{ force_mark_rendered("pandemonium_vector2_new") }}
        gdapi10.pandemonium_vector2_new(&self._gd_data, x, y)

    def __repr__(Vector2 self):
        return f"<Vector2(x={self.x}, y={self.y})>"

    {{ render_operator_eq() | indent }}
    {{ render_operator_ne() | indent }}
    {{ render_operator_lt() | indent }}

    {{ render_method("operator_neg", py_name="__neg__") | indent }}

    def __pos__(Vector2 self):
        return self

    {{ render_method("operator_add", py_name="__add__") | indent }}
    {{ render_method("operator_subtract", py_name="__sub__") | indent }}

    def __mul__(Vector2 self, val):
        cdef Vector2 _val
        try:
            _val = <Vector2?>val
        except TypeError:
            return Vector2_multiply_scalar(self, val)
        else:
            return Vector2_multiply_vector(self, _val)

    def __truediv__(Vector2 self, val):
        cdef Vector2 _val
        try:
            _val = <Vector2?>val
        except TypeError:
            if val is 0:
                raise ZeroDivisionError()
            return Vector2_divide_scalar(self, val)
        else:
            if _val.x == 0 or _val.y == 0:
                raise ZeroDivisionError()
            return Vector2_divide_vector(self, _val)

    {{ render_property("x", "get_x", "set_x") | indent }}
    {{ render_property("y", "get_y", "set_y") | indent }}
    {{ render_property("width", "get_x", "set_x") | indent }}
    {{ render_property("height", "get_y", "set_y") | indent }}

    {{ render_method("as_string") | indent }}
    {{ render_method("normalized") | indent }}
    {{ render_method("length") | indent }}
    {{ render_method("angle") | indent }}
    {{ render_method("length_squared") | indent }}
    {{ render_method("is_normalized") | indent }}
    {{ render_method("distance_to") | indent }}
    {{ render_method("distance_squared_to") | indent }}
    {{ render_method("angle_to") | indent }}
    {{ render_method("angle_to_point") | indent }}
    {{ render_method("linear_interpolate") | indent }}
    {{ render_method("cubic_interpolate") | indent }}
    {{ render_method("move_toward") | indent }}
    {{ render_method("direction_to") | indent }}
    {{ render_method("rotated") | indent }}
    {{ render_method("tangent") | indent }}
    {{ render_method("floor") | indent }}
    {{ render_method("snapped") | indent }}
    {{ render_method("aspect") | indent }}
    {{ render_method("dot") | indent }}
    {{ render_method("slide") | indent }}
    {{ render_method("bounce") | indent }}
    {{ render_method("reflect") | indent }}
    {{ render_method("abs") | indent }}
    {{ render_method("limit_length") | indent }}
{% endblock %}

{%- block python_consts %}
    AXIS = IntEnum("AXIS", {
        "X": pandemonium_vector2_axis.PANDEMONIUM_VECTOR2_AXIS_X,
        "Y": pandemonium_vector2_axis.PANDEMONIUM_VECTOR2_AXIS_Y,
    })

    ZERO = Vector2(0, 0)
    ONE = Vector2(1, 1)
    INF = Vector2(math.inf, math.inf)
    LEFT = Vector2(-1, 0)
    RIGHT = Vector2(1, 0)
    UP = Vector2(0, -1)
    DOWN = Vector2(0, 1)
{% endblock %}
