#!/bin/bash

set -euo pipefail

if [ "$(uname)" != 'Darwin' ]; then
  echo "This script is only for macOS"
  exit 1
fi

if ! command -v brew >/dev/null; then
  echo "Homebrew is not installed"
  exit 1
fi

brew install pinentry-mac
mkdir -p ~/.gnupg
echo "pinentry-program $(which pinentry-mac)" >> ~/.gnupg/gpg-agent.conf
gpgconf --kill gpg-agent
echo "GPG agent configured with pinentry-mac"
