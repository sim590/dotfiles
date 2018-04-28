SUBDIRS = awesome qutebrowser vim ncmpcpp beets

DOTFILES = gitconfig\
					 vimrc\
					 Xresources\
					 tigrc\
					 Xmodmap\
					 mbsyncrc\
					 zshrc\
					 gnupg/gpg-agent.conf\
					 config/mpd/mpd.conf
BIN_FILES = bin/lights\
						bin/pinentry-rofi.rb\
						bin/set_keyboard\
						bin/setwallpaper\
						bin/wmake
DEST_LINKS  = $(addprefix $(HOME)/.,$(DOTFILES)) $(addprefix $(HOME)/,$(BIN_FILES))

.PHONY: all links subdirs clean
all: links subdirs

links: $(DEST_LINKS) subdirs

define MAKE_LINKS
$(1): $(2)
	ln -s $$(CURDIR)/$$< $$@ ; true
endef
$(eval $(call MAKE_LINKS,$(HOME)/.%, %))
$(eval $(call MAKE_LINKS,$(HOME)/bin/%, bin/%))

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

