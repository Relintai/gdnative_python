#!/bin/bash
set -e

rm -Rf venv

python3 -m venv venv
. ./venv/bin/activate
pip install -r requirements.txt

rm -Rf build/windows-32
rm -Rf build/dist

scons platform=windows-32 python_version=3.15 release

rm -Rf build/windows-32
rm -Rf build/dist

scons platform=windows-32 python_version=3.14 release

rm -Rf build/windows-32
rm -Rf build/dist

scons platform=windows-32 python_version=3.13 release

rm -Rf build/windows-32
rm -Rf build/dist

scons platform=windows-32 python_version=3.12 release

rm -Rf build/windows-32
rm -Rf build/dist

scons platform=windows-32 python_version=3.11 release

rm -Rf build/windows-32
rm -Rf build/dist

scons platform=windows-32 python_version=3.9 release

rm -Rf build/windows-32
rm -Rf build/dist


