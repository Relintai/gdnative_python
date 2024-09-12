#!/bin/bash
set -e

basedir=$(pwd)/

cd ../..

project_root=$(pwd)/
img_version=pgp

mkdir -p logs

custom_envvars=''

if [[ -z "${OFFICIAL}" ]]; then
  custom_envvars='-e BUILD_NAME=official'
fi

# Windows Build
docker run ${custom_envvars} \
	      -v ${basedir}/engine_build_scripts:/root/engine_build_scripts \
	      -v ${project_root}:/root/project \
	      -w /root/project gdnative-python-windows:${img_version} \
	      bash /root/engine_build_scripts/windows.sh "$@" 2>&1 | tee logs/windows.log

# Linux Build
docker run ${custom_envvars} \
        -v ${basedir}/engine_build_scripts:/root/engine_build_scripts \
        -v ${project_root}:/root/project \
        -w /root/project gdnative-python-linux:${img_version} \
        bash /root/engine_build_scripts/linux.sh "$@" 2>&1 | tee logs/linux.log

# OSX Build
docker run ${custom_envvars} \
        -v ${basedir}/engine_build_scripts:/root/engine_build_scripts \
        -v ${project_root}:/root/project \
        -w /root/project gdnative-python-osx:${img_version} \
        bash /root/engine_build_scripts/osx.sh "$@" 2>&1 | tee logs/osx.log

# Check files

cd ./bin/

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
