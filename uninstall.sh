#!/bin/bash

rm -rf "$HOME/bin/dev-environments-mcus-onDocker.sh"
rm -rf "$HOME/.local/share/icons/hicolor/scalable/apps/dev-environments-mcus-onDocker.svg"
rm -rf "$HOME/.local/share/applications/dev-environments-mcus-onDocker.desktop"
rm -rf "$HOME/.onDocker/dev-environments-mcus"
sudo rm -f "/etc/udev/rules.d/99-dev-environments-mcus.rules"
sudo rm -f "/usr/local/bin/dev-environments-mcus-udev.sh"
docker image rm lordrafa/dev-environments-mcus
