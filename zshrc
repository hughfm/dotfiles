# target: ~/.zshrc

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="agnoster"
HIST_STAMPS="dd.mm.yyyy"

plugins=(brew git common-aliases docker autojump zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
[ -f ~/.aliases ] && source ~/.aliases
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f ~/.zshrc_private ] && source ~/.zshrc_private

autoload -Uz compinit
compinit

eval "$(starship init zsh)"
