#!/bin/sh

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
# For example, we just use `~/.cache/dein` as installation directory
sh ./installer.sh ~/.cache/dein

# インストールするとinstaller.shができるのでそれは削除してもいい
# 終わったらvim開いて↓を呼べばインストール完了
# :call dein#install()
