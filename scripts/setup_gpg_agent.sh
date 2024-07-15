#!/bin/bash

set -euo pipefail

if [ "$(uname)" != 'Darwin' ]; then
  echo "This script is only for macOS"
  exit 1
fi

if ! command -v brew >/dev/null; then
  echo "brew is not installed"
  exit 1
fi

brew "pinentry-mac"
echo "pinentry-program $(which pinentry-mac)" >> ~/.gnupg/gpg-agent.conf
killall gpg-agent
