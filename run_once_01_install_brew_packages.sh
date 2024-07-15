#!/bin/bash

set -euo pipefail

# github actions環境の場合にのみ以下を実行
if [ -n "${GITHUB_ACTIONS:-}" ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  brew install "jq"
  exit 0
fi

brew update
brew bundle --global

# darwinの場合のみ実行でcaskのリストを表示
if [ "$(uname)" == 'Darwin' ]; then
  brew list --cask
fi

brew cleanup
