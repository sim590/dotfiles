SUBDIRS = awesome qutebrowser vim ncmpcpp beets

DOTFILES     = gitconfig vimrc Xresources tigrc Xmodmap mbsyncrc zshrc
CONFIG_PATH  = $(HOME)/.config
DEST_LINKS   = $(addprefix $(HOME)/.,$(DOTFILES))

.PHONY: all links subdirs clean
all: links subdirs

links: $(DEST_LINKS) $(CONFIG_PATH)/mpd/mpd.conf subdirs

define MAKE_LINKS
$(1): $(2)
	ln -s $$(CURDIR)/$$< $$@ ; true
endef
$(eval $(call MAKE_LINKS,$(HOME)/.%, %))
$(eval $(call MAKE_LINKS,$(CONFIG_PATH)/mpd/%,%))

zshrc:
	git submodule update --init
	ln -s grml/etc/zsh/zshrc

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

