{%- block pxd_header %}
{% endblock -%}
{%- block pyx_header %}

# TODO

{{ force_mark_rendered("pandemonium_quaternion_angle_to") }}
{{ force_mark_rendered("pandemonium_quaternion_exp") }}
{{ force_mark_rendered("pandemonium_quaternion_get_angle") }}
{{ force_mark_rendered("pandemonium_quaternion_get_axis") }}
{{ force_mark_rendered("pandemonium_quaternion_get_axis_angle") }}
{{ force_mark_rendered("pandemonium_quaternion_get_euler") }}
{{ force_mark_rendered("pandemonium_quaternion_get_euler_xyz") }}
{{ force_mark_rendered("pandemonium_quaternion_get_euler_yxz") }}
{{ force_mark_rendered("pandemonium_quaternion_is_equal_approx") }}
{{ force_mark_rendered("pandemonium_quaternion_log") }}
{{ force_mark_rendered("pandemonium_quaternion_new_shortest_arc") }}
{{ force_mark_rendered("pandemonium_quaternion_normalize") }}
{{ force_mark_rendered("pandemonium_quaternion_operator_mul_eq") }}
{{ force_mark_rendered("pandemonium_quaternion_set") }}
{{ force_mark_rendered("pandemonium_quaternion_set_euler") }}
{{ force_mark_rendered("pandemonium_quaternion_set_euler_xyz") }}
{{ force_mark_rendered("pandemonium_quaternion_set_euler_yxz") }}
{{ force_mark_rendered("pandemonium_quaternion_spherical_cubic_interpolate") }}

# END TODO

{% endblock -%}


@cython.final
cdef class Quaternion:
{% block cdef_attributes %}
    cdef pandemonium_quaternion _gd_data
{% endblock %}

{% block python_defs %}
    def __init__(self, x=0, y=0, z=0, w=0):
        {{ force_mark_rendered("pandemonium_quaternion_new") }}
        gdapi10.pandemonium_quaternion_new(&self._gd_data, x, y, z, w)

    @staticmethod
    def from_axis_angle(Vector3 axis not None, pandemonium_real angle):
        # Call to __new__ bypasses __init__ constructor
        cdef Quaternion ret = Quaternion.__new__(Quaternion)
        {{ force_mark_rendered("pandemonium_quaternion_new_with_axis_angle") }}
        gdapi10.pandemonium_quaternion_new_with_axis_angle(&ret._gd_data, &axis._gd_data, angle)
        return ret

    @staticmethod
    def from_basis(Basis basis not None):
        # Call to __new__ bypasses __init__ constructor
        cdef Quaternion ret = Quaternion.__new__(Quaternion)
        {{ force_mark_rendered("pandemonium_quaternion_new_with_basis") }}
        gdapi10.pandemonium_quaternion_new_with_basis(&ret._gd_data, &basis._gd_data)
        return ret

    @staticmethod
    def from_euler(Vector3 euler not None):
        # Call to __new__ bypasses __init__ constructor
        cdef Quaternion ret = Quaternion.__new__(Quaternion)
        {{ force_mark_rendered("pandemonium_quaternion_new_with_euler") }}
        gdapi10.pandemonium_quaternion_new_with_euler(&ret._gd_data, &euler._gd_data)
        return ret

    def __repr__(Quaternion self):
        return f"<Quaternion(x={self.x}, y={self.y}, z={self.z}, w={self.w})>"

    {{ render_operator_eq() | indent }}
    {{ render_operator_ne() | indent }}

    {{ render_method("operator_neg", py_name="__neg__") | indent }}

    def __pos__(Quaternion self):
        return self

    {{ render_method("operator_add", py_name="__add__") | indent }}
    {{ render_method("operator_subtract", py_name="__sub__") | indent }}
    {{ render_method("operator_multiply", py_name="__mul__") | indent }}

    def __truediv__(Quaternion self, pandemonium_real val):
        if val == 0:
            raise ZeroDivisionError
        cdef Quaternion ret  = Quaternion.__new__(Quaternion)
        {{ force_mark_rendered("pandemonium_quaternion_operator_divide") }}
        ret._gd_data = gdapi10.pandemonium_quaternion_operator_divide(&self._gd_data, val)
        return ret

    {{ render_property("x", getter="get_x", setter="set_x") | indent }}
    {{ render_property("y", getter="get_y", setter="set_y") | indent }}
    {{ render_property("z", getter="get_z", setter="set_z") | indent }}
    {{ render_property("w", getter="get_w", setter="set_w") | indent }}

    {{ render_method("as_string") | indent }}
    {{ render_method("length") | indent }}
    {{ render_method("length_squared") | indent }}
    {{ render_method("normalized") | indent }}
    {{ render_method("is_normalized") | indent }}
    {{ render_method("inverse") | indent }}
    {{ render_method("dot") | indent }}
    {{ render_method("xform") | indent }}
    {{ render_method("slerp") | indent }}
    {{ render_method("slerpni") | indent }}
    {{ render_method("cubic_slerp") | indent }}
    {{ render_method("set_axis_angle") | indent }}
{% endblock %}

{%- block python_consts %}
    IDENTITY = Quaternion(0, 0, 0, 1)
{% endblock %}
