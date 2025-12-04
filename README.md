# hulk510/dotfiles

[chezmoi](https://chezmoi.io/) で管理している dotfiles です。

## 📋 Requirements

- macOS or Linux
- zsh
- [Homebrew](https://brew.sh/)
- `curl` or `wget`

> [!NOTE]
> 完璧に動作する保証はありません。自己責任で実行してください。

## 🚀 Quick Start

### 1. Homebrew をインストール

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. dotfiles をセットアップ

```bash
curl -fsSL https://raw.githubusercontent.com/hulk510/dotfiles/main/install.sh | sh
```

初回実行時に以下を聞かれます：

| 質問 | 説明 |
|------|------|
| **Minimal setup?** | `true` で最小限の dotfile のみ適用 |
| **Profile** | `personal` または `work` を選択 |
| **Git email** | (work の場合) Git で使うメールアドレス |
| **Git name** | (work の場合) Git で使う名前 |
| **GPG signing key** | (work の場合) GPG 署名キー（空欄可） |

### 3. Homebrew パッケージをインストール

```bash
bb-all  # core + dev + macos を一括インストール

# または個別に
bb        # Brewfile.core（必須パッケージ）
bb-dev    # Brewfile.dev（開発用）
bb-macos  # Brewfile.macos（macOS GUI アプリ）
```

## 📦 Brewfile 構成

| ファイル | 内容 |
|----------|------|
| `Brewfile.core` | 必須パッケージ（git, neovim, starship, fzf など） |
| `Brewfile.dev` | 開発用（mise, go, rust, kubectl, helm など） |
| `Brewfile.macos` | macOS GUI アプリ（VSCode, Docker, Slack など） |

### パッケージの追加

```bash
# インストール
brew install something

# Brewfile に追記（永続化したい場合）
echo 'brew "something"' >> ~/.config/brewfile/Brewfile.dev
```

## 🔧 Manual Setup

```bash
# 初期化のみ（適用前に確認したい場合）
chezmoi init hulk510

# 差分を確認
chezmoi diff

# 適用
chezmoi apply
```

## 📜 Scripts

手動で実行するスクリプト：

```bash
# macOS の defaults 設定（Dock, Finder, キーボードなど）
~/.local/share/chezmoi/scripts/setup_mac_defaults.sh

# GPG agent のセットアップ（pinentry-mac）
~/.local/share/chezmoi/scripts/setup_gpg_agent.sh

# GPG 鍵の生成
~/.local/share/chezmoi/scripts/setup_gpg_key.sh
```

## 🔄 よく使うコマンド

```bash
# 設定を変更（profile, email, signingkey など）
chezmoi edit-config

# 設定を再選択して適用
chezmoi init --force hulk510

# dotfile のソースを編集
chezmoi edit ~/.zshrc

# 変更を適用
chezmoi apply

# chezmoi の状態を確認
chezmoi status
```

## 🛠 Troubleshooting

### chezmoi apply でエラーが出る

```bash
# 差分を確認
chezmoi diff

# 特定のファイルだけ適用
chezmoi apply ~/.zshrc
```

### テンプレートの変数を確認したい

```bash
# 現在の設定値を表示
chezmoi data

# 設定ファイルを編集
chezmoi edit-config
```

### 適用前に戻したい

```bash
# 適用前にバックアップ
cp ~/.gitconfig ~/.gitconfig.backup

# 適用後に戻す
cp ~/.gitconfig.backup ~/.gitconfig
```

### GPG 署名がうまくいかない

```bash
# GPG 鍵の確認
gpg --list-secret-keys --keyid-format=long

# GPG agent の再起動
gpgconf --kill gpg-agent

# pinentry-mac のセットアップ（macOS）
~/.local/share/chezmoi/scripts/setup_gpg_agent.sh
```

### Homebrew のパスが通らない（Linux）

```bash
# .zprofile に追記されているか確認
cat ~/.zprofile

# 手動で追加
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.zprofile
source ~/.zprofile
```

### mise (asdf の代替) のセットアップ

```bash
# インストール
brew install mise

# シェルに追加（.zshrc に既に設定済み）
eval "$(mise activate zsh)"

# ツールをインストール
mise install
```

## 📁 ディレクトリ構成

```text
~/.local/share/chezmoi/
├── dot_zshrc                 # ~/.zshrc
├── dot_gitconfig.tmpl        # ~/.gitconfig（テンプレート）
├── dot_mise.toml             # ~/.mise.toml
├── dot_config/
│   ├── brewfile/             # Homebrew パッケージ
│   ├── nvim/                 # Neovim 設定
│   ├── starship.toml         # Starship プロンプト
│   └── wezterm/              # WezTerm 設定
├── scripts/                  # 手動実行スクリプト
└── .chezmoi.toml.tmpl        # chezmoi 設定テンプレート
```

## 📄 License

MIT
