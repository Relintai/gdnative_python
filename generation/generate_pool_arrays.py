import os
import argparse
import json
import re
from keyword import iskeyword
from collections import defaultdict
from jinja2 import Environment, FileSystemLoader


BASEDIR = os.path.dirname(__file__)
env = Environment(
    loader=FileSystemLoader(f"{BASEDIR}/pool_arrays_templates"),
    trim_blocks=True,
    lstrip_blocks=True,
)


class TypeItem:
    def __init__(self, **kwargs):
        self.__dict__.update(**kwargs)


TYPES = [
    # Base types
    TypeItem(
        gd_pool=f"pandemonium_pool_int_array",
        py_pool=f"PoolIntArray",
        gd_value=f"pandemonium_int",
        py_value=f"pandemonium_int",
        is_base_type=True,
        is_stack_only=True,
    ),
    TypeItem(
        gd_pool=f"pandemonium_pool_real_array",
        py_pool=f"PoolRealArray",
        gd_value=f"pandemonium_real",
        py_value=f"pandemonium_real",
        is_base_type=True,
        is_stack_only=True,
    ),
    TypeItem(
        gd_pool="pandemonium_pool_byte_array",
        py_pool="PoolByteArray",
        gd_value="uint8_t",
        py_value="uint8_t",
        is_base_type=True,
        is_stack_only=True,
    ),
    # Stack only builtin types
    TypeItem(
        gd_pool=f"pandemonium_pool_vector2_array",
        py_pool=f"PoolVector2Array",
        gd_value=f"pandemonium_vector2",
        py_value=f"Vector2",
        is_base_type=False,
        is_stack_only=True,
    ),
    TypeItem(
        gd_pool=f"pandemonium_pool_vector2i_array",
        py_pool=f"PoolVector2iArray",
        gd_value=f"pandemonium_vector2i",
        py_value=f"Vector2i",
        is_base_type=False,
        is_stack_only=True,
    ),
    TypeItem(
        gd_pool=f"pandemonium_pool_vector3_array",
        py_pool=f"PoolVector3Array",
        gd_value=f"pandemonium_vector3",
        py_value=f"Vector3",
        is_base_type=False,
        is_stack_only=True,
    ),
    TypeItem(
        gd_pool=f"pandemonium_pool_vector3i_array",
        py_pool=f"PoolVector3iArray",
        gd_value=f"pandemonium_vector3i",
        py_value=f"Vector3i",
        is_base_type=False,
        is_stack_only=True,
    ),
    TypeItem(
        gd_pool=f"pandemonium_pool_vector4_array",
        py_pool=f"PoolVector4Array",
        gd_value=f"pandemonium_vector4",
        py_value=f"Vector4",
        is_base_type=False,
        is_stack_only=True,
    ),
    TypeItem(
        gd_pool=f"pandemonium_pool_vector4i_array",
        py_pool=f"PoolVector4iArray",
        gd_value=f"pandemonium_vector4i",
        py_value=f"Vector4i",
        is_base_type=False,
        is_stack_only=True,
    ),
    TypeItem(
        gd_pool=f"pandemonium_pool_color_array",
        py_pool=f"PoolColorArray",
        gd_value=f"pandemonium_color",
        py_value=f"Color",
        is_base_type=False,
        is_stack_only=True,
    ),
    # Stack&heap builtin types
    TypeItem(
        gd_pool="pandemonium_pool_string_array",
        py_pool="PoolStringArray",
        gd_value="pandemonium_string",
        py_value="GDString",
        is_base_type=False,
        is_stack_only=False,
    ),
]


def generate_pool_array(output_path):
    template = env.get_template("pool_arrays.tmpl.pyx")
    out = template.render(types=TYPES)
    with open(output_path, "w") as fd:
        fd.write(out)

    pxd_output_path = output_path.rsplit(".", 1)[0] + ".pxd"
    template = env.get_template("pool_arrays.tmpl.pxd")
    out = template.render(types=TYPES)
    with open(pxd_output_path, "w") as fd:
        fd.write(out)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Generate pandemonium pool_x_array builtins bindings files"
    )
    parser.add_argument("--output", "-o", default=None)
    args = parser.parse_args()
    generate_pool_array(args.output or f"pool_arrays.pyx")
