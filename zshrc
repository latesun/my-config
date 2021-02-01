#  1. zinit
source ~/.zinit/bin/zinit.zsh
## 1.1. Official Plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-history-substring-search
zinit light zdharma/fast-syntax-highlighting

## 1.2 Third Party Plugins
zinit snippet 'https://github.com/robbyrussell/oh-my-zsh/raw/master/plugins/git/git.plugin.zsh'
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit snippet OMZ::plugins/kubectl/kubectl.plugin.zsh

## 1.3 Theme
zinit ice depth=1; zinit light romkatv/powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#  2. Key Binding
## 2.1 Use ctrl+space select suggestion
bindkey '^ ' autosuggest-accept
## 2.2 Use ctrl+p/n select before/next substring
bindkey '^p' history-substring-search-up
bindkey '^n' history-substring-search-down

#  3. Environment Args
## 1.1 Select default editor
export EDITOR=nvim
## 3.2 Go
export GOPATH=$HOME/workspace/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN
#  4. Short Command
## 4.1 Common
alias vi=nvim
alias vim=nvim
alias lg=lazygit
alias ranger='TERM=xterm ranger'
alias spy="when-changed -r -v -1 -s"
alias k=kubectl
alias python=python3
alias redis-cli="docker exec -it redis redis-cli"
## 4.2 Customize
alias vpn="sudo openvpn --daemon --cd /etc/openvpn --config client.ovpn --log-append /var/log/openvpn.log"

#  5. Third Party Plugins
## 5.1 Fasd
eval "$(fasd --init auto)"
fasd_cache="$HOME/.fasd-init-zsh"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache
alias j='fasd_cd -d'
## 5.2 Fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#  6. Customize Functions
## 6.1 Open proxy
proxy() {
	export http_proxy="http://127.0.0.1:1087"
	export https_proxy="http://127.0.0.1:1087"
	export no_proxy="127.0.0.1,localhost,local_ipv4"
	echo "[INFO]: http proxy on."
}
## 6.2 Close proxy
unproxy() {
	unset http_proxy
	unset https_proxy
	unset no_proxy
	echo "[INFO]: http proxy off"
}
[[ ! -f ~/.kubecm ]] || source ~/.kubecm
