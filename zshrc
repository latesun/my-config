#  1. zinit
source ~/.zinit/bin/zinit.zsh
## 1.1. Official Plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-history-substring-search
zinit light zdharma/fast-syntax-highlighting

## 1.2 Compinit
autoload -Uz compinit
compinit

## 1.3 Third Party Plugins
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit snippet OMZ::plugins/kubectl/kubectl.plugin.zsh
source <(kubectl completion zsh)

## 1.4 Theme
zinit ice depth=1; zinit light romkatv/powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


#  2. Key Binding
## 2.1 Use ctrl+space select suggestion
bindkey "^ " autosuggest-accept
## 2.2 Use ctrl+p/n select before/next substring
bindkey "^p" history-substring-search-up
bindkey "^n" history-substring-search-down

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
alias ls=exa
alias ll="exa -l"
alias tree="tree -C"
alias lg=lazygit
alias ranger="TERM=xterm ranger"
alias spy="when-changed -r -v -1 -s"
alias python=python3
## 4.2 kubectl get resource
alias kubectl="kubecolor"
alias k="kubecolor"
alias kn="kubectl get nodes -o wide"
alias kp="kubectl get pods -o wide"
alias kd="kubectl get deployment -o wide"
alias ks="kubectl get svc -o wide"
## 4.3 kubectl describe resources
alias kdp="kubectl describe pod"
alias kdd="kubectl describe deployment"
alias kds="kubectl describe service"
alias kdn="kubectl describe node"

## 4.4 Customize
alias gd="sshpass -p password ssh -o StrictHostKeyChecking=no user@gmail.com"
alias mgo-dev="mongo admin -u user -p password --host 127.0.0.1:27017"
alias rds-dev="redis-cli -h 127.0.0.1 -p 6379 -a password"

#  5. Third Party Plugins
## 5.1 Fasd
eval "$(fasd --init auto)"
fasd_cache="$HOME/.fasd-init-zsh"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache
alias j="fasd_cd -d"
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
