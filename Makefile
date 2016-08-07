SUBDIRS = awesome qutebrowser vim

DOTFILES = gitconfig vimrc
DEST_LINKS = $(addprefix $(HOME)/.,$(DOTFILES))

.PHONY: all links subdirs clean
all: links subdirs

links: $(DEST_LINKS) subdirs

$(HOME)/.%: %
	ln -s $(CURDIR)/$< $@

subdirs:
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir; \
	done

clean:
	rm -rf $(DEST_LINKS)
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir clean; \
	done
