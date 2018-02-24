SUBDIRS = awesome qutebrowser vim ncmpcpp beets

DOTFILES = gitconfig vimrc Xresources tigrc Xmodmap mbsyncrc zshrc
DEST_LINKS = $(addprefix $(HOME)/.,$(DOTFILES))

.PHONY: all links subdirs clean
all: links subdirs

links: $(DEST_LINKS) subdirs

$(HOME)/.%: %
	ln -s $(CURDIR)/$< $@ ; true

zshrc:
	git submodule update --init
	ln grml/etc/zsh/zshrc

subdirs:
	@for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir; \
	done

clean:
	rm -irf $(DEST_LINKS)
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir clean; \
	done

# vim:set noet sts=0 sw=2 ts=2 tw=80:

