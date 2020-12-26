SHELL := /bin/zsh
zinit := $(HOME)/.zinit

.PHONY: zsh zinit
zsh: plug_manager zshrc

plug_manager:
ifeq ($(wildcard $(zinit)),)
	@echo "[INFO]: install zinit..."
	@mkdir $(zinit)
	git clone https://github.com/zdharma/zinit.git $(zinit)/bin
else
	@echo "[INFO]: zinit has already installed."
endif

zshrc:
	@echo "[INFO]: update zshrc."
	cp ../zshrc ~/.zshrc
	source ~/.zshrc
	@echo "[INFO]: zsh init finished."
