[ -d /usr/local/opt/zplug ] && export ZPLUG_HOME=/usr/local/opt/zplug
[ -d /opt/homebrew/opt/zplug ] && export ZPLUG_HOME=/opt/homebrew/opt/zplug

source $ZPLUG_HOME/init.zsh
###### Zplug settings start ###############
# 書き方
# 「ユーザ名/リポジトリ名」で記述し、ダブルクォートで見やすく括る（括らなくてもいい）

# 間違えたコマンドは赤色に、正しいコマンドは緑にハイライト
zplug "zsh-users/zsh-syntax-highlighting"

# historyサーチをやりやすくする。使ってるか分からん。
zplug "zsh-users/zsh-history-substring-search"

# tabで補完できる
zplug "zsh-users/zsh-completions"

# コマンド途中にサジェストを出す。
zplug "zsh-users/zsh-autosuggestions"

# zsh が非同期になる
zplug "mafredri/zsh-async", from:github
# theme
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
zstyle :prompt:pure:path color blue

zplug load

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
