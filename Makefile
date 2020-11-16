DOTFILES_DIR=.dotfiles

.PHONY: install
install: git
	ln -s $(DOTFILES_DIR)/vimrc ../.vimrc

.PHONY: git
git:
	cp gitconfig ../.gitconfig
	git config --global user.name $(GIT_NAME)
	git config --global user.email $(GIT_EMAIL)

.PHONY: vim
vim:
	git clone https://github.com/preservim/nerdtree.git ~/.vim/pack/vendor/start/nerdtree
	git clone --branch v1.24 https://github.com/fatih/vim-go.git ~/.vim/pack/plugins/start/vim-go
