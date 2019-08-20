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
# BALLERINA_RUNTIME=ballerina-runtime-linux-${BALLERINA_VERSION}
BALLERINA_INSTALL_DIRECTORY=ballerina-${BALLERINA_VERSION}

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
    rm -rf target/${BALLERINA_INSTALL_DIRECTORY}/usr/lib/ballerina
    mkdir -p target/${BALLERINA_INSTALL_DIRECTORY}/usr/lib/ballerina
    chmod -R 755 target/${BALLERINA_INSTALL_DIRECTORY}/usr/lib/ballerina
    mv target/original/${BALLERINA_INSTALL_DIRECTORY} target/${BALLERINA_INSTALL_DIRECTORY}/usr/lib/ballerina

    rm -rf target/${BALLERINA_INSTALL_DIRECTORY}/usr/share/doc/${BALLERINA_INSTALL_DIRECTORY}
    mkdir -p target/${BALLERINA_INSTALL_DIRECTORY}/usr/share/doc/${BALLERINA_INSTALL_DIRECTORY}
    chmod -R 755 target/${BALLERINA_INSTALL_DIRECTORY}/usr/share/doc/${BALLERINA_INSTALL_DIRECTORY}
    # cp target/${BALLERINA_INSTALL_DIRECTORY}/usr/lib/ballerina/${BALLERINA_INSTALL_DIRECTORY}/distributions/jballerina-${BALLERINA_VERSION}/COPYRIGHT target/${BALLERINA_INSTALL_DIRECTORY}/usr/share/doc/${BALLERINA_INSTALL_DIRECTORY}/copyright
    # cp target/${BALLERINA_INSTALL_DIRECTORY}/usr/lib/ballerina/${BALLERINA_INSTALL_DIRECTORY}/distributions/jballerina-${BALLERINA_VERSION}/README.md target/${BALLERINA_INSTALL_DIRECTORY}/usr/share/doc/${BALLERINA_INSTALL_DIRECTORY}/README.md
    # cp target/${BALLERINA_INSTALL_DIRECTORY}/usr/lib/ballerina/${BALLERINA_INSTALL_DIRECTORY}/distributions/jballerina-${BALLERINA_VERSION}/LICENSE target/${BALLERINA_INSTALL_DIRECTORY}/usr/share/doc/${BALLERINA_INSTALL_DIRECTORY}/LICENSE
}

function copyDebianDirectory() {
    cp -R resources/DEBIAN target/${BALLERINA_INSTALL_DIRECTORY}/DEBIAN
    sed -i -e 's/__BALLERINA_VERSION__/'${BALLERINA_VERSION}'/g' target/${BALLERINA_INSTALL_DIRECTORY}/DEBIAN/postinst
    sed -i -e 's/__BALLERINA_VERSION__/'${BALLERINA_VERSION}'/g' target/${BALLERINA_INSTALL_DIRECTORY}/DEBIAN/postrm
    sed -i -e 's/__BALLERINA_VERSION__/'${BALLERINA_VERSION}'/g' target/${BALLERINA_INSTALL_DIRECTORY}/DEBIAN/control
    # cp target/${BALLERINA_INSTALL_DIRECTORY}/usr/lib/ballerina/${BALLERINA_INSTALL_DIRECTORY}/distributions/jballerina-${BALLERINA_VERSION}/COPYRIGHT target/${BALLERINA_INSTALL_DIRECTORY}/DEBIAN/copyright
    chmod 755 target/${BALLERINA_INSTALL_DIRECTORY}/DEBIAN/postrm
    chmod 755 target/${BALLERINA_INSTALL_DIRECTORY}/DEBIAN/postinst
}

function createBallerinaPlatform() {
    echo "Creating ballerina platform installer"

    extractPack "$BALLERINA_DISTRIBUTION_LOCATION/$BALLERINA_PLATFORM.zip" ${BALLERINA_PLATFORM}
    createPackInstallationDirectory
    copyDebianDirectory
    mv target/${BALLERINA_INSTALL_DIRECTORY} target/ballerina-linux-installer-x64-${BALLERINA_VERSION}
    fakeroot dpkg-deb --build target/ballerina-linux-installer-x64-${BALLERINA_VERSION}
}

# function createBallerinaRuntime() {
#     echo "Creating ballerina runtime installer"

#     extractPack "$BALLERINA_DISTRIBUTION_LOCATION/$BALLERINA_RUNTIME.zip" ${BALLERINA_RUNTIME}
#     createPackInstallationDirectory
#     copyDebianDirectory
#     mv target/${BALLERINA_INSTALL_DIRECTORY} target/ballerina-runtime-linux-installer-x64-${BALLERINA_VERSION}
#     fakeroot dpkg-deb --build target/ballerina-runtime-linux-installer-x64-${BALLERINA_VERSION}
# }

deleteTargetDirectory

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
