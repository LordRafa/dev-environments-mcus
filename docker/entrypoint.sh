#!/bin/bash

# This code was adapted from Khalifah Shabazz's download-vs-code-server.sh
# gist available at https://gist.github.com/b01/0a16b6645ab7921b0910603dfb85e4fb

if [ ! -d "$HOME/.vscode-server/bin" ]; then

  archive="vscode-server-linux-x64.tar.gz"
  owner='microsoft'
  repo='vscode'

  # Auto-Get the latest commit sha via command line.
  get_latest_release() {
    tag=$(curl --silent "https://api.github.com/repos/${1}/releases/latest" | # Get latest release from GitHub API
          grep '"tag_name":'                                                | # Get tag line
          sed -E 's/.*"([^"]+)".*/\1/'                                      ) # Pluck JSON value

    tag_data=$(curl --silent "https://api.github.com/repos/${1}/git/ref/tags/${tag}")

    sha=$(echo "${tag_data}"           | # Get latest release from GitHub API
          grep '"sha":'                | # Get tag line
          sed -E 's/.*"([^"]+)".*/\1/' ) # Pluck JSON value

    sha_type=$(echo "${tag_data}"           | # Get latest release from GitHub API
               grep '"type":'               | # Get tag line
               sed -E 's/.*"([^"]+)".*/\1/' ) # Pluck JSON value

    if [[ "${sha_type}" != "commit" ]]; then
      combo_sha=$(curl -s "https://api.github.com/repos/${1}/git/tags/${sha}" | # Get latest release from GitHub API
                  grep '"sha":'                                               | # Get tag line
                  sed -E 's/.*"([^"]+)".*/\1/'                                ) # Pluck JSON value

      # Remove the tag sha, leaving only the commit sha;
      # this won't work if there are ever more than 2 sha,
      # and use xargs to remove whitespace/newline.
      sha=$(echo "${combo_sha}" | sed -E "s/${sha}//" | xargs)
    fi

    printf "${sha}"
  }

  commit_sha=$(get_latest_release "${owner}/${repo}")
  echo "will attempt to download VS Code Server version = '${commit_sha}'"
  # Download VS Code Server tarball to tmp directory.
  curl -L "https://update.code.visualstudio.com/commit:${commit_sha}/server-linux-x64/stable" -o "/tmp/${archive}"
  # Make the parent directory where the server should live.
  # NOTE: Ensure VS Code will have read/write access; namely the user running VScode or container user.
  mkdir -vp ~/.vscode-server/bin/"${commit_sha}"
  # Extract the tarball to the right location.
  tar --no-same-owner -xzv --strip-components=1 -C "$HOME/.vscode-server/bin/${commit_sha}" -f "/tmp/${archive}"
  "$HOME/.vscode-server/bin/${commit_sha}/bin/code-server" --install-extension cschlosser.doxdocgen
  "$HOME/.vscode-server/bin/${commit_sha}/bin/code-server" --install-extension jeff-hykin.better-cpp-syntax
  "$HOME/.vscode-server/bin/${commit_sha}/bin/code-server" --install-extension MS-CEINTL.vscode-language-pack-es
  "$HOME/.vscode-server/bin/${commit_sha}/bin/code-server" --install-extension ms-vscode.cmake-tools
  "$HOME/.vscode-server/bin/${commit_sha}/bin/code-server" --install-extension ms-vscode.cpptools
  "$HOME/.vscode-server/bin/${commit_sha}/bin/code-server" --install-extension ms-vscode.cpptools-extension-pack
  "$HOME/.vscode-server/bin/${commit_sha}/bin/code-server" --install-extension ms-vscode.cpptools-themes
  "$HOME/.vscode-server/bin/${commit_sha}/bin/code-server" --install-extension platformio.platformio-ide
  "$HOME/.vscode-server/bin/${commit_sha}/bin/code-server" --install-extension twxs.cmake
  "$HOME/.vscode-server/bin/${commit_sha}/bin/code-server" --install-extension vsciot-vscode.vscode-arduino

  python3 -c "$(curl -fsSL https://raw.githubusercontent.com/platformio/platformio/master/scripts/get-platformio.py)"

  cat <<EOF > .vscode-server/data/Machine/settings.json
{
  "arduino.useArduinoCli": true,
  "arduino.path": "/usr/local/bin/",
  "arduino.commandPath": "arduino-cli"
}
EOF

fi

if [ ! -f "$HOME/.bashrc" ]; then

 cat <<EOF > "$HOME/.bashrc"
HISTSIZE=
HISTFILESIZE=

PS1='\[\033[01;32m\]\u\[\033[01;33m\]@\[\033[01;36m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ..="cd .."
EOF

fi

if [ ! -d "$HOME/JLINK" ]; then
  mkdir $HOME/JLINK
fi

exec "$@"
