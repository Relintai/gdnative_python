{%- block pxd_header %}
{% endblock -%}
{%- block pyx_header %}

# TODO

{{ force_mark_rendered("pandemonium_rect2_distance_to") }}
{{ force_mark_rendered("pandemonium_rect2_expand_to") }}
{{ force_mark_rendered("pandemonium_rect2_get_center") }}
{{ force_mark_rendered("pandemonium_rect2_get_end") }}
{{ force_mark_rendered("pandemonium_rect2_get_support") }}
{{ force_mark_rendered("pandemonium_rect2_grow_by") }}
{{ force_mark_rendered("pandemonium_rect2_grow_side") }}
{{ force_mark_rendered("pandemonium_rect2_intersection") }}
{{ force_mark_rendered("pandemonium_rect2_intersects_segment") }}
{{ force_mark_rendered("pandemonium_rect2_intersects_segment_pos") }}
{{ force_mark_rendered("pandemonium_rect2_intersects_segment_pos_normal") }}
{{ force_mark_rendered("pandemonium_rect2_intersects_transformed") }}
{{ force_mark_rendered("pandemonium_rect2_is_equal_approx") }}
{{ force_mark_rendered("pandemonium_rect2_set_end") }}

# END TODO

{% endblock -%}


@cython.final
cdef class Rect2:
{% block cdef_attributes %}
    cdef pandemonium_rect2 _gd_data
{% endblock %}

{% block python_defs %}
    def __init__(self, pandemonium_real x=0.0, pandemonium_real y=0.0, pandemonium_real width=0.0, pandemonium_real height=0.0):
        {{ force_mark_rendered("pandemonium_rect2_new") }}
        gdapi10.pandemonium_rect2_new(&self._gd_data, x, y, width, height)

    @staticmethod
    def from_pos_size(Vector2 position not None, Vector2 size not None):
        {{ force_mark_rendered("pandemonium_rect2_new_with_position_and_size") }}
        cdef Rect2 ret = Rect2.__new__(Rect2)
        gdapi10.pandemonium_rect2_new_with_position_and_size(&ret._gd_data, &position._gd_data, &size._gd_data)
        return ret

    def __repr__(Rect2 self):
        return f"<Rect2({self.as_string()})>"

    {{ render_operator_eq() | indent }}
    {{ render_operator_ne() | indent }}

    {{ render_property("size", getter="get_size", setter="set_size") | indent }}
    {{ render_property("position", getter="get_position", setter="set_position") | indent }}

    @property
    def end(Rect2 self) -> Vector2:
        cdef pandemonium_vector2 position = gdapi10.pandemonium_rect2_get_position(&self._gd_data)
        cdef pandemonium_vector2 size = gdapi10.pandemonium_rect2_get_size(&self._gd_data)
        cdef Vector2 ret = Vector2.__new__(Vector2)
        ret._gd_data = gdapi10.pandemonium_vector2_operator_add(&position, &size)
        return ret

    {{ render_method("as_string") | indent }}
    {{ render_method("get_area") | indent }}
    {{ render_method("intersects") | indent }}
    {{ render_method("encloses") | indent }}
    {{ render_method("has_no_area") | indent }}
    {{ render_method("clip") | indent }}
    {{ render_method("merge") | indent }}
    {{ render_method("has_point") | indent }}
    {{ render_method("grow") | indent }}
    {{ render_method("grow_individual") | indent }}
    {{ render_method("grow_margin") | indent }}
    {{ render_method("abs") | indent }}
    {{ render_method("expand") | indent }}
{% endblock %}

{%- block python_consts %}
{% endblock %}
