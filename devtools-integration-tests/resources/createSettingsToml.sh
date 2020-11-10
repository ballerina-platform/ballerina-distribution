#!/bin/sh
tmp_dir=$(mktemp -d bal-test-integration-packaging-home)

# shellcheck disable=SC2006
token=`echo 'YWYwMjkyODgtNjhkZC0zOTVmLTk5MzQtYTgyYWRjM2NlYzZi' | base64 --decode`

cat > "$tmp_dir"/Settings.toml <<- "EOF"
[central]
EOF

# shellcheck disable=SC2086
echo accesstoken=\"$token\" >> "$tmp_dir"/Settings.toml

# shellcheck disable=SC2164
scriptPath="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

export BALLERINA_HOME_DIR="$scriptPath/$tmp_dir"
export BALLERINA_STAGE_CENTRAL="true"
