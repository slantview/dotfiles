ALL_DOTFILES := vimrc vim zshrc gemrc profile
ALL_PRIVATE_DOTFILES := zshrc_local s3cfg
ALL_DOTFILE_LINKS := $(ALL_DOTFILES:%=$(HOME)/.%)
ALL_PRIVATE_DOTFILE_LINKS := $(ALL_PRIVATE_DOTFILES:%=$(HOME)/.%)
ALL_CLEAN := $(addprefix clean-,${ALL_DOTFILES}) $(addprefix clean-,${ALL_PRIVATE_DOTFILES})

all: install

install: $(HOME)/.oh-my-zsh $(ALL_DOTFILE_LINKS) $(ALL_PRIVATE_DOTFILE_LINKS) 

$(HOME)/.oh-my-zsh:
	curl -L http://install.ohmyz.sh | sh

$(HOME)/.s3cmd:
	mkdir -p $(HOME)/.s3cmd
	curl http://downloads.sourceforge.net/project/s3tools/s3cmd/1.5.0-rc1/s3cmd-1.5.0-rc1.tar.gz | tar -zxv --strip-components=1 -C $(HOME)/.s3cmd

$(ALL_DOTFILE_LINKS): $(HOME)/.%:
	ln -fs $(shell pwd)/$* $(HOME)/.$*

$(ALL_PRIVATE_DOTFILE_LINKS): $(HOME)/.%:
	ln -fs $(HOME)/Dropbox/dotfiles/$* $(HOME)/.$*

clean: $(ALL_CLEAN) $(ALL_PRIVATE_CLEAN)
	rm -rf $(HOME)/.oh-my-zsh
	rm -rf $(HOME)/.s3cmd

$(ALL_CLEAN): clean-%:
	rm -f $(HOME)/.$*

.PHONY: install clean all