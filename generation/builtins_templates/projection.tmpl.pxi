{%- block pxd_header %}
{% endblock -%}
{%- block pyx_header %}
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
