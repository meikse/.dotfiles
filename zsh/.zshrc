export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="avit"
plugins=(git vi-mode)
export EDITOR="nvim"
source $ZSH/oh-my-zsh.sh
export LANG=en_US.UTF-8

VI_MODE_SET_CURSOR=true
bindkey -v

[ -f ~/.fzf.zsh ]&& source ~/.fzf.zsh
