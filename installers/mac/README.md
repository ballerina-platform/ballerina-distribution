# macOS installers

This directory builds the Ballerina macOS installers (`.pkg`) for Intel (`macos-x64`) and Apple silicon (`macos-arm-x64`).

| File | Purpose |
| :--- | :--- |
| `build-ballerina-macos-x64.sh` | Builds the `.pkg` from a macOS distribution zip. Signs it with a Developer ID Installer identity when `MACOS_INSTALLER_SIGN_IDENTITY` is set. |
| `sign-native-libs.sh` | Code signs the native libraries (`*.dylib`, `*.jnilib`) bundled inside the JAR files of a macOS distribution zip, in place. |
| `darwin/` | Installer templates (distribution definition, post-install script and resources). |

## Signing and notarization

The installers built by the **Publish release** workflow are not signed. The **Sign macOS Installers** workflow (`.github/workflows/sign-macos-installers.yml`) replaces them with signed and notarized installers. For each architecture, it:

1. Downloads `ballerina-<version>-swan-lake-macos[-arm].zip` from the GitHub release.
2. Signs the native libraries inside the JAR files with the Developer ID Application identity, using the hardened runtime and a secure timestamp (`sign-native-libs.sh`).
3. Builds the `.pkg` and signs it with the Developer ID Installer identity (`build-ballerina-macos-x64.sh`).
4. Notarizes the `.pkg` with Apple, then staples the notarization ticket to it.
5. Regenerates the `.sha256` file, then replaces the `.pkg` and `.sha256` files in the GitHub release.

### Release order

1. Run **Publish release**.
2. Run **Sign macOS Installers** with the release version, e.g. `2201.14.1`, or `2201.14.1-rc1` for a pre-release tag. Leave **uploadToRelease** unchecked for a dry run: the signed installers are then uploaded as workflow artifacts instead.
3. Run **Sign release artifacts**, which re-creates the cosign `.pem` and `.sig` files of the replaced installers. The two workflows share a concurrency group, so they never run at the same time for a release.
4. Run **Publish Release Artifacts**, which publishes the installers of the GitHub release.

### One-time setup

The workflow runs in the `macos-signing` GitHub environment. Store the secrets below as environment secrets of `macos-signing`, not as repository secrets. In the environment settings, allow deployments only from protected branches and add required reviewers, so that a workflow change in another branch cannot read the signing certificates.

| Secret | Value |
| :--- | :--- |
| `MACOS_APP_CERTIFICATE` | Base64 encoded `.p12` of the Developer ID Application certificate and its private key |
| `MACOS_APP_CERTIFICATE_PASSWORD` | Password of the above `.p12` |
| `MACOS_INSTALLER_CERTIFICATE` | Base64 encoded `.p12` of the Developer ID Installer certificate and its private key. Can be left empty if `MACOS_APP_CERTIFICATE` contains both identities. |
| `MACOS_INSTALLER_CERTIFICATE_PASSWORD` | Password of the above `.p12` |
| `MACOS_NOTARY_APPLE_ID` | Apple ID of a member of the Apple Developer team, used for notarization |
| `MACOS_NOTARY_APP_PASSWORD` | App-specific password of the above Apple ID, created at [account.apple.com](https://account.apple.com) |

The Apple Developer team ID is read from the signing identity, and the keychain used by the workflow gets a random password, so neither needs a secret.

To create the certificate secrets on the Mac that holds the signing identities:

1. In **Keychain Access**, select the **Developer ID Application** certificate together with its private key, choose **File > Export Items**, and save it as a `.p12` file with a strong password. Do the same for the **Developer ID Installer** certificate. Export only these identities.
2. Store each `.p12` as a secret, then delete the `.p12` files.

    ```bash
    base64 -i developer-id-application.p12 | gh secret set MACOS_APP_CERTIFICATE --env macos-signing --repo ballerina-platform/ballerina-distribution
    base64 -i developer-id-installer.p12 | gh secret set MACOS_INSTALLER_CERTIFICATE --env macos-signing --repo ballerina-platform/ballerina-distribution
    rm developer-id-application.p12 developer-id-installer.p12
    ```

Never commit certificates, private keys or passwords to this repository.

### Signing on a local Mac

If the signing identities are in your login keychain, you can produce the same installer locally.

```bash
# List the identities in your keychains.
security find-identity -v

export MACOS_APP_SIGN_IDENTITY="Developer ID Application: <Organization> (<TEAM_ID>)"
export MACOS_INSTALLER_SIGN_IDENTITY="Developer ID Installer: <Organization> (<TEAM_ID>)"

# Run from this directory, with ballerina-<version>-swan-lake-macos-arm.zip in <path>.
bash sign-native-libs.sh <path>/ballerina-<version>-swan-lake-macos-arm.zip
./build-ballerina-macos-x64.sh -v <version>-swan-lake -p <path> -a arm

# Store the notarization credentials in your keychain once. It prompts for the app-specific password.
xcrun notarytool store-credentials ballerina-notary --apple-id <apple-id> --team-id <TEAM_ID>

# Notarize and staple the installer.
xcrun notarytool submit target/pkg/ballerina-<version>-swan-lake-macos-arm-x64.pkg \
    --keychain-profile ballerina-notary --wait
xcrun stapler staple target/pkg/ballerina-<version>-swan-lake-macos-arm-x64.pkg
```

Omit `-a arm` and the `-arm` suffixes to build the Intel installer.
