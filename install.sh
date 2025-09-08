#!/usr/bin/env bash

set -euox pipefail

if [ -d ~/.tmux/plugins/tpm ]; then
  echo 'tpm directory exists, skipping clone.'
else
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if [ ! -d ~/.fzf ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --no-update-rc --key-bindings --completion
fi

ZSH_AUTOSUGGESTION_DIR=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

if [ ! -d $ZSH_AUTOSUGGESTION_DIR ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_AUTOSUGGESTION_DIR
fi

if [ ! -d ~/.config/tmux/plugins/catppuccin/tmux ]; then
  mkdir -p ~/.config/tmux/plugins/catppuccin
  git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
fi

$(dirname "$0")/scripts/npm_globals.sh
