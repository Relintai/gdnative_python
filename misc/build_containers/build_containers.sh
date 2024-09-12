#!/bin/bash
set -e

files_root=$(pwd)/files
img_version=pe

mkdir -p logs

# You can add --no-cache  as an option to docker_build below to rebuild all containers from scratch
export docker_build="docker build --build-arg img_version=${img_version} "

docker build -t gdnative-python-fedora:${img_version} -f Dockerfile.base . 2>&1 | tee logs/base.log
$docker_build -t gdnative-python-linux:${img_version} -f Dockerfile.linux . 2>&1 | tee logs/linux.log
$docker_build -t gdnative-python-windows:${img_version} -f Dockerfile.windows . 2>&1 | tee logs/windows.log

XCODE_SDK=15.2
OSX_SDK=14.2
if [ ! -e files/MacOSX${OSX_SDK}.sdk.tar.xz ]; then
  if [ ! -e files/Xcode_${XCODE_SDK}.xip ]; then
    echo "files/Xcode_${XCODE_SDK}.xip is required. It can be downloaded from https://developer.apple.com/download/more/ with a valid apple ID."
    exit 1
  fi

  echo "Building OSX and iOS SDK packages. This will take a while"
  $docker_build -t gdnative-python-xcode-packer:${img_version} -f Dockerfile.xcode . 2>&1 | tee logs/xcode.log
  docker run -it --rm -v ${files_root}:/root/files -e XCODE_SDKV="${XCODE_SDK}" -e OSX_SDKV="${OSX_SDK}"  gdnative-python-xcode-packer:${img_version} 2>&1 | tee logs/xcode_packer.log
fi

$docker_build -t gdnative-python-osx:${img_version} -f Dockerfile.osx . 2>&1 | tee logs/osx.log

