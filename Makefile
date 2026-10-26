DOTFILES := $(shell cd "$(dir $(abspath $(lastword $(MAKEFILE_LIST))))" && pwd)

.PHONY: install brew nvim tmux zsh nvm ghostty update clean

install:
	@bash $(DOTFILES)/install

brew:
	brew update && brew bundle --file $(DOTFILES)/homebrew/Brewfile

nvim:
	@mkdir -p $(HOME)/.config
	@rm -rf $(HOME)/.config/nvim
	ln -sw $(DOTFILES)/nvim $(HOME)/.config/nvim

tmux:
	ln -sf $(DOTFILES)/tmux/tmux.conf $(HOME)/.tmux.conf
	@if [ ! -d "$(HOME)/.tmux/plugins/tpm" ]; then \
		echo "Cloning TPM..."; \
		git clone https://github.com/tmux-plugins/tpm $(HOME)/.tmux/plugins/tpm; \
	else \
		echo "TPM already installed."; \
	fi

zsh:
	@rm -rf $(HOME)/.zshrc
	ln -sw $(DOTFILES)/zsh/.zshrc $(HOME)/.zshrc
	@rm -rf $(HOME)/.p10k.zsh
	ln -sw $(DOTFILES)/zsh/.p10k.zsh $(HOME)/.p10k.zsh

nvm:
	@mkdir -p $(HOME)/.nvm
	ln -sf $(DOTFILES)/nvm/default-packages $(HOME)/.nvm/default-packages

ghostty:
	@mkdir -p "$(HOME)/Library/Application Support/com.mitchellh.ghostty"
	ln -sf $(DOTFILES)/ghostty/config.ghostty "$(HOME)/Library/Application Support/com.mitchellh.ghostty/config.ghostty"

update:
	brew upgrade
	nvim --headless "+Lazy! sync" +qa
	$(HOME)/.tmux/plugins/tpm/bin/update_plugins all

clean:
	@echo "Removing symlinks..."
	@rm -f $(HOME)/.zshrc
	@rm -f $(HOME)/.zprofile
	@rm -f $(HOME)/.p10k.zsh
	@rm -f $(HOME)/.tmux.conf
	@rm -rf $(HOME)/.config/nvim
	@rm -f $(HOME)/.nvm/default-packages
	@rm -f $(HOME)/.gitconfig
	@rm -f $(HOME)/.gitignore_global
	@rm -f $(HOME)/.local/bin/nvim-health
	@rm -f $(HOME)/.local/bin/update
	@rm -f "$(HOME)/Library/Application Support/com.mitchellh.ghostty/config.ghostty"
	@echo "Done. Symlinks removed."
