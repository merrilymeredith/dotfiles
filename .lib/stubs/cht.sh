#!/bin/sh
set -eu

install_it() {
  curl -fL https://cheat.sh/:cht.sh > ~/.local/bin/cht.sh
  chmod +x ~/.local/bin/cht.sh

  mkdir -p ~/.lib/zsh
  curl -fsSL https://cheat.sh/:zsh > ~/.lib/zsh/_cht
  zsh -i -c compinit
}

. ~/.lib/sh/stubexec.sh
