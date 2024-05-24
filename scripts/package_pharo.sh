#!/usr/bin/env sh
project_name=$1
smalltalk_name=$2
build_folder=$3
echo "Packaging release of ${project_name} on ${smalltalk_name} from ${build_folder}"
mkdir release
pushd release > /dev/null
cp "${build_folder}/TravisCI.image" "${project_name}.image"
cp "${build_folder}/TravisCI.changes" "${project_name}.changes"
cp "${build_folder}"/*.sources ./
cp -R "${build_folder}/pharo-local" ./
echo "${smalltalk_name}" | sed -e 's/.*\-//g ; s/\..*//g ; s/$/0/' > pharo.version
zip -r ../$project_name.zip ./* > /dev/null
popd > /dev/null

