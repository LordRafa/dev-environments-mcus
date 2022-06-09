#!/bin/bash

LOCAL_HOME="$HOME/.onDocker/dev-environments-mcus"

mkdir -p "$HOME/.local/share/icons/hicolor/scalable/apps/"
mkdir -p "$HOME/.local/share/applications/"
mkdir -p "$HOME/bin/"

cp bin/dev-environments-mcus-onDocker.sh "$HOME/bin/"
curl -L "https://upload.wikimedia.org/wikipedia/commons/0/07/IC_SMD16SQ_filled.svg" -o "$HOME/.local/share/icons/hicolor/scalable/apps/dev-environments-mcus-onDocker.svg"
cp bin/dev-environments-mcus-onDocker.desktop "$HOME/.local/share/applications/"
echo "Root access must be granted in order to install udev rules and scripts to allow usb tty access"
sudo cp bin/99-platformio-udev.rules /etc/udev/rules.d/
sudo cp bin/99-dev-environments-mcus-tty.rules /etc/udev/rules.d/
sudo cp bin/dev-environments-mcus-tty.sh /usr/local/bin/

"$HOME/bin/dev-environments-mcus-onDocker.sh" echo "MCU Development Environment on Docker installed."

echo "Make sure that $HOME/bin is in your PATH at .bashrc or similar."
echo "Application icon may require to logout to show up properly."
echo "In order to add Segger's J-Link support you will need to manually copy J-Link binaries to $LOCAL_HOME/JLINK folder"
echo "Remember that you must have VSCode already installed and it must be on the PATH"

