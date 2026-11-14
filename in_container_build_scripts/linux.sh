#!/bin/bash
set -e

rm -Rf venv

python3 -m venv venv
. ./venv/bin/activate
pip install -r requirements.txt

rm -Rf build/x11-64
rm -Rf build/dist

scons platform=x11-64 python_version=3.15 CC=clang release "$@"

rm -Rf build/x11-64
rm -Rf build/dist

scons platform=x11-64 python_version=3.14 CC=clang release "$@"

rm -Rf build/x11-64
rm -Rf build/dist

scons platform=x11-64 python_version=3.13 CC=clang release "$@"

rm -Rf build/x11-64
rm -Rf build/dist

scons platform=x11-64 python_version=3.12 CC=clang release "$@"

rm -Rf build/x11-64
rm -Rf build/dist

scons platform=x11-64 python_version=3.11 CC=clang release "$@"

rm -Rf build/x11-64
rm -Rf build/dist

scons platform=x11-64 python_version=3.9 CC=clang release "$@"

rm -Rf build/x11-64
rm -Rf build/dist



