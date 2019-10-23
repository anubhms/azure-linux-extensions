#! /bin/bash
set -e
source omsagent.version

usage()
{
    local basename=`basename $0`
    echo
    echo "$basename <PATH_TO_OMSAGENT_SHELL_BUNDLE>"
}

bundle_path=$1
output_path=$2
PACKAGE_NAME="oms$OMS_EXTENSION_VERSION.zip"
if [[ "$1" == "--help" ]]; then
    usage
    exit 0
elif [[ ! -f $bundle_path ]]; then
    echo "OMS bundle '$bundle_path' not found"
    exit 1
fi

if [[ "$output_path" == "" ]]; then
    output_path="../"
fi
echo "Packaging extension $PACKAGE_NAME to $output_path"
rm -rf Fairfax/ Mooncake/ test/ extension-test/ references
cp -r ../Utils .
cp ../Common/WALinuxAgent-2.0.16/waagent .

# cleanup packages
rm -rf packages
mkdir -p packages
#copy shell bundle to packages/
cp $bundle_path packages/

zip -r $output_path/$PACKAGE_NAME * 