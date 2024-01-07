{%- block pxd_header %}
{% endblock -%}
{%- block pyx_header %}
from libc.stdint cimport int8_t
{% endblock -%}

# TODO

{{ force_mark_rendered("pandemonium_char_16_string_destroy") }}
{{ force_mark_rendered("pandemonium_char_16_string_get") }}
{{ force_mark_rendered("pandemonium_char_16_string_get_data") }}
{{ force_mark_rendered("pandemonium_char_16_string_length") }}
{{ force_mark_rendered("pandemonium_char_16_string_resize") }}
{{ force_mark_rendered("pandemonium_char_16_string_set") }}
{{ force_mark_rendered("pandemonium_char_16_string_size") }}
{{ force_mark_rendered("pandemonium_char_string_get") }}
{{ force_mark_rendered("pandemonium_char_string_resize") }}
{{ force_mark_rendered("pandemonium_char_string_set") }}
{{ force_mark_rendered("pandemonium_char_string_size") }}

{{ force_mark_rendered("pandemonium_string_append_path") }}
{{ force_mark_rendered("pandemonium_string_append_pathc") }}
{{ force_mark_rendered("pandemonium_string_bool_num") }}
{{ force_mark_rendered("pandemonium_string_bool_str") }}
{{ force_mark_rendered("pandemonium_string_char_to_float") }}
{{ force_mark_rendered("pandemonium_string_chars_to_utf16") }}
{{ force_mark_rendered("pandemonium_string_chars_to_utf16_with_len") }}
{{ force_mark_rendered("pandemonium_string_clear") }}
{{ force_mark_rendered("pandemonium_string_contains") }}
{{ force_mark_rendered("pandemonium_string_containsc") }}
{{ force_mark_rendered("pandemonium_string_find_char") }}
{{ force_mark_rendered("pandemonium_string_find_char_from") }}
{{ force_mark_rendered("pandemonium_string_find_first_difference_index") }}
{{ force_mark_rendered("pandemonium_string_findc") }}
{{ force_mark_rendered("pandemonium_string_findc_from") }}
{{ force_mark_rendered("pandemonium_string_get") }}
{{ force_mark_rendered("pandemonium_string_get_data") }}
{{ force_mark_rendered("pandemonium_string_get_invalid_node_name_characters") }}
{{ force_mark_rendered("pandemonium_string_get_with_code_lines") }}
{{ force_mark_rendered("pandemonium_string_hash_wchar") }}
{{ force_mark_rendered("pandemonium_string_hash_wchar_with_len") }}
{{ force_mark_rendered("pandemonium_string_hashc") }}
{{ force_mark_rendered("pandemonium_string_hashc_with_len") }}
{{ force_mark_rendered("pandemonium_string_indent") }}
{{ force_mark_rendered("pandemonium_string_is_enclosed_in") }}
{{ force_mark_rendered("pandemonium_string_is_network_share_path") }}
{{ force_mark_rendered("pandemonium_string_is_quoted") }}
{{ force_mark_rendered("pandemonium_string_is_valid_bool") }}
{{ force_mark_rendered("pandemonium_string_is_valid_filename") }}
{{ force_mark_rendered("pandemonium_string_is_valid_string") }}
{{ force_mark_rendered("pandemonium_string_is_valid_unsigned_integer") }}
{{ force_mark_rendered("pandemonium_string_is_word_at") }}
{{ force_mark_rendered("pandemonium_string_is_word_atc") }}
{{ force_mark_rendered("pandemonium_string_is_zero") }}
{{ force_mark_rendered("pandemonium_string_join") }}
{{ force_mark_rendered("pandemonium_string_lstrip") }}
{{ force_mark_rendered("pandemonium_string_name_new_data_char") }}
{{ force_mark_rendered("pandemonium_string_name_new_data_string") }}
{{ force_mark_rendered("pandemonium_string_name_new_datac") }}
{{ force_mark_rendered("pandemonium_string_new_char") }}
{{ force_mark_rendered("pandemonium_string_new_char_clip_to_len") }}
{{ force_mark_rendered("pandemonium_string_new_wchar") }}
{{ force_mark_rendered("pandemonium_string_newc") }}
{{ force_mark_rendered("pandemonium_string_newc_clip_to_len") }}
{{ force_mark_rendered("pandemonium_string_newline_to_br") }}
{{ force_mark_rendered("pandemonium_string_num_characters") }}
{{ force_mark_rendered("pandemonium_string_num_uint64") }}
{{ force_mark_rendered("pandemonium_string_num_uint64_capitalized") }}
{{ force_mark_rendered("pandemonium_string_pandemonium_char_to_double") }}
{{ force_mark_rendered("pandemonium_string_pandemonium_char_to_float") }}
{{ force_mark_rendered("pandemonium_string_parse_url") }}
{{ force_mark_rendered("pandemonium_string_parse_utf16") }}
{{ force_mark_rendered("pandemonium_string_parse_utf16_with_len") }}
{{ force_mark_rendered("pandemonium_string_parse_utf8_with_len_skip_cr") }}
{{ force_mark_rendered("pandemonium_string_path_clean_end_slash") }}
{{ force_mark_rendered("pandemonium_string_path_ensure_end_slash") }}
{{ force_mark_rendered("pandemonium_string_path_get_prev_dir") }}
{{ force_mark_rendered("pandemonium_string_print_unicode_error") }}
{{ force_mark_rendered("pandemonium_string_property_name_encode") }}
{{ force_mark_rendered("pandemonium_string_quote") }}
{{ force_mark_rendered("pandemonium_string_quote_quotechar") }}
{{ force_mark_rendered("pandemonium_string_remove") }}
{{ force_mark_rendered("pandemonium_string_repeat") }}
{{ force_mark_rendered("pandemonium_string_replacec") }}
{{ force_mark_rendered("pandemonium_string_resize") }}
{{ force_mark_rendered("pandemonium_string_rsplit_allow_empty") }}
{{ force_mark_rendered("pandemonium_string_rsplit_maxsplit") }}
{{ force_mark_rendered("pandemonium_string_set") }}
{{ force_mark_rendered("pandemonium_string_set_length") }}
{{ force_mark_rendered("pandemonium_string_sha1_buffer") }}
{{ force_mark_rendered("pandemonium_string_sha1_text") }}
{{ force_mark_rendered("pandemonium_string_size") }}
{{ force_mark_rendered("pandemonium_string_split_floats_allow_empty") }}
{{ force_mark_rendered("pandemonium_string_split_floats_mk_allow_empty") }}
{{ force_mark_rendered("pandemonium_string_split_ints_allow_empty") }}
{{ force_mark_rendered("pandemonium_string_split_ints_mk_allow_empty") }}
{{ force_mark_rendered("pandemonium_string_split_maxsplit") }}
{{ force_mark_rendered("pandemonium_string_substr_index") }}
{{ force_mark_rendered("pandemonium_string_to_ascii_buffer") }}
{{ force_mark_rendered("pandemonium_string_to_bool") }}
{{ force_mark_rendered("pandemonium_string_to_intc") }}
{{ force_mark_rendered("pandemonium_string_to_intc_len") }}
{{ force_mark_rendered("pandemonium_string_to_intc_len_clamp") }}
{{ force_mark_rendered("pandemonium_string_to_uint") }}
{{ force_mark_rendered("pandemonium_string_to_utf16_buffer") }}
{{ force_mark_rendered("pandemonium_string_to_utf32_buffer") }}
{{ force_mark_rendered("pandemonium_string_to_utf8_buffer") }}
{{ force_mark_rendered("pandemonium_string_unicode_at") }}
{{ force_mark_rendered("pandemonium_string_unquote") }}
{{ force_mark_rendered("pandemonium_string_uri_decode") }}
{{ force_mark_rendered("pandemonium_string_uri_encode") }}
{{ force_mark_rendered("pandemonium_string_utf16") }}
{{ force_mark_rendered("pandemonium_string_utf16_byte_length") }}
{{ force_mark_rendered("pandemonium_string_utf8_byte_length") }}
{{ force_mark_rendered("pandemonium_string_validate_identifier") }}
{{ force_mark_rendered("pandemonium_string_validate_node_name") }}
{{ force_mark_rendered("pandemonium_string_wchar_to_double") }}
{{ force_mark_rendered("pandemonium_string_wchar_to_float") }}

# END TODO


{# pandemonium_char_string is not really a bultin type...#}
{{ force_mark_rendered("pandemonium_char_string_destroy") }}
{{ force_mark_rendered("pandemonium_char_string_get_data") }}
{{ force_mark_rendered("pandemonium_char_string_length") }}
{# Those methods are present in gdnative_api.json but not in the Pandemonium documentation... #}
{{ force_mark_rendered("pandemonium_string_ascii") }}
{{ force_mark_rendered("pandemonium_string_ascii_extended") }}
{{ force_mark_rendered("pandemonium_string_begins_with_char_array") }}
{{ force_mark_rendered("pandemonium_string_c_escape_multiline") }}
{{ force_mark_rendered("pandemonium_string_camelcase_to_underscore") }}
{{ force_mark_rendered("pandemonium_string_camelcase_to_underscore_lowercased") }}
{{ force_mark_rendered("pandemonium_string_char_lowercase") }}
{{ force_mark_rendered("pandemonium_string_char_to_double") }}
{{ force_mark_rendered("pandemonium_string_char_to_int") }}
{{ force_mark_rendered("pandemonium_string_char_to_int64_with_len") }}
{{ force_mark_rendered("pandemonium_string_char_to_int_with_len") }}
{{ force_mark_rendered("pandemonium_string_char_uppercase") }}
{{ force_mark_rendered("pandemonium_string_chars_to_utf8") }}
{{ force_mark_rendered("pandemonium_string_chars_to_utf8_with_len") }}
{{ force_mark_rendered("pandemonium_string_chr") }}
{{ force_mark_rendered("pandemonium_string_find_from") }}
{{ force_mark_rendered("pandemonium_string_findmk") }}
{{ force_mark_rendered("pandemonium_string_findmk_from") }}
{{ force_mark_rendered("pandemonium_string_findmk_from_in_place") }}
{{ force_mark_rendered("pandemonium_string_findn_from") }}
{{ force_mark_rendered("pandemonium_string_format_with_custom_placeholder") }}
{{ force_mark_rendered("pandemonium_string_get_slice") }}
{{ force_mark_rendered("pandemonium_string_get_slice_count") }}
{{ force_mark_rendered("pandemonium_string_get_slicec") }}
{{ force_mark_rendered("pandemonium_string_hash64") }}
{{ force_mark_rendered("pandemonium_string_hash_chars") }}
{{ force_mark_rendered("pandemonium_string_hash_chars_with_len") }}
{{ force_mark_rendered("pandemonium_string_hex_encode_buffer") }}
{{ force_mark_rendered("pandemonium_string_hex_to_int64") }}
{{ force_mark_rendered("pandemonium_string_hex_to_int64_with_prefix") }}
{{ force_mark_rendered("pandemonium_string_hex_to_int_without_prefix") }}
{{ force_mark_rendered("pandemonium_string_is_numeric") }}
{{ force_mark_rendered("pandemonium_string_is_resource_file") }}
{{ force_mark_rendered("pandemonium_string_lpad") }}
{{ force_mark_rendered("pandemonium_string_lpad_with_custom_character") }}
{{ force_mark_rendered("pandemonium_string_md5") }}
{{ force_mark_rendered("pandemonium_string_name_destroy") }}
{{ force_mark_rendered("pandemonium_string_name_get_data_unique_pointer") }}
{{ force_mark_rendered("pandemonium_string_name_get_hash") }}
{{ force_mark_rendered("pandemonium_string_name_get_name") }}
{{ force_mark_rendered("pandemonium_string_name_new") }}
{{ force_mark_rendered("pandemonium_string_name_operator_equal") }}
{{ force_mark_rendered("pandemonium_string_name_operator_less") }}
{{ force_mark_rendered("pandemonium_string_naturalnocasecmp_to") }}
{{ force_mark_rendered("pandemonium_string_num") }}
{{ force_mark_rendered("pandemonium_string_num_int64") }}
{{ force_mark_rendered("pandemonium_string_num_int64_capitalized") }}
{{ force_mark_rendered("pandemonium_string_num_real") }}
{{ force_mark_rendered("pandemonium_string_num_scientific") }}
{{ force_mark_rendered("pandemonium_string_num_with_decimals") }}
{{ force_mark_rendered("pandemonium_string_operator_index") }}
{{ force_mark_rendered("pandemonium_string_operator_index_const") }}
{{ force_mark_rendered("pandemonium_string_parse_utf8") }}
{{ force_mark_rendered("pandemonium_string_parse_utf8_with_len") }}
{{ force_mark_rendered("pandemonium_string_path_to") }}
{{ force_mark_rendered("pandemonium_string_path_to_file") }}
{{ force_mark_rendered("pandemonium_string_replace_first") }}
{{ force_mark_rendered("pandemonium_string_rfind_from") }}
{{ force_mark_rendered("pandemonium_string_rfindn_from") }}
{{ force_mark_rendered("pandemonium_string_rpad") }}
{{ force_mark_rendered("pandemonium_string_rpad_with_custom_character") }}
{{ force_mark_rendered("pandemonium_string_simplify_path") }}
{{ force_mark_rendered("pandemonium_string_split_allow_empty") }}
{{ force_mark_rendered("pandemonium_string_split_floats_mk") }}
{{ force_mark_rendered("pandemonium_string_split_ints") }}
{{ force_mark_rendered("pandemonium_string_split_ints_mk") }}
{{ force_mark_rendered("pandemonium_string_split_spaces") }}
{{ force_mark_rendered("pandemonium_string_sprintf") }}
{{ force_mark_rendered("pandemonium_string_to_real") }}
{{ force_mark_rendered("pandemonium_string_to_float") }}
{{ force_mark_rendered("pandemonium_string_to_double") }}
{{ force_mark_rendered("pandemonium_string_to_int64") }}
{{ force_mark_rendered("pandemonium_string_utf8") }}
{{ force_mark_rendered("pandemonium_string_wchar_to_int") }}
{{ force_mark_rendered("pandemonium_string_word_wrap") }}
{{ force_mark_rendered("pandemonium_string_xml_escape_with_quotes") }}

@cython.final
cdef class GDString:
{% block cdef_attributes %}
    cdef pandemonium_string _gd_data

    @staticmethod
    cdef inline GDString new()

    @staticmethod
    cdef inline GDString new_with_wide_string(wchar_t *content, int size)

    @staticmethod
    cdef inline GDString from_ptr(const pandemonium_string *_ptr)
{% endblock %}

{% block python_defs %}
    def __init__(self, str pystr=None):
        if not pystr:
            {{ force_mark_rendered("pandemonium_string_new" )}}
            gdapi10.pandemonium_string_new(&self._gd_data)
        else:
            pyobj_to_pandemonium_string(pystr, &self._gd_data)

    @staticmethod
    cdef inline GDString new():
        # Call to __new__ bypasses __init__ constructor
        cdef GDString ret = GDString.__new__(GDString)
        gdapi10.pandemonium_string_new(&ret._gd_data)
        return ret

    @staticmethod
    cdef inline GDString new_with_wide_string(wchar_t *content, int size):
        {{ force_mark_rendered("pandemonium_string_new_wchar_clip_to_len") }}
        # Call to __new__ bypasses __init__ constructor
        cdef GDString ret = GDString.__new__(GDString)
        gdapi10.pandemonium_string_new_wchar_clip_to_len(&ret._gd_data, content, size)
        return ret

    @staticmethod
    cdef inline GDString from_ptr(const pandemonium_string *_ptr):
        # Call to __new__ bypasses __init__ constructor
        cdef GDString ret = GDString.__new__(GDString)
        # `pandemonium_string` is a cheap structure pointing on a refcounted buffer.
        # Unlike it name could let think, `pandemonium_string_new_copy` only
        # increments the refcount of the underlying structure.
        {{ force_mark_rendered("pandemonium_string_new_copy") }}
        gdapi10.pandemonium_string_new_copy(&ret._gd_data, _ptr)
        return ret

    def __dealloc__(GDString self):
        # /!\ if `__init__` is skipped, `_gd_data` must be initialized by
        # hand otherwise we will get a segfault here
        {{ force_mark_rendered("pandemonium_string_destroy" )}}
        gdapi10.pandemonium_string_destroy(&self._gd_data)

    def __repr__(GDString self):
        return f"<GDString({str(self)!r})>"

    def __str__(GDString self):
        return pandemonium_string_to_pyobj(&self._gd_data)

    {{ render_operator_eq() | indent }}
    {{ render_operator_ne() | indent }}
    {{ render_operator_lt() | indent }}

    {{ render_method("hash", py_name="__hash__") | indent }}
    {{ render_method("operator_plus", py_name="__add__") | indent }}

    {{ render_method("begins_with") | indent }}
    {{ render_method("bigrams") | indent }}
    {{ render_method("c_escape") | indent }}
    {{ render_method("c_unescape") | indent }}
    {{ render_method("capitalize") | indent }}
    {{ render_method("casecmp_to") | indent }}
    {{ render_method("count") | indent }}
    {{ render_method("countn") | indent }}
    {{ render_method("dedent") | indent }}
    {{ render_method("empty") | indent }}
    {{ render_method("ends_with") | indent }}
    {{ render_method("erase") | indent }}
    {{ render_method("find") | indent }}
    {{ render_method("find_last") | indent }}
    {{ render_method("findn") | indent }}
    {{ render_method("format") | indent }}
    {{ render_method("get_base_dir") | indent }}
    {{ render_method("get_basename") | indent }}
    {{ render_method("get_extension") | indent }}
    {{ render_method("get_file") | indent }}
    {{ render_method("hash") | indent }}
    {{ render_method("hex_to_int") | indent }}
    {{ render_method("http_escape") | indent }}
    {{ render_method("http_unescape") | indent }}

    @staticmethod
    def humanize_size(size_t size):
        {{ force_mark_rendered("pandemonium_string_humanize_size") }}
        cdef GDString __ret = GDString.__new__(GDString)
        __ret._gd_data = gdapi10.pandemonium_string_humanize_size(size)
        return __ret

    {{ render_method("insert") | indent }}
    {{ render_method("is_abs_path") | indent }}
    {{ render_method("is_rel_path") | indent }}
    {{ render_method("is_subsequence_of") | indent }}
    {{ render_method("is_subsequence_ofi") | indent }}
    {#- {{ render_method("is_valid_filename") | indent }} # TODO: Missing from binding ! #}
    {{ render_method("is_valid_float") | indent }}
    {{ render_method("is_valid_hex_number") | indent }}
    {{ render_method("is_valid_html_color") | indent }}
    {{ render_method("is_valid_identifier") | indent }}
    {{ render_method("is_valid_integer") | indent }}
    {{ render_method("is_valid_ip_address") | indent }}
    {{ render_method("json_escape") | indent }}
    {{ render_method("left") | indent }}
    {{ render_method("length") | indent }}
    {#- {{ render_method("lstrip") | indent }} # TODO: Missing from binding ! #}
    {{ render_method("match") | indent }}
    {{ render_method("matchn") | indent }}
    {{ render_method("md5_buffer") | indent }}
    {{ render_method("md5_text") | indent }}
    {{ render_method("nocasecmp_to") | indent }}
    {{ render_method("ord_at") | indent }}
    {{ render_method("pad_decimals") | indent }}
    {{ render_method("pad_zeros") | indent }}
    {{ render_method("percent_decode") | indent }}
    {{ render_method("percent_encode") | indent }}
    {{ render_method("plus_file") | indent }}
    {#- {{ render_method("repeat") | indent }} # TODO: Missing from binding ! #}
    {{ render_method("replace") | indent }}
    {{ render_method("replacen") | indent }}
    {{ render_method("rfind") | indent }}
    {{ render_method("rfindn") | indent }}
    {{ render_method("right") | indent }}
    {{ render_method("rsplit") | indent }}
    {{ render_method("rstrip") | indent }}
    {#- {{ render_method("sha1_buffer") | indent }} # TODO: Missing from binding ! #}
    {#- {{ render_method("sha1_text") | indent }} # TODO: Missing from binding ! #}
    {{ render_method("sha256_buffer") | indent }}
    {{ render_method("sha256_text") | indent }}
    {{ render_method("similarity") | indent }}
    {{ render_method("split") | indent }}
    {{ render_method("split_floats") | indent }}
    {{ render_method("strip_edges") | indent }}
    {{ render_method("strip_escapes") | indent }}
    {{ render_method("substr") | indent }}
    {#- {{ render_method("to_ascii") | indent }} # TODO: Missing from binding ! #}
    {{ render_method("to_float") | indent }}
    {{ render_method("to_int") | indent }}
    {{ render_method("to_lower") | indent }}
    {{ render_method("to_upper") | indent }}
    {#- {{ render_method("to_utf8") | indent }} # TODO: Missing from binding ! #}
    {{ render_method("trim_prefix") | indent }}
    {{ render_method("trim_suffix") | indent }}
    {{ render_method("xml_escape") | indent }}
    {{ render_method("xml_unescape") | indent }}

{% endblock %}

{%- block python_consts %}
{% endblock -%}
