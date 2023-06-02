{%- block pxd_header %}
{% endblock -%}
{%- block pyx_header %}

# TODO

{{ force_mark_rendered("pandemonium_vector2i_abs") }}
{{ force_mark_rendered("pandemonium_vector2i_aspect") }}
{{ force_mark_rendered("pandemonium_vector2i_clamp") }}
{{ force_mark_rendered("pandemonium_vector2i_get_axis") }}
{{ force_mark_rendered("pandemonium_vector2i_length") }}
{{ force_mark_rendered("pandemonium_vector2i_length_squared") }}
{{ force_mark_rendered("pandemonium_vector2i_linear_interpolate") }}
{{ force_mark_rendered("pandemonium_vector2i_max") }}
{{ force_mark_rendered("pandemonium_vector2i_max_axis") }}
{{ force_mark_rendered("pandemonium_vector2i_min") }}
{{ force_mark_rendered("pandemonium_vector2i_min_axis") }}
{{ force_mark_rendered("pandemonium_vector2i_operator_divide_scalar") }}
{{ force_mark_rendered("pandemonium_vector2i_operator_divide_vector") }}
{{ force_mark_rendered("pandemonium_vector2i_operator_index") }}
{{ force_mark_rendered("pandemonium_vector2i_operator_index_const") }}
{{ force_mark_rendered("pandemonium_vector2i_operator_multiply_scalar") }}
{{ force_mark_rendered("pandemonium_vector2i_operator_multiply_vector") }}
{{ force_mark_rendered("pandemonium_vector2i_set_all") }}
{{ force_mark_rendered("pandemonium_vector2i_set_axis") }}
{{ force_mark_rendered("pandemonium_vector2i_sign") }}
{{ force_mark_rendered("pandemonium_vector2i_to_vector2") }}

# END TODO

from pandemonium._hazmat.gdnative_api_struct cimport pandemonium_vector2i_axis
{% endblock -%}


@cython.final
cdef class Vector2i:
{% block cdef_attributes %}
    cdef pandemonium_vector2i _gd_data
{% endblock %}

{% block python_defs %}
    def __init__(self, pandemonium_int x=0, pandemonium_int y=0):
        {{ force_mark_rendered("pandemonium_vector2i_new") }}
        gdapi10.pandemonium_vector2i_new(&self._gd_data, x, y)

    def __repr__(Vector2i self):
        return f"<Vector2i(x={self.x}, y={self.y})>"

    {{ render_operator_eq() | indent }}
    {{ render_operator_ne() | indent }}
    {{ render_operator_lt() | indent }}

    {{ render_method("operator_neg", py_name="__neg__") | indent }}

    def __pos__(Vector2i self):
        return self

    {{ render_method("operator_add", py_name="__add__") | indent }}
    {{ render_method("operator_subtract", py_name="__sub__") | indent }}

    def __mul__(Vector2i self, val):
        cdef Vector2i _val
        try:
            _val = <Vector2i?>val
        except TypeError:
            return Vector2i_multiply_scalar(self, val)
        else:
            return Vector2i_multiply_vector(self, _val)

    def __truediv__(Vector2i self, val):
        cdef Vector2i _val
        try:
            _val = <Vector2i?>val
        except TypeError:
            if val is 0:
                raise ZeroDivisionError()
            return Vector2i_divide_scalar(self, val)
        else:
            if _val.x == 0 or _val.y == 0:
                raise ZeroDivisionError()
            return Vector2i_divide_vector(self, _val)

    {{ render_property("x", "get_x", "set_x") | indent }}
    {{ render_property("y", "get_y", "set_y") | indent }}
    {{ render_property("width", "get_x", "set_x") | indent }}
    {{ render_property("height", "get_y", "set_y") | indent }}

    {{ render_method("as_string") | indent }}
{% endblock %}

{%- block python_consts %}
    AXIS = IntEnum("AXIS", {
        "X": pandemonium_vector2i_axis.PANDEMONIUM_VECTOR2I_AXIS_X,
        "Y": pandemonium_vector2i_axis.PANDEMONIUM_VECTOR2I_AXIS_Y,
    })

    ZERO = Vector2i(0, 0)
    ONE = Vector2i(1, 1)
    INF = Vector2i(math.inf, math.inf)
    LEFT = Vector2i(-1, 0)
    RIGHT = Vector2i(1, 0)
    UP = Vector2i(0, -1)
    DOWN = Vector2i(0, 1)
{% endblock %}
