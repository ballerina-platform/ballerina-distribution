#!/bin/bash

# Change directory to provided path
cd ${1}

# run ballerina file as background process
my_array=($(${2} run --experimental ${3} ${6})) &

sleep 10

# invoke curl commnads
. ${4}

# kill the process which is using the server ports
while read line; do
if lsof -Pi :$line -sTCP:LISTEN -t >/dev/null ; then
fuser -k $line/tcp
else
echo "not open"
fi
done < ${5}
