DOTFILES := $(PWD)

.PHONY: install
install:
	ln -sf $(DOTFILES)/vimrc ~/.vimrc
	mkdir -p ~/.config/nvim
	ln -sf $(DOTFILES)/init.lua ~/.config/nvim/init.lua

.PHONY: git
git:
	cp gitconfig ~/.gitconfig
	git config --global user.name "$(GIT_NAME)"
	git config --global user.email "$(GIT_EMAIL)"
