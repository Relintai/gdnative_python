#!/bin/bash
set -e

# Windows 64 bit
scons production=yes tools=yes target=release_debug debug_symbols=no platform=windows bits=64 "$@"

# Windows 32 bit
scons production=yes tools=yes target=release_debug debug_symbols=no platform=windows bits=32 "$@"

