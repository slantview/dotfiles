install: $(HOME)/.vimrc $(HOME)/.vim $(HOME)/.zshrc $(HOME)/.zshrc_local
	curl -L http://install.ohmyz.sh | sh

$(HOME)/.vimrc:
	ln -s vimrc ~/.vimrc

$(HOME)/.vim:
	ln -s vim ~/.vim

$(HOME)/.zshrc:
	ln -s zshrc ~/.zshrc

$(HOME)/.zshrc_local:
	ln -s $(HOME)/Dropbox/dotfiles/zshrc_local ~/.zshrc_local

.PHONY: install