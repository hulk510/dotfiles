#!/bin/bash

set -euo pipefail

brew update
brew bundle --global

# darwinの場合のみ実行でcaskのリストを表示
if [ "$(uname)" == 'Darwin' ]; then
  brew list --cask
fi

brew cleanup
