#!/bin/bash

function printUsage() {
    echo "Usage:"
    echo "$0 [options]"
    echo "options:"
    echo "    -v (--version)"
    echo "        version of the ballerina distribution"
    echo "    -p (--path)"
    echo "        path of the ballerina distributions"
    echo "    -d (--dist)"
    echo "        ballerina distribution type either of the followings"
    echo "        If not specified both distributions will be built"
    echo "        1. ballerina"
    echo "        2. ballerina-runtime"
    echo "eg: $0 -v 1.0.0 -p /home/username/Packs"
    echo "eg: $0 -v 1.0.0 -p /home/username/Packs -d ballerina"
}

BUILD_ALL_DISTRIBUTIONS=false
POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case ${key} in
    -v|--version)
    BALLERINA_VERSION="$2"
    shift # past argument
    shift # past value
    ;;
    -p|--path)
    DIST_PATH="$2"
    shift # past argument
    shift # past value
    ;;
    -d|--dist)
    DISTRIBUTION="$2"
    shift # past argument
    shift # past value
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done

if [ -z "$BALLERINA_VERSION" ]; then
    echo "Please enter the version of the ballerina pack"
    printUsage
    exit 1
fi

if [ -z "$DIST_PATH" ]; then
    echo "Please enter the path of the ballerina packs"
    printUsage
    exit 1
fi

if [ -z "$DISTRIBUTION" ]; then
    BUILD_ALL_DISTRIBUTIONS=true
fi

BALLERINA_DISTRIBUTION_LOCATION=${DIST_PATH}
BALLERINA_PLATFORM=ballerina-linux-${BALLERINA_VERSION}
BALLERINA_INSTALL_DIRECTORY=ballerina-${BALLERINA_VERSION}
PLATFORM_SPEC_FILE="ballerina-tools.spec"
SPEC_FILES_LOCATION="rpmbuild/SPECS/"
PLATFORM_SPEC_FILE_LOC=${SPEC_FILES_LOCATION}/${PLATFORM_SPEC_FILE}
RPM_BALLERINA_VERSION=$(echo "${BALLERINA_VERSION//-/.}")

echo "Build started at" $(date +"%Y-%m-%d %H:%M:%S")

function extractPack() {
    echo "Extracting the ballerina distribution, " $1
    rm -rf rpmbuild/SOURCES
    mkdir -p rpmbuild/SOURCES
    unzip $1 -d rpmbuild/SOURCES/ > /dev/null 2>&1
}

# Set variables in SPEC file
# Globals:
#   BALLERINA_VERSION
#   RPM_BALLERINA_VERSION
#   PLATFORM_SPEC_FILE
# Arguments:
# Returns:
#   None
function setupVersion_platform() {
    sed -i "/Version:/c\Version:        ${RPM_BALLERINA_VERSION}" ${PLATFORM_SPEC_FILE_LOC}
    sed -i "/%define _ballerina_version/c\%define _ballerina_version ${BALLERINA_VERSION}" ${PLATFORM_SPEC_FILE_LOC}
    sed -i "/%define _ballerina_tools_dir/c\%define _ballerina_tools_dir ${BALLERINA_PLATFORM}" ${PLATFORM_SPEC_FILE_LOC}
    sed -i "s/export BALLERINA_HOME=/export BALLERINA_HOME=\/usr\/lib64\/ballerina\/ballerina-${BALLERINA_VERSION}/" ${PLATFORM_SPEC_FILE_LOC}
    sed -i "s?SED_BALLERINA_HOME?/usr/lib64/ballerina/ballerina-${BALLERINA_VERSION}?" ${PLATFORM_SPEC_FILE_LOC}
}

# Create Ballerina Platform RPM
# Globals:
#   BALLERINA_DISTRIBUTION_LOCATION
#   BALLERINA_PLATFORM
#   PLATFORM_SPEC_FILE
# Arguments:
# Returns:
#   None
function createBallerinaPlatform() {
    echo "Creating ballerina platform installer"
    extractPack "$BALLERINA_DISTRIBUTION_LOCATION/$BALLERINA_PLATFORM.zip"
    [ -f ${PLATFORM_SPEC_FILE_LOC} ] && rm -f ${PLATFORM_SPEC_FILE_LOC}
    cp resources/${PLATFORM_SPEC_FILE} ${SPEC_FILES_LOCATION}
    setupVersion_platform
    rpmbuild -bb --define "_topdir  $(pwd)/rpmbuild" ${PLATFORM_SPEC_FILE_LOC}
}

if [ "$BUILD_ALL_DISTRIBUTIONS" == "true" ]; then
    echo "Creating all distributions"
    createBallerinaPlatform
    # createBallerinaRuntime
else
    if [ "$DISTRIBUTION" == "ballerina" ]; then
        echo "Creating Ballerina Platform"
        createBallerinaPlatform
    # elif [ "$DISTRIBUTION" == "ballerina-runtime" ]; then
    #     echo "Creating Ballerina Runtime"
    #     createBallerinaRuntime
    else
        echo "Error"
    fi
fi

echo "Build completed at" $(date +"%Y-%m-%d %H:%M:%S")
