#!/bin/bash

# GPG agent のセットアップ（macOS用）
# pinentry-mac を使ってパスフレーズ入力をGUIで行えるようにする

set -euo pipefail

if [ "$(uname)" != 'Darwin' ]; then
  echo "This script is only for macOS"
  exit 1
fi

if ! command -v pinentry-mac >/dev/null; then
  echo "❌ pinentry-mac is not installed. Run: brew install pinentry-mac"
  exit 1
fi

mkdir -p ~/.gnupg
echo "pinentry-program $(which pinentry-mac)" >> ~/.gnupg/gpg-agent.conf
gpgconf --kill gpg-agent

echo "✅ GPG agent configured with pinentry-mac"
