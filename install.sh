#!/bin/bash

mkdir -p "$HOME/.local/share/icons/hicolor/scalable/apps/"
mkdir -p "$HOME/.local/share/applications/"
mkdir -p "$HOME/bin/"

cp bin/dev-environments-mcus-onDocker.sh "$HOME/bin/"
cp bin/dev-environments-mcus-onDocker.svg "$HOME/.local/share/icons/hicolor/scalable/apps/"
cp bin/dev-environments-mcus-onDocker.desktop "$HOME/.local/share/applications/"

"$HOME/bin/dev-environments-mcus-onDocker.sh" echo "Visual Studio Code MCU Development Environment on Docker installed."

echo "Make sure that $HOME/bin is in your PATH at .bashrc or similar."
echo "Application icon may require to logout to show up properly."

