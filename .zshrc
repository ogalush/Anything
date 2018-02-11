## 補完機能の強化 http://www.ayu.ics.keio.ac.jp/~mukai/translate/write_zsh_functions.html
autoload -U compinit
compinit

## prompt
PROMPT='[%F{white}%n@%f%F{blue}%U%m%u%f:%F{green}%d%f]$ '

## ディレクトリ名を入力すると、そのディレクトリへ移動する
setopt auto_pushd

## for history
HISTFILE=~/.zsh_histfile
HISTSIZE=10000
SAVEHIST=10000



