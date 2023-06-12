# Official Ballerina 2201.7.0 Release Artifacts


## Linux

- **[ballerina-2201.7.0-swan-lake-linux-x64.deb](https://github.com/Miranlfk/ballerina-distribution/releases/download/v2201.7.0/ballerina-2201.7.0-swan-lake-linux-x64.deb)**
- **[ballerina-2201.7.0-swan-lake-linux-x64.rpm](https://github.com/Miranlfk/ballerina-distribution/releases/download/v2201.7.0/ballerina-2201.7.0-swan-lake-linux-x64.rpm)**


## MacOS

- **[ballerina-2201.7.0-swan-lake-macos-x64.pkg](https://github.com/Miranlfk/ballerina-distribution/releases/download/v2201.7.0/ballerina-2201.7.0-swan-lake-macos-x64.pkg)**

## MacOS-ARM

- **[ballerina-2201.7.0-swan-lake-macos-arm-x64.pkg](https://github.com/Miranlfk/ballerina-distribution/releases/download/v2201.7.0/ballerina-2201.7.0-swan-lake-macos-arm-x64.pkg)**

## Windows

- **[ballerina-2201.7.0-swan-lake-windows-x64.msi](https://github.com/Miranlfk/ballerina-distribution/releases/download/v2201.7.0/ballerina-2201.7.0-swan-lake-windows-x64.msi)**


For more builds across platforms and architectures see the `Assets` section below.


## Signatures and Verification

`Ballerina` uses [sigstore/cosign](https://github.com/sigstore/cosign) for signing and verifying the release artifacts.


Below is an example of using `cosign` to verify the release artifact:

```
cosign verify-blob ballerina-2201.7.0-swan-lake-linux-x64.deb --certificate ballerina-2201.7.0-swan-lake-linux-x64.deb.pem --signature ballerina-2201.7.0-swan-lake-linux-x64.deb.sig --certificate-identity=https://github.com/Miranlfk/ballerina-distribution/.github/workflows/publish-release.yml@refs/heads/master --certificate-oidc-issuer=https://token.actions.githubusercontent.com
```
