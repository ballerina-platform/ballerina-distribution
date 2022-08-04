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
BALLERINA_PLATFORM=ballerina-${BALLERINA_VERSION}-macos
BALLERINA_INSTALL_DIRECTORY=ballerina-${BALLERINA_VERSION}
BALLERINA_DIST_VERSION="$(cut -d'-' -f1 <<<${BALLERINA_VERSION})"

echo "Build started at" $(date +"%Y-%m-%d %H:%M:%S")

function deleteTargetDirectory() {
    echo "Deleting target directory"
    rm -rf target
}

function extractPack() {
    echo "Extracting the ballerina distribution, " $1
    rm -rf target/original
    mkdir -p target/original
    unzip $1 -d target/original > /dev/null 2>&1
    mv target/original/$2 target/original/${BALLERINA_INSTALL_DIRECTORY}
}

function createPackInstallationDirectory() {
    rm -rf target/darwin
    cp -r darwin target/darwin

    sed -i -e 's/__BALLERINA_VERSION__/'${BALLERINA_DIST_VERSION}'/g' target/darwin/scripts/postinstall
    chmod -R 755 target/darwin/scripts/postinstall

    sed -i -e 's/__BALLERINA_VERSION__/'${BALLERINA_VERSION}'/g' target/darwin/Distribution
    chmod -R 755 target/darwin/Distribution

    rm -rf target/darwinpkg
    mkdir -p target/darwinpkg
    chmod -R 755 target/darwinpkg

    mkdir -p target/darwinpkg/etc/paths.d
    chmod -R 755 target/darwinpkg/etc/paths.d
    
    echo "/Library/Ballerina/bin" >> target/darwinpkg/etc/paths.d/bal
    chmod -R 644 target/darwinpkg/etc/paths.d/bal

    mkdir -p target/darwinpkg/Library/Ballerina
    chmod -R 755 target/darwinpkg/Library/Ballerina

    mv target/original/${BALLERINA_INSTALL_DIRECTORY}/* target/darwinpkg/Library/Ballerina/


    rm -rf target/package
    mkdir -p target/package
    chmod -R 755 target/package

    mkdir -p target/pkg
    chmod -R 755 target/pkg
}

function buildPackage() {
    pkgbuild --identifier org.ballerina.${BALLERINA_VERSION} \
    --version ${BALLERINA_VERSION} \
    --scripts target/darwin/scripts \
    --root target/darwinpkg \
    target/package/ballerina.pkg
}

function buildProduct() {
    productbuild --distribution target/darwin/Distribution \
    --resources target/darwin/Resources \
    --package-path target/package \
    target/pkg/$1 > /dev/null 2>&1
}

function createBallerinaPlatform() {
    echo "Creating ballerina platform installer"
    extractPack "$BALLERINA_DISTRIBUTION_LOCATION/$BALLERINA_PLATFORM.zip" ${BALLERINA_PLATFORM}
    createPackInstallationDirectory true
    buildPackage
    buildProduct ballerina-${BALLERINA_VERSION}-macos-x64.pkg
}

deleteTargetDirectory

if [ "$BUILD_ALL_DISTRIBUTIONS" == "true" ]; then
    echo "Creating all distributions"
    # createBallerinaRuntime
    createBallerinaPlatform
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
