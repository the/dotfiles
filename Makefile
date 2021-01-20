DOTFILES_DIR=.dotfiles

.PHONY: install
install: git
	ln -s $(DOTFILES_DIR)/vimrc ../.vimrc

.PHONY: git
git:
	cp gitconfig ../.gitconfig
	git config --global user.name $(GIT_NAME)
	git config --global user.email $(GIT_EMAIL)
