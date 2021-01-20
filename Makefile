DOTFILES_DIR=.dotfiles

.PHONY: install
install:
	ln -s $(DOTFILES_DIR)/vimrc ../.vimrc
	ln -s $(DOTFILES_DIR)/tmux.conf ../.tmux.conf

.PHONY: git
git:
	cp gitconfig ../.gitconfig
	git config --global user.name $(GIT_NAME)
	git config --global user.email $(GIT_EMAIL)
