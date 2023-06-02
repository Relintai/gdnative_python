{%- block pxd_header %}
{% endblock -%}
{%- block pyx_header %}

# TODO

{{ force_mark_rendered("pandemonium_projection_add_jitter_offset") }}
{{ force_mark_rendered("pandemonium_projection_adjust_perspective_znear") }}
{{ force_mark_rendered("pandemonium_projection_calculate_fovy") }}
{{ force_mark_rendered("pandemonium_projection_create_depth_correction") }}
{{ force_mark_rendered("pandemonium_projection_create_fit_aabb") }}
{{ force_mark_rendered("pandemonium_projection_create_for_hmd") }}
{{ force_mark_rendered("pandemonium_projection_create_frustum") }}
{{ force_mark_rendered("pandemonium_projection_create_frustum_aspect") }}
{{ force_mark_rendered("pandemonium_projection_create_light_atlas_rect") }}
{{ force_mark_rendered("pandemonium_projection_create_orthogonal") }}
{{ force_mark_rendered("pandemonium_projection_create_orthogonal_aspect") }}
{{ force_mark_rendered("pandemonium_projection_create_perspective") }}
{{ force_mark_rendered("pandemonium_projection_create_perspective_hmd") }}
{{ force_mark_rendered("pandemonium_projection_determinant") }}
{{ force_mark_rendered("pandemonium_projection_flip_y") }}
{{ force_mark_rendered("pandemonium_projection_flipped_y") }}
{{ force_mark_rendered("pandemonium_projection_get_aspect") }}
{{ force_mark_rendered("pandemonium_projection_get_endpoints") }}
{{ force_mark_rendered("pandemonium_projection_get_far_plane_half_extents") }}
{{ force_mark_rendered("pandemonium_projection_get_fov") }}
{{ force_mark_rendered("pandemonium_projection_get_fovy") }}
{{ force_mark_rendered("pandemonium_projection_get_lod_multiplier") }}
{{ force_mark_rendered("pandemonium_projection_get_pixels_per_meter") }}
{{ force_mark_rendered("pandemonium_projection_get_projection_plane") }}
{{ force_mark_rendered("pandemonium_projection_get_projection_planes_array") }}
{{ force_mark_rendered("pandemonium_projection_get_viewport_half_extents") }}
{{ force_mark_rendered("pandemonium_projection_get_z_far") }}
{{ force_mark_rendered("pandemonium_projection_get_z_near") }}
{{ force_mark_rendered("pandemonium_projection_inverse") }}
{{ force_mark_rendered("pandemonium_projection_invert") }}
{{ force_mark_rendered("pandemonium_projection_is_orthogonal") }}
{{ force_mark_rendered("pandemonium_projection_jitter_offseted") }}
{{ force_mark_rendered("pandemonium_projection_make_scale") }}
{{ force_mark_rendered("pandemonium_projection_new_from_projection") }}
{{ force_mark_rendered("pandemonium_projection_operator_equal") }}
{{ force_mark_rendered("pandemonium_projection_operator_index") }}
{{ force_mark_rendered("pandemonium_projection_operator_index_const") }}
{{ force_mark_rendered("pandemonium_projection_operator_mul") }}
{{ force_mark_rendered("pandemonium_projection_perspective_znear_adjusted") }}
{{ force_mark_rendered("pandemonium_projection_scale_translate_to_fit") }}
{{ force_mark_rendered("pandemonium_projection_set_depth_correction") }}
{{ force_mark_rendered("pandemonium_projection_set_depth_correction_flip") }}
{{ force_mark_rendered("pandemonium_projection_set_for_hmd") }}
{{ force_mark_rendered("pandemonium_projection_set_frustum1") }}
{{ force_mark_rendered("pandemonium_projection_set_frustum2") }}
{{ force_mark_rendered("pandemonium_projection_set_frustum2_flip_fov") }}
{{ force_mark_rendered("pandemonium_projection_set_identity") }}
{{ force_mark_rendered("pandemonium_projection_set_light_atlas_rect") }}
{{ force_mark_rendered("pandemonium_projection_set_light_bias") }}
{{ force_mark_rendered("pandemonium_projection_set_orthogonal1") }}
{{ force_mark_rendered("pandemonium_projection_set_orthogonal2") }}
{{ force_mark_rendered("pandemonium_projection_set_orthogonal2_flip_fov") }}
{{ force_mark_rendered("pandemonium_projection_set_perspective1") }}
{{ force_mark_rendered("pandemonium_projection_set_perspective1_flip_fov") }}
{{ force_mark_rendered("pandemonium_projection_set_perspective2") }}
{{ force_mark_rendered("pandemonium_projection_set_zero") }}
{{ force_mark_rendered("pandemonium_projection_to_transform") }}
{{ force_mark_rendered("pandemonium_projection_xform_inv_vector4") }}
{{ force_mark_rendered("pandemonium_projection_xform_plane") }}
{{ force_mark_rendered("pandemonium_projection_xform_vector3") }}
{{ force_mark_rendered("pandemonium_projection_xform_vector4") }}

# END TODO

{% endblock -%}


@cython.final
cdef class Projection:
{% block cdef_attributes %}
    cdef pandemonium_projection _gd_data
{% endblock %}

{% block python_defs %}
    def __init__(self, x_axis=None, y_axis=None, z_axis=None, w_axis=None):
        if x_axis is None and y_axis is None and z_axis is None and w_axis is None:
            {{ force_mark_rendered("pandemonium_projection_new_identity") }}
            gdapi10.pandemonium_projection_new_identity(&self._gd_data)
        else:
            {{ force_mark_rendered("pandemonium_projection_new_vector4s") }}
            gdapi10.pandemonium_projection_new_vector4s(
                &self._gd_data,
                &(<Vector4?>x_axis)._gd_data,
                &(<Vector4?>y_axis)._gd_data,
                &(<Vector4?>z_axis)._gd_data,
                &(<Vector4?>origin)._gd_data,
            )

    def __repr__(Projection self):
        return f"<Projection({self.as_string()})>"

    {{ render_method("as_string") | indent }}
{% endblock %}

{%- block python_consts %}
    IDENTITY = Projection(Vector4(1, 0, 0, 0), Vector4(0, 1, 0, 0), Vector4(0, 0, 1, 0), Vector4(0, 0, 0, 1))
{% endblock %}
