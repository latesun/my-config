oh_my_zsh := $(HOME)/.oh-my-zsh
p10k_theme := $(HOME)/.oh-my-zsh/custom/themes/powerlevel10k
zsh_suggestion_plugin := $(HOME)/.oh-my-zsh/custom/plugins/zsh-autosuggestions
zsh_completion_plugin := $(HOME)/.oh-my-zsh/custom/plugins/zsh-completions

.PHONY: zsh
zsh: plug_manager plug_theme plug_autosuggestions plug_completions

plug_manager:
ifeq ($(wildcard $(oh_my_zsh)),)
	@echo "Install oh-my-zsh ..."
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
	@echo "ohmyzsh has already installed"
endif

plug_theme:
ifeq ($(wildcard $(p10k_theme)),)
	@echo "Install p10k theme ..."
	git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git $(p10k_theme)
else
	@echo "p10k theme has already installed"
endif

plug_autosuggestions:
ifeq ($(wildcard $(zsh_suggestion_plugin)),)
	@echo "Install autosuggestions plugin ..."
	git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions $(zsh_suggestion_plugin)
else
	@echo "autosuggestion plugin has already installed"
endif

plug_completions:
ifeq ($(wildcard $(zsh_completion_plugin)),)
	@echo "Install completions plugin ..."
	git clone --depth=1 https://github.com/zsh-users/zsh-completions $(zsh_completion_plugin)
else
	@echo "completions plugin has already installed"
endif

zshrc:
	cp ../zshrc ~/.zshrc
