#!/bin/bash

kill_service() {
  case "$(uname -s)" in
  Darwin)
    kill $(lsof -ti:$1)
    ;;

  Linux)
    fuser -k $1/tcp
    ;;
  *) ;;
  esac
}

# Change directory to provided path
cd ${1}

# run ballerina file as background process
my_array=($(${2} run --experimental ${3} ${6})) &

sleep 10

# invoke curl commnads
. ${4}

# kill the process which is using the server ports
while read -r line; do
  if lsof -Pi :$line -sTCP:LISTEN -t >/dev/null; then
    kill_service $line
  else
    echo "Service is not running"
  fi
done <${5}
