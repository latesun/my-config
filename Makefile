SHELL := /bin/bash
.PHONY: zsh plug_manager zshrc \
	vim vim_plug vimrc \
	tmux \
	ubuntu

zinit := $(HOME)/.zinit
zsh: plug_manager zshrc

plug_manager:
ifeq ("$(wildcard $(zinit))","")
	@echo "[INFO]: install zinit..."
	@mkdir $(zinit)
	git clone --depth=1 https://github.com.cnpmjs.org/zdharma/zinit.git $(zinit)/bin
else
	@echo "[INFO]: zinit has already installed."
endif

zshrc:
	@echo "[INFO]: make zsh as default shell."
	chsh -s $$(which zsh)
	#compaudit | xargs chown -R $$(whoami) # TODO: check if keep it
	@echo "[INFO]: update zshrc."
	cp zshrc ~/.zshrc
	source ~/.zshrc
	@echo "[INFO]: zsh init finished."

nvim := $(HOME)/.config/nvim
vim:
ifeq ($(wildcard $(nvim)),)
	mkdir -p $(nvim)
endif
ifneq ("$(wildcard $(nvim)/init.vim"),"")
	@echo "[INFO]: load vimrc..."
	cp vim/{init.vim,coc-settings.json} $(nvim)
	@echo "[INFO]: load vimrc sucessfully."
else
	@echo "[INFO]: vimrc has already existed."
endif

mac_tools:
	@echo "[INFO]: install tools for macOS..."
	brew install --HEAD neovim tmux exa bash-completion go nodejs

ubuntu: u_tools u_go u_neovim u_node u_lazygit

u_tools:
	@echo "[INFO]: install tools for ubuntu"
	sudo apt install -y curl exa tmux neofetch openssh-server fzf ripgrep

u_go:
	@echo "[INFO]: add golang repository..."
	sudo add-apt-repository ppa:longsleep/golang-backports
	sudo apt update && sudo apt install -y golang-go

u_neovim:
	@echo "[INFO]: add neovim repository..."
	sudo add-apt-repository ppa:neovim-ppa/unstable
	sudo apt update && sudo apt install -y neovim python3-neovim

u_node:
	sudo apt install -y nodejs npm
	sudo npm config set registry https://registry.npm.taobao.org

u_lazygit:
	sudo add-apt-repository ppa:lazygit-team/release
	sudo apt-get update
	sudo apt-get install lazygit

fasd:
	mkdir tmp 
	cd tmp && git clone --depth=1 https://github.com.cnpmjs.org/clvv/fasd.git && cd fasd && sudo make install
	rm -rf tmp

tmux:
	git clone https://github.com.cnpmjs.org/tmux-plugins/tpm ~/.tmux/plugins/tpm
	cp tmux.conf ~/.tmux.conf

KVERSION=0.15.3
kubecm:
	wget https://github.com/sunny0826/kubecm/releases/download/v${KVERSION}/kubecm_${KVERSION}_Linux_x86_64.tar.gz -O kubecm.tar.gz
	mv kubecm.tar.gz /tmp
	cd /tmp && tar -zxvf kubecm.tar.gz kubecm
	sudo mv /tmp/kubecm /usr/local/bin/
