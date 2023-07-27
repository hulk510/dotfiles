## dotfiles

chezmoi を使ってる。
PAT に関しては chezmoi のテンプレートで展開しているため別途 dashlane-cli のインストールも必要

### 手順

1. chezmoi のインストール Brew とかで入れる
2. brewfile で dashlane-cli 含めパッケージ入れる
3. dashlane-cli にログイン
4. chezmoi apply -v

### 備考

chezmoi は直接ファイルを変更して apply できる。
ただ git clone しただけの場合は chezmoi の管理下にならないので apply しても効かない。

変数展開は template にしないとダメ。すでにあるファイルとかをテンプレートにすることもできる（フォルダは知らん）
chezmoi chattr +template ~/.config/gh/hosts.yml.personal
こんな感じで指定すると hosts.yml.personal.tmpl ができる
