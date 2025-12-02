# github.com/hulk510/dotfiles

managed with [chezmoi](https://chezmoi.io/).

## Requirements

- macOS or Linux
- zsh shell
- **Homebrew** (must be installed beforehand)
- `curl` or `wget`

> [!NOTE]
> There is no guarantee that it will work perfectly, please execute at your own risk.

### Install Homebrew first

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Quick Start

```bash
curl -fsSL https://raw.githubusercontent.com/hulk510/dotfiles/main/install.sh | sh
```

初回実行時に以下を聞かれます：

- **Minimal setup?**: `true` で最小限の dotfile のみ適用（git, zsh, starship）
- **Profile**: `personal` または `work` を選択

## Brewfile

Homebrew パッケージは **自動インストールされません**。必要なものだけ手動でインストール:

```bash
# 最小限（git, neovim, starship, zplug, fzf など）
brew bundle --file=~/.config/brewfile/Brewfile.core

# 開発用（asdf, go, rust, tmux など）
brew bundle --file=~/.config/brewfile/Brewfile.dev

# 仕事用（kubectl, helm, azure-cli など）
brew bundle --file=~/.config/brewfile/Brewfile.work

# macOS GUI アプリ（VSCode, Docker, Slack など）
brew bundle --file=~/.config/brewfile/Brewfile.macos
```

### パッケージの追加方法

```bash
# 普通にインストール
brew install something

# 対応する Brewfile に追記
echo 'brew "something"' >> ~/.config/brewfile/Brewfile.dev
```

## Manual Setup

```bash
chezmoi init hulk510
chezmoi diff    # 適用される変更を確認
chezmoi apply   # 適用
```

### 設定のリセット

```bash
chezmoi init --force hulk510  # 設定を再選択
```

## Scripts

手動で実行するスクリプト:

```bash
# macOS の defaults 設定（Dock, Finder, キーボードなど）
~/.local/share/chezmoi/scripts/setup_mac_defaults.sh

# GPG agent のセットアップ
~/.local/share/chezmoi/scripts/setup_gpg_agent.sh
```
