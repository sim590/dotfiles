SUBDIRS = awesome qutebrowser vim ncmpcpp beets

DOTFILES = gitconfig vimrc Xresources tigrc
DEST_LINKS = $(addprefix $(HOME)/.,$(DOTFILES))

.PHONY: all links subdirs clean
all: links subdirs

links: $(DEST_LINKS) subdirs

$(HOME)/.%: %
	ln -s $(CURDIR)/$< $@ ; true

subdirs:
	@for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir; \
	done

clean:
	rm -irf $(DEST_LINKS)
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir clean; \
	done
