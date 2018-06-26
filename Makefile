SUBDIRS = awesome qutebrowser vim ncmpcpp beets ranger

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
						bin/setkeyboard\
						bin/udev-setkeyboard\
						bin/setwallpaper\
						bin/wmake
DEST_LINKS  = $(addprefix $(HOME)/.,$(DOTFILES)) $(addprefix $(HOME)/,$(BIN_FILES))

.PHONY: all links subdirs clean
all: links subdirs

help: ## Prints help for targets with comments
	@cat $(MAKEFILE_LIST) | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

links: $(DEST_LINKS) ## Produce all symlinks on system

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

