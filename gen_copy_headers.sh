
./pandemonium_engine/bin/pandemonium.x11.opt.tools.64 --gdnative-generate-json-api ./pandemonium_engine/modules/gdnative/api.json

cd gdnative_python/pandemonium_headers/
rm -Rf *

cp -R ../../pandemonium_engine/modules/gdnative/include/* .
cp ../../pandemonium_engine/modules/gdnative/api.json .
cp ../../pandemonium_engine/modules/gdnative/gdnative_api.json .

cd ../..
