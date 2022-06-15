#!/bin/bash

rm -rf "$HOME/bin/dev-environments-mcus-onDocker.sh"
rm -rf "$HOME/.local/share/icons/hicolor/scalable/apps/dev-environments-mcus-onDocker.svg"
rm -rf "$HOME/.local/share/applications/dev-environments-mcus-onDocker.desktop"
rm -rf "$HOME/.onDocker/dev-environments-mcus"
sudo rm -rf "/etc/udev/rules.d/99-platformio-udev.rules"
sudo rm -rf "/etc/udev/rules.d/99-dev-environments-mcus-tty.rules"
sudo rm -rf "/usr/local/bin/dev-environments-mcus-tty.sh"

docker image rm lordrafa/dev-environments-mcus
