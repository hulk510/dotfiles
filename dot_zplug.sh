[ -d /usr/local/opt/zplug ] && export ZPLUG_HOME=/usr/local/opt/zplug

if command -v brew >/dev/null 2>&1; then
    if [ -d "$(brew --prefix zplug)" ]; then
        export ZPLUG_HOME=$(brew --prefix zplug)
    fi
fi

if [ -z "${ZPLUG_HOME:-}" ]; then
    echo "zplug is not installed" >&2
    exit 1
fi

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

zplug load

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo
        zplug install
    fi
fi
