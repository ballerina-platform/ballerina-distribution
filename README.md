# Ballerina Distribution

[![Ballerina Distribution Build](https://github.com/ballerina-platform/ballerina-distribution/workflows/Build/badge.svg)](https://github.com/ballerina-platform/ballerina-distribution/actions?query=workflow%3A%22Build%22)
[![Daily build](https://github.com/ballerina-platform/ballerina-distribution/workflows/Daily%20build/badge.svg)](https://github.com/ballerina-platform/ballerina-distribution/actions?query=workflow%3A%22Daily+build%22)

The Ballerina distribution repository builds the final Ballerina distributions. It combines the Ballerina runtime with standard libraries and language extensions.

## Table of contents

- [Getting started](#getting-started)
- [Download and install](#download-and-install)
- [Contributing to Ballerina](#contributing-to-ballerina)
- [License](#license)
- [Useful links](#useful-links)

## Getting started

You can use one of the following options to try out Ballerina.

* [Getting Started](https://ballerina.io/learn/getting-started/)
* [Quick Tour](https://ballerina.io/learn/quick-tour/)
* [Ballerina by Example](https://ballerina.io/learn/by-example/)

## Download and install

### Download the binary

You can download the Ballerina distribution at http://ballerina.io/downloads.

### Install from source

Alternatively, you can install Ballerina from the source using the following instructions.

#### Prerequisites

* JDK21 ([Adopt OpenJDK21](https://adoptopenjdk.net/) or any other OpenJDK distribution)

#### Building the source

1. Clone this repository using the following command.

    ```bash
    git clone https://github.com/ballerina-platform/ballerina-distribution
    ```
2. This repository is depending on Github packages. You need to have a personal access token with read package permissions. Then you need to set following environment variables.
    
    Linux/Unix
    ```bash
    export packageUser=<Your github username>
    export packagePAT=<Your personal access token>
    ```
    
    Windows
    ```batch
    set packageUser=<Your github username>
    set packagePAT=<Your personal access token>
    ```
3. This repository contains central integration tests. You need to have dev access token of the bctestorg organization to run these tests. Then you need to set following environment variables. 

   Linux/Unix
    ```bash
    export BALLERINA_DEV_CENTRAL=true
    export BALLERINA_CENTRAL_ACCESS_TOKEN=<Dev access token>
    ```

   Windows
    ```batch
    set BALLERINA_DEV_CENTRAL=true
    set BALLERINA_CENTRAL_ACCESS_TOKEN=<Dev access token>
    ```
   Else you can disable central integration tests and build the repository.
   
4. Run the Gradle build command ``./gradlew build`` from the repository root directory.
5. Out of the ZIP distributions in the `ballerina/build/distributions/` directory, extract the `ballerina-<version>-SNAPSHOT.zip` file (e.g., `ballerina-swan-lake-beta3-SNAPSHOT.zip`). The other distributions are used for installer generation.

## Contributing to Ballerina

As an open source project, Ballerina welcomes contributions from the community. To start contributing, read these [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md) for information on how you should go about contributing to our project.

Check the issue tracker for open issues that interest you. We look forward to receiving your contributions.

## License

Ballerina code is distributed under [Apache license 2.0](https://github.com/ballerina-platform/ballerina-lang/blob/master/LICENSE).

## Useful links

* The ballerina-dev@googlegroups.com mailing list is for discussing code changes to the Ballerina project.
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Technical questions should be posted on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
