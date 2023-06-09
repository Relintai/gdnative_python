{%- block pxd_header -%}
{%- endblock -%}
{%- block pyx_header -%}

# TODO

{{ force_mark_rendered("pandemonium_aabb_abs") }}
{{ force_mark_rendered("pandemonium_aabb_expand_to") }}
{{ force_mark_rendered("pandemonium_aabb_get_center") }}
{{ force_mark_rendered("pandemonium_aabb_get_edge") }}
{{ force_mark_rendered("pandemonium_aabb_get_end") }}
{{ force_mark_rendered("pandemonium_aabb_get_volume") }}
{{ force_mark_rendered("pandemonium_aabb_grow_by") }}
{{ force_mark_rendered("pandemonium_aabb_has_no_volume") }}
{{ force_mark_rendered("pandemonium_aabb_intersects_inclusive") }}
{{ force_mark_rendered("pandemonium_aabb_intersects_ray") }}
{{ force_mark_rendered("pandemonium_aabb_intersects_ray_clip") }}
{{ force_mark_rendered("pandemonium_aabb_intersects_ray_clip_normal") }}
{{ force_mark_rendered("pandemonium_aabb_intersects_rayv") }}
{{ force_mark_rendered("pandemonium_aabb_intersects_segment_clip") }}
{{ force_mark_rendered("pandemonium_aabb_intersects_segment_clip_normal") }}
{{ force_mark_rendered("pandemonium_aabb_intersects_segmentv") }}
{{ force_mark_rendered("pandemonium_aabb_intersects_smits_intersect_ray") }}
{{ force_mark_rendered("pandemonium_aabb_is_equal_approx") }}
{{ force_mark_rendered("pandemonium_aabb_merge_with") }}
{{ force_mark_rendered("pandemonium_aabb_project_range_in_plane") }}
{{ force_mark_rendered("pandemonium_aabb_quantize") }}
{{ force_mark_rendered("pandemonium_aabb_quantized") }}
{{ force_mark_rendered("pandemonium_aabb_set_end") }}

{%- endblock -%}

@cython.final
cdef class AABB:
{% block cdef_attributes %}
    cdef pandemonium_aabb _gd_data
{% endblock %}

{% block python_defs %}
    def __init__(self, Vector3 pos not None=Vector3(), Vector3 size not None=Vector3()):
        {{ force_mark_rendered("pandemonium_aabb_new" )}}
        gdapi10.pandemonium_aabb_new(&self._gd_data, &pos._gd_data, &size._gd_data)

    def __repr__(self):
        return f"<AABB({self.as_string()})>"

    @property
    def position(AABB self) -> Vector3:
        cdef Vector3 ret = Vector3.__new__(Vector3)
        {{ force_mark_rendered("pandemonium_aabb_get_position" )}}
        ret._gd_data = gdapi10.pandemonium_aabb_get_position(&self._gd_data)
        return ret

    @position.setter
    def position(AABB self, Vector3 val not None) -> None:
        {{ force_mark_rendered("pandemonium_aabb_set_position" )}}
        gdapi10.pandemonium_aabb_set_position(&self._gd_data, &val._gd_data)

    @property
    def size(AABB self) -> Vector3:
        cdef Vector3 ret = Vector3.__new__(Vector3)
        {{ force_mark_rendered("pandemonium_aabb_get_size" )}}
        ret._gd_data = gdapi10.pandemonium_aabb_get_size(&self._gd_data)
        return ret

    @size.setter
    def size(AABB self, Vector3 val not None) -> None:
        {{ force_mark_rendered("pandemonium_aabb_set_size" )}}
        gdapi10.pandemonium_aabb_set_size(&self._gd_data, &val._gd_data)

    @property
    def end(AABB self) -> Vector3:
        cdef pandemonium_vector3 position = gdapi10.pandemonium_aabb_get_position(&self._gd_data)
        cdef pandemonium_vector3 size = gdapi10.pandemonium_aabb_get_size(&self._gd_data)
        cdef Vector3 ret = Vector3.__new__(Vector3)
        ret._gd_data = gdapi10.pandemonium_vector3_operator_add(&position, &size)
        return ret

    {{ render_operator_eq() | indent }}
    {{ render_operator_ne() | indent }}
    {{ render_method("as_string") | indent }}
    {{ render_method("has_no_surface") | indent }}
    {{ render_method("intersects") | indent }}
    {{ render_method("encloses") | indent }}
    {{ render_method("merge") | indent }}
    {{ render_method("intersection") | indent }}
    {{ render_method("intersects_plane") | indent }}
    {{ render_method("intersects_segment") | indent }}
    {{ render_method("has_point") | indent }}
    {{ render_method("get_support") | indent }}
    {{ render_method("get_longest_axis") | indent }}
    {{ render_method("get_longest_axis_index") | indent }}
    {{ render_method("get_longest_axis_size") | indent }}
    {{ render_method("get_shortest_axis") | indent }}
    {{ render_method("get_shortest_axis_index") | indent }}
    {{ render_method("get_shortest_axis_size") | indent }}
    {{ render_method("expand") | indent }}
    {{ render_method("grow") | indent }}
    {{ render_method("get_endpoint") | indent }}
{% endblock %}
