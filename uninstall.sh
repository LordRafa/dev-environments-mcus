#!/bin/bash

rm -rf "$HOME/bin/dev-environments-mcus-onDocker.sh"
rm -rf "$HOME/.local/share/icons/hicolor/scalable/apps/dev-environments-mcus-onDocker.svg"
rm -rf "$HOME/.local/share/applications/dev-environments-mcus-onDocker.desktop"
rm -rf "$HOME/.onDocker/dev-environments-mcus"

docker image rm lordrafa/dev-environments-mcus

