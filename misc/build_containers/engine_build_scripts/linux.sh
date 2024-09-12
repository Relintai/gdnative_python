#!/bin/bash
set -e

export PATH="${GODOT_SDK_LINUX_X86_64}/bin:${BASE_PATH}"

# Linux 64 bit
scons production=yes tools=yes target=release_debug custom_modules_shared=no debug_symbols=no platform=x11 bits=64 "$@"

export PATH="${GODOT_SDK_LINUX_X86_32}/bin:${BASE_PATH}"

# Linux 32 bit
scons production=yes tools=yes target=release_debug custom_modules_shared=no debug_symbols=no platform=x11 bits=32 "$@"

