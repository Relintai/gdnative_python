#!/bin/bash
set -e

rm -Rf venv

python3 -m venv venv
. ./venv/bin/activate
pip install -r requirements.txt

rm -Rf build/windows-64
rm -Rf build/dist


wineserver -p


$(command -v wine64 || command -v wine || false) wineboot 

    for arch in x86 x64 arm arm64; do \
        [ ! -d /opt/msvc/kits/10/lib/*/um/$arch ] || \
        /opt/msvc/bin/$arch/cl hello.c -Fehello-$arch.exe || exit 1; \
    done

scons platform=windows-64 python_version=3.15 CC=/opt/msvc/bin/x64/cl release "$@"

rm -Rf build/windows-64
rm -Rf build/dist

scons platform=windows-64 python_version=3.14 release "$@"

rm -Rf build/windows-64
rm -Rf build/dist

scons platform=windows-64 python_version=3.13 release "$@"

rm -Rf build/windows-64
rm -Rf build/dist

scons platform=windows-64 python_version=3.12 release "$@"

rm -Rf build/windows-64
rm -Rf build/dist

scons platform=windows-64 python_version=3.11 release "$@"

rm -Rf build/windows-64
rm -Rf build/dist

scons platform=windows-64 python_version=3.9 release "$@"

rm -Rf build/windows-64
rm -Rf build/dist

