# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Path to your oh-my-zsh installation.
export ZSH="/home/lee/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting docker docker-compose)
bindkey '^ ' autosuggest-accept

export EDITOR=nvim

alias vi=nvim
alias lg=lazygit
alias rg=ranger

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# open proxy
proxy() {
	export http_proxy="http://127.0.0.1:1087"
	export https_proxy="http://127.0.0.1:1087"
	export no_proxy="127.0.0.1,localhost,192.168.124.21"
	echo "HTTP Proxy on"
}

# close proxy
unproxy() {
	unset http_proxy
	unset https_proxy
	unset no_proxy
	echo "HTTP Proxy off"
}

# fasd
eval "$(fasd --init auto)"
fasd_cache="$HOME/.fasd-init-zsh"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache
alias j='fasd_cd -d'
