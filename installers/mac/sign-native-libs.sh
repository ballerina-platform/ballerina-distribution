#!/bin/bash
#
# Code signs the macOS native libraries (*.dylib, *.jnilib) that are bundled
# inside the JAR files of a Ballerina macOS distribution zip, so that an
# installer built from that zip can pass Apple notarization.
#
# Only the native library entries are replaced, inside each JAR and inside the
# distribution zip. Every other entry of the JARs and of the zip is left as is.
#
# Usage:
#   ./sign-native-libs.sh <path to ballerina-<version>-macos[-arm].zip>
#
# Environment variables:
#   MACOS_APP_SIGN_IDENTITY  Required. Name or SHA-1 hash of the
#                            "Developer ID Application" signing identity.
#   MACOS_SIGN_KEYCHAIN      Optional. Keychain that holds the identity.
#                            Defaults to the keychain search list.
#
# Requires macOS (codesign).

set -euo pipefail

function printUsage() {
    echo "Usage: $0 <path to ballerina-<version>-macos[-arm].zip>"
    echo "Required environment variable: MACOS_APP_SIGN_IDENTITY"
    echo "Optional environment variable: MACOS_SIGN_KEYCHAIN"
}

# unzip treats file arguments as wildcard patterns. Escape the wildcard
# characters so that each entry name is matched literally.
function escapePattern() {
    printf '%s' "$1" | sed 's/[][*?\\]/\\&/g'
}

if [ $# -ne 1 ]; then
    printUsage
    exit 1
fi

if [ -z "${MACOS_APP_SIGN_IDENTITY:-}" ]; then
    echo "error: MACOS_APP_SIGN_IDENTITY is not set" >&2
    printUsage
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "error: distribution zip '$1' not found" >&2
    exit 1
fi

DIST_ZIP="$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"

CODESIGN_ARGS=(--force --options runtime --timestamp --sign "${MACOS_APP_SIGN_IDENTITY}")
if [ -n "${MACOS_SIGN_KEYCHAIN:-}" ]; then
    CODESIGN_ARGS+=(--keychain "${MACOS_SIGN_KEYCHAIN}")
fi

WORK_DIR="$(mktemp -d)"
trap 'rm -rf "$WORK_DIR"' EXIT
JAR_ROOT="$WORK_DIR/jars"
LIB_DIR="$WORK_DIR/libs"
mkdir -p "$JAR_ROOT"

echo "Extracting JAR files from $(basename "$DIST_ZIP")"
# Exit code 11 means the zip has no JAR files.
unzip -q "$DIST_ZIP" '*.jar' -d "$JAR_ROOT" || { rc=$?; [ "$rc" -eq 11 ] || exit "$rc"; }

MODIFIED_JARS=()
SIGNED_LIB_COUNT=0

while IFS= read -r -d '' jar; do
    relativeJar="${jar#"$JAR_ROOT"/}"
    entries="$(unzip -Z1 "$jar")"

    nativeLibs=()
    while IFS= read -r entry; do
        case "$entry" in
            *.dylib|*.jnilib) nativeLibs+=("$entry") ;;
        esac
    done <<< "$entries"

    if [ ${#nativeLibs[@]} -eq 0 ]; then
        continue
    fi

    if grep -qiE '^META-INF/[^/]+\.(SF|RSA|DSA|EC)$' <<< "$entries"; then
        echo "warning: $relativeJar is a signed JAR. Replacing its native libraries invalidates the JAR signature." >&2
    fi

    patterns=()
    for lib in "${nativeLibs[@]}"; do
        patterns+=("$(escapePattern "$lib")")
    done

    rm -rf "$LIB_DIR"
    mkdir -p "$LIB_DIR"
    unzip -q -o "$jar" "${patterns[@]}" -d "$LIB_DIR"

    signedLibs=()
    for lib in "${nativeLibs[@]}"; do
        libPath="$LIB_DIR/$lib"
        fileType="$(file -b "$libPath")"
        if [[ "$fileType" != *Mach-O* ]]; then
            echo "Skipping $relativeJar!/$lib (not a Mach-O binary)"
            continue
        fi
        echo "Signing $relativeJar!/$lib"
        codesign "${CODESIGN_ARGS[@]}" "$libPath"
        codesign --verify --strict "$libPath"
        signedLibs+=("$lib")
    done

    if [ ${#signedLibs[@]} -gt 0 ]; then
        # Replace only the signed entries in the JAR.
        (cd "$LIB_DIR" && zip -q -X -D "$jar" "${signedLibs[@]}")
        MODIFIED_JARS+=("$relativeJar")
        SIGNED_LIB_COUNT=$((SIGNED_LIB_COUNT + ${#signedLibs[@]}))
    fi
done < <(find "$JAR_ROOT" -type f -name '*.jar' -print0)

if [ ${#MODIFIED_JARS[@]} -eq 0 ]; then
    echo "No macOS native libraries found in $(basename "$DIST_ZIP")"
    exit 0
fi

echo "Updating ${#MODIFIED_JARS[@]} JAR file(s) in $(basename "$DIST_ZIP")"
# Replace only the modified JARs in the distribution zip.
(cd "$JAR_ROOT" && zip -q -X -D "$DIST_ZIP" "${MODIFIED_JARS[@]}")

echo "Signed $SIGNED_LIB_COUNT native librar(y/ies) in ${#MODIFIED_JARS[@]} JAR file(s)"
