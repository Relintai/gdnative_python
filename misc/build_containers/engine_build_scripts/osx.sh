#!/bin/bash
set -e

# OSX 
scons production=yes tools=yes target=release_debug custom_modules_shared=no debug_symbols=no platform=osx arch=x86_64 "$@" osxcross_sdk=darwin23.3


# OSX lipo

#pushd misc/osx

#./lipo.sh

#popd


