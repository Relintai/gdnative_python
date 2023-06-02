{%- block pxd_header %}
{% endblock -%}
{%- block pyx_header %}
{% endblock -%}

@cython.final
cdef class StringName:
{% block cdef_attributes %}
    cdef pandemonium_string_name _gd_data
{% endblock %}

{% block python_defs %}
    def __init__(self, from_):
        {{ force_mark_rendered("pandemonium_string_name_new") }}
        cdef pandemonium_string gd_from
        try:
            gdapi10.pandemonium_string_name_new(&self._gd_data, &(<GDString?>from_)._gd_data)
        except TypeError:
            if not isinstance(from_, str):
                raise TypeError("`from_` must be str or GDString")
            pyobj_to_pandemonium_string(from_, &gd_from)
            gdapi10.pandemonium_string_name_new(&self._gd_data, &gd_from)
            gdapi10.pandemonium_string_destroy(&gd_from)

    def __dealloc__(StringName self):
        {{ force_mark_rendered("pandemonium_string_name_destroy") }}
        # /!\ if `__init__` is skipped, `_gd_data` must be initialized by
        # hand otherwise we will get a segfault here
        gdapi10.pandemonium_string_name_destroy(&self._gd_data)

    def __repr__(StringName self):
        return f"<StringName({self.as_string()})>"

    def __str__(StringName self):
        return str(self.as_string())

    {{ render_operator_eq() | indent }}
    {{ render_operator_ne() | indent }}

    {{ render_method("destroy") | indent }}
    {{ render_method("as_string") | indent }}
{% endblock %}

{%- block python_consts %}
{% endblock %}
