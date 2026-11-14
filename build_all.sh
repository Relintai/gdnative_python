#!/bin/bash
set -e

basedir=$(pwd)/

project_root=$(pwd)/
img_version=pe

mkdir -p logs

#CUSTOM_ENVVARS="-e <> -e <>";./build_all.sh

custom_envvars=""

# Windows Build
docker run ${custom_envvars} \
	      -v ${basedir}/engine_build_scripts:/root/engine_build_scripts \
	      -v ${project_root}:/root/project \
	      -w /root/project pandemonium-windows:${img_version} \
	      bash /root/engine_build_scripts/windows.sh "$@" 2>&1 | tee logs/windows.log

# Linux Build
docker run ${custom_envvars} \
        -v ${basedir}/engine_build_scripts:/root/engine_build_scripts \
        -v ${project_root}:/root/project \
        -w /root/project pandemonium-linux:${img_version} \
        bash /root/engine_build_scripts/linux.sh "$@" 2>&1 | tee logs/linux.log

# OSX Build
docker run ${custom_envvars} \
        -v ${basedir}/engine_build_scripts:/root/engine_build_scripts \
        -v ${project_root}:/root/project \
        -w /root/project pandemonium-osx:${img_version} \
        bash /root/engine_build_scripts/osx.sh "$@" 2>&1 | tee logs/osx.log

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
