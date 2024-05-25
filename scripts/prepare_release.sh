#!/usr/bin/env sh

readonly build_name="$1"
readonly smalltalk_name="$2"
readonly build_folder="$3"

source "$build_folder/../helpers.sh"
source "$build_folder/../gtoolkit/run.sh"

is_gt() {
    [[ "$smalltalk_name" == GToolkit* ]]
}

is_pharo() {
    [[ "$smalltalk_name" == Pharo* ]]
}

gt_vm_folder() {
    local result
    
    if is_mac_build; then
        result="GlamorousToolkit.app"
    else
        result="bin"
    fi
    
    echo "${result}"
}

echo "Packaging release of ${build_name} on ${smalltalk_name} from ${build_folder}"
mkdir release
pushd release > /dev/null
cp "${build_folder}/TravisCI.image" "${build_name}.image"
cp "${build_folder}/TravisCI.changes" "${build_name}.changes"
cp "${build_folder}"/*.sources ./
cp -R "${build_folder}/pharo-local" ./

if is_gt; then
    cp -R "${build_folder}/gt-extra" ./
    cp -R "${build_folder}/$(gt_vm_folder)" ./
    if is_linux_build; then
        cp -R "${build_folder}/lib" ./
    fi
fi

if is_pharo; then
    echo "${smalltalk_name}" | sed -e 's/.*\-//g ; s/\..*//g ; s/$/0/' > pharo.version
fi

zip -r ../$build_name.zip ./* > /dev/null
popd > /dev/null
