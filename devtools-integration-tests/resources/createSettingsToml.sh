#!/bin/sh
mkdir bal-integration-packaging-home

# shellcheck disable=SC2006
token=`echo 'YWYwMjkyODgtNjhkZC0zOTVmLTk5MzQtYTgyYWRjM2NlYzZi' | base64 --decode`

cat > bal-integration-packaging-home/Settings.toml <<- "EOF"
[central]
EOF

# shellcheck disable=SC2086
echo accesstoken=\"$token\" >> bal-integration-packaging-home/Settings.toml
