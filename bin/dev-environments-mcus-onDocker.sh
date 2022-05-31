#!/bin/bash

LOCAL_HOME="$HOME/.onDocker/dev-environments-mcus"
LOCAL_WORKSPACE="$HOME/mcu-projects"
mkdir -p "$LOCAL_HOME" 2> /dev/null
mkdir -p "$LOCAL_WORKSPACE" 2> /dev/null

OPTS=" "

# Uncomment following line for GUI support
# OPTS="${OPTS} --env=DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix"

# Uncomment following lines for USB support (replace XXX by USB device mayor number) 
# OPTS="${OPTS} --device /dev/kvm --group-add kvm"
# OPTS="${OPTS} -v /dev/bus/usb:/dev/bus/usb:ro --group-add plugdev --device-cgroup-rule 'c XXX:* rwm'"

docker run --rm -i \
	${OPTS} \
	-v "$LOCAL_HOME:/App_Home" \
	-v "$LOCAL_WORKSPACE:/App_Home/mcu-projects" \
	lordrafa/dev-environments-mcus $@

