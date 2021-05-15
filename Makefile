SHELL := /bin/zsh
.PHONY: zsh plug_manager zshrc \
	vim vim_plug vimrc \
	tmux

zinit := $(HOME)/.zinit
zsh: plug_manager zshrc

plug_manager:
ifeq ("$(wildcard $(zinit))","")
	@echo "[INFO]: install zinit..."
	@mkdir $(zinit)
	git clone --depth=1 https://github.com/zdharma/zinit.git $(zinit)/bin
else
	@echo "[INFO]: zinit has already installed."
endif

zshrc:
	@echo "[INFO]: make zsh as default shell."
	chsh -s $$(which zsh)
	compaudit | xargs chown -R $$(whoami)
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
	@echo "[INFO]: install tools for macOS."
	brew install --HEAD neovim tmux exa bash-completion go nodejs

fasd:
	mkdir tmp && cd tmp
	cd tmp && git clone --depth=1 https://github.com/clvv/fasd.git && cd fasd && make install
	rm -rf tmp

tmux:
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	cp tmux.conf ~/.tmux.conf
