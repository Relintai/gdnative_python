#!/bin/bash
set -e

img_version=gdnp

# You can add --no-cache  as an option to docker_build below to rebuild all containers from scratch
export docker_build="docker build --build-arg img_version=${img_version} "

docker build -t pandemonium-fedora:${img_version} -f Dockerfile.base . 2>&1 | tee logs/base.log
$docker_build -t pandemonium-linux:${img_version} -f Dockerfile.linux . 2>&1 | tee logs/linux.log
$docker_build -t pandemonium-windows:${img_version} -f Dockerfile.windows . 2>&1 | tee logs/windows.log

