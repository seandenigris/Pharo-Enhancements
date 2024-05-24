#!/usr/bin/env sh
build_name=$1
smalltalk_name=$2
build_folder=$3
echo "Packaging release of ${build_name} on ${smalltalk_name} from ${build_folder}"
mkdir release
pushd release > /dev/null
cp "${build_folder}/TravisCI.image" "${build_name}.image"
cp "${build_folder}/TravisCI.changes" "${build_name}.changes"
cp "${build_folder}"/*.sources ./
cp -R "${build_folder}/pharo-local" ./
#Next two lines are only differences from Pharo
cp -R "${build_folder}/gt-extra" ./
cp -R "${build_folder}/vm" ./

#Not sure if this is relevant in the GT world, since it's for Launcher. Maybe just for degubbing?
#echo "${smalltalk_name}" | sed -e 's/.*\-//g ; s/\..*//g ; s/$/0/' > pharo.version

zip -r ../$build_name.zip ./* > /dev/null
popd > /dev/null
