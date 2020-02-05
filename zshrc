export ZSH="/home/lee/.oh-my-zsh"

ZSH_THEME="ys"

alias vi=nvim
alias vim=nvim
alias lg=lazygit
alias rg=ranger
alias cat=bat

export EDITOR='nvim'

export GOPATH=/home/lee/workspace/go
export GOBIN=$GOPATH/bin
export PATH=$GOBIN:$PATH

[[ -s /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
