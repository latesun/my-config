SHELL := /bin/zsh
.PHONY: zsh plug_manager \
	vim vim_plug vimrc

zinit := $(HOME)/.zinit
zsh: plug_manager zshrc

plug_manager:
ifeq ($(wildcard $(zinit)),)
	@echo "[INFO]: install zinit..."
	@mkdir $(zinit)
	git clone --depth=1 https://github.com/zdharma/zinit.git $(zinit)/bin
else
	@echo "[INFO]: zinit has already installed."
endif

zshrc:
	@echo "[INFO]: update zshrc."
	cp zshrc ~/.zshrc
	source ~/.zshrc
	@echo "[INFO]: zsh init finished."

nvim := $(HOME)/.config/nvim
vim:
ifeq ($(wildcard $(nvim)),)
	mkdir -p $(nvim)
endif
ifneq ($(wildcard $(nvim)/init.vim),)
	@echo "[INFO]: load vimrc..."
	cp vim/{init.vim,coc-settings.json} $(nvim)
	@echo "[INFO]: load vimrc sucessfully."
else
	@echo "[INFO]: vimrc has already existed."
endif
