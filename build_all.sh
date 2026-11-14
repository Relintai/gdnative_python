#!/bin/bash
set -e

basedir=$(pwd)/

project_root=$(pwd)/
img_version=gdnp

mkdir -p logs

#CUSTOM_ENVVARS="-e <> -e <>";./build_all.sh

custom_envvars=""

# Linux Build
docker run ${custom_envvars} \
        -v ${project_root}:/root/project \
        -w /root/project pandemonium-linux:${img_version} \
        bash /root/project/in_container_build_scripts/linux.sh "$@" 2>&1 | tee logs/linux.log

# Windows Build 64
docker run ${custom_envvars} \
	      -v ${basedir}/engine_build_scripts:/root/engine_build_scripts \
	      -v ${project_root}:/root/project \
	      -w /root/project pandemonium-windows:${img_version} \
	      bash /root/project/in_container_build_scripts/windows-64.sh "$@" 2>&1 | tee logs/windows-64.log

# Windows Build 32
docker run ${custom_envvars} \
	      -v ${basedir}/engine_build_scripts:/root/engine_build_scripts \
	      -v ${project_root}:/root/project \
	      -w /root/project pandemonium-windows:${img_version} \
	      bash /root/project/in_container_build_scripts/windows-32.sh "$@" 2>&1 | tee logs/windows-32.log

# OSX Build - TODO
#docker run ${custom_envvars} \
#        -v ${project_root}:/root/project \
#        -w /root/project pandemonium-osx:${img_version} \
#        bash /root/project/in_container_build_scripts/osx.sh "$@" 2>&1 | tee logs/osx.log

# Check files

cd ./build/

files=(
  # Windows
  "pandemonium.windows.opt.64.exe"

  # Linux
  "pandemonium.x11.opt.32"

  # OSX
  "pandemonium.osx.opt.universal"
)

error=0

for f in ${files[*]} 
do
if [ ! -e $f ]; then
  error=1
  echo "$f is not present!"
fi
done

if [ $error -eq 0 ]; then
  echo "All files are present!"
fi

cd ..
