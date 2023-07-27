#!/bin/bash

CURRENT=$(cd $(dirname $0);pwd)
echo current directory is ${CURRENT}

# フォルダの作成
mkdir -p ~/.config/git
mkdir -p ~/.config/gh

#-------------------------------------------------------
# 最終的にこんな感じでまとめれたらいいかな。
# https://zenn.dev/k4zu/articles/zsh-tutorial
# 配置したい設定ファイル
#-------------------------------------------------------
# dotfileを設定
dotfiles=(
.zshrc
.zprofile
.tmux.conf
.gitconfig
.gitconfig_enterprise
.vimrc
.Brewfile
.config/git/ignore
.config/gh/config.yml
.config/gh/hosts.yml.work # github-cliの設定ファイル
.config/gh/hosts.yml.personal # github-cliの設定ファイル
)

# .zshrc と .tmux.conf という設定ファイルのシンボリックリンクを
# ホームディレクトリ直下に作成する
for file in "${dotfiles[@]}"; do
        ln -svf "${CURRENT}/dotfiles/${file}" ~/${file}
done

# ghのpersonal acceess tokenを変更すると差分が出るため以下コマンドで差分を消せる
# https://qiita.com/usamik26/items/56d0d3ba7a1300625f92
# 差分を無視する
#  git update-index --assume-unchanged ./dotfiles/.config/gh/hosts.yml.personal
#  git update-index --assume-unchanged ./dotfiles/.config/gh/hosts.yml.work
# 解除
#  git update-index --no-assume-unchanged ./dotfiles/.config/gh/hosts.yml.personal
#  git update-index --no-assume-unchanged ./dotfiles/.config/gh/hosts.yml.work
