{%- block pxd_header %}
{% endblock -%}
{%- block pyx_header %}

# TODO

{{ force_mark_rendered("pandemonium_rect2i_abs") }}
{{ force_mark_rendered("pandemonium_rect2i_clip") }}
{{ force_mark_rendered("pandemonium_rect2i_encloses") }}
{{ force_mark_rendered("pandemonium_rect2i_expand") }}
{{ force_mark_rendered("pandemonium_rect2i_expand_to") }}
{{ force_mark_rendered("pandemonium_rect2i_get_area") }}
{{ force_mark_rendered("pandemonium_rect2i_get_center") }}
{{ force_mark_rendered("pandemonium_rect2i_get_end") }}
{{ force_mark_rendered("pandemonium_rect2i_grow") }}
{{ force_mark_rendered("pandemonium_rect2i_grow_by") }}
{{ force_mark_rendered("pandemonium_rect2i_grow_individual") }}
{{ force_mark_rendered("pandemonium_rect2i_grow_margin") }}
{{ force_mark_rendered("pandemonium_rect2i_grow_side") }}
{{ force_mark_rendered("pandemonium_rect2i_has_no_area") }}
{{ force_mark_rendered("pandemonium_rect2i_has_point") }}
{{ force_mark_rendered("pandemonium_rect2i_intersection") }}
{{ force_mark_rendered("pandemonium_rect2i_intersects") }}
{{ force_mark_rendered("pandemonium_rect2i_merge") }}
{{ force_mark_rendered("pandemonium_rect2i_new_from_rect2") }}
{{ force_mark_rendered("pandemonium_rect2i_set_end") }}
{{ force_mark_rendered("pandemonium_rect2i_to_rect2") }}

# END TODO

{% endblock -%}


@cython.final
cdef class Rect2i:
{% block cdef_attributes %}
    cdef pandemonium_rect2i _gd_data
{% endblock %}

{% block python_defs %}
    def __init__(self, pandemonium_real x=0.0, pandemonium_real y=0.0, pandemonium_real width=0.0, pandemonium_real height=0.0):
        {{ force_mark_rendered("pandemonium_rect2i_new") }}
        gdapi10.pandemonium_rect2i_new(&self._gd_data, x, y, width, height)

    @staticmethod
    def from_pos_size(Vector2i position not None, Vector2i size not None):
        {{ force_mark_rendered("pandemonium_rect2i_new_with_position_and_size") }}
        cdef Rect2i ret = Rect2i.__new__(Rect2i)
        gdapi10.pandemonium_rect2i_new_with_position_and_size(&ret._gd_data, &position._gd_data, &size._gd_data)
        return ret

    def __repr__(Rect2i self):
        return f"<Rect2i({self.as_string()})>"

    {{ render_operator_eq() | indent }}
    {{ render_operator_ne() | indent }}

    {{ render_property("size", getter="get_size", setter="set_size") | indent }}
    {{ render_property("position", getter="get_position", setter="set_position") | indent }}

    @property
    def end(Rect2i self) -> Vector2i:
        cdef pandemonium_vector2i position = gdapi10.pandemonium_rect2i_get_position(&self._gd_data)
        cdef pandemonium_vector2i size = gdapi10.pandemonium_rect2i_get_size(&self._gd_data)
        cdef Vector2i ret = Vector2i.__new__(Vector2i)
        ret._gd_data = gdapi10.pandemonium_vector2i_operator_add(&position, &size)
        return ret

    {{ render_method("as_string") | indent }}
{% endblock %}

{%- block python_consts %}
{% endblock %}
