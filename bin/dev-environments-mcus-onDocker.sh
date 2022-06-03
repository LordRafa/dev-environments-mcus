#!/bin/bash

LOCAL_HOME="$HOME/.onDocker/dev-environments-mcus"
LOCAL_WORKSPACE="$HOME/mcu-projects"
mkdir -p "$LOCAL_HOME" 2> /dev/null
mkdir -p "$LOCAL_WORKSPACE" 2> /dev/null
CONTAINER_NAME="dev-environments-mcus"

OPTS=" "

if [ $# -eq 0 ]; then

  docker run --rm -d --name="$CONTAINER_NAME" \
  -v /dev/bus/usb:/dev/bus/usb:ro --group-add plugdev --device-cgroup-rule 'c 189:* rwm' \
  -v "$LOCAL_HOME:/App_Home" -v "$LOCAL_WORKSPACE:/App_Home/mcu-projects" \
  lordrafa/dev-environments-mcus tail -f /dev/null

  hex=$(printf \{\"containerName\"\:\""$CONTAINER_NAME"\"\} | od -A n -t x1 | tr -d '[\n\t ]')
  code --folder-uri vscode-remote://attached-container+${hex}/App_Home/mcu-projects

else

  docker run --rm -i ${OPTS} -v "$LOCAL_HOME:/App_Home" -v "$LOCAL_WORKSPACE:/App_Home/mcu-projects" lordrafa/dev-environments-mcus "$@"

fi

