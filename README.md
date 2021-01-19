# Ballerina Distribution
[![Ballerina Distribution Build](https://github.com/ballerina-platform/ballerina-distribution/workflows/Ballerina%20Distribution%20Build/badge.svg)](https://github.com/ballerina-platform/ballerina-distribution/actions?query=workflow%3A%22Ballerina+Distribution+Build%22)
[![Daily build](https://github.com/ballerina-platform/ballerina-distribution/workflows/Daily%20build/badge.svg)](https://github.com/ballerina-platform/ballerina-distribution/actions?query=workflow%3A%22Daily+build%22)

The Ballerina distribution repository builds the final Ballerina distributions. It combines the bal runtime with standard libraries and language extensions.

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

* JDK11 ([Adopt OpenJDK11](https://adoptopenjdk.net/) or any other OpenJDK distribution)

#### Building the source

1. Clone this repository using the following command.

    ```bash
    git clone https://github.com/ballerina-platform/ballerina-distribution
    ```
2. This repository is depending on Github packages. You need to have a personal access token with read package permissions. Then you need to set following environment variables.
    ```bash
    export packageUser=<Your github username>
    export packagePAT=<Your personal access token>
    ```
3. Run the Gradle build command ``./gradlew build`` from the repository root directory.
4. Extract the Ballerina distribution created at `ballerina/target/ballerina-<version>-SNAPSHOT.zip`.

## Contributing to Ballerina

As an open source project, Ballerina welcomes contributions from the community. To start contributing, read these [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md) for information on how you should go about contributing to our project.

Check the issue tracker for open issues that interest you. We look forward to receiving your contributions.

## License

Ballerina code is distributed under [Apache license 2.0](https://github.com/ballerina-platform/ballerina-lang/blob/master/LICENSE).

## Useful links

* The ballerina-dev@googlegroups.com mailing list is for discussing code changes to the Ballerina project.
* Chat live with us on our [Slack channel](https://ballerina-platform.slack.com/).
* Technical questions should be posted on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
