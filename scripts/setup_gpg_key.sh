#!/bin/bash

# GPG 鍵を生成するスクリプト
# 生成後、GitHub に公開鍵を登録し、chezmoi の設定を更新する

set -euo pipefail

echo "🔐 GPG Key Generator"
echo ""

read -p "Name (for GPG key): " NAME
read -p "Email (for GPG key): " EMAIL

echo ""
echo "Generating GPG key for: $NAME <$EMAIL>"
echo ""

# GPG 鍵を対話的に生成
gpg --full-generate-key

# 生成した鍵の ID を取得
KEY_ID=$(gpg --list-secret-keys --keyid-format=long "$EMAIL" 2>/dev/null | grep sec | head -1 | awk '{print $2}' | cut -d'/' -f2)

if [ -z "$KEY_ID" ]; then
  echo "❌ Failed to get key ID"
  exit 1
fi

echo ""
echo "✅ GPG key generated!"
echo ""
echo "Key ID: $KEY_ID"
echo ""
echo "📋 Public key (add this to GitHub -> Settings -> SSH and GPG keys):"
echo "=========================================="
gpg --armor --export "$KEY_ID"
echo "=========================================="
echo ""
echo "📝 Next steps:"
echo "1. Copy the public key above and add it to GitHub"
echo "2. Update your chezmoi config:"
echo "   chezmoi edit-config"
echo "   Set: signingkey = \"$KEY_ID\""
echo "3. Or re-run: chezmoi init --force hulk510"
