SUBDIRS = awesome qutebrowser vim ncmpcpp beets ranger mutt

DOTFILES = gitconfig\
					 vimrc\
					 Xresources\
					 tigrc\
					 Xmodmap\
					 mbsyncrc\
					 zshrc\
					 conky\
					 gnupg/gpg-agent.conf\
					 config/mpd/mpd.conf\
					 config/systemd/user/mbsync.timer\
					 config/systemd/user/mbsync.service\
					 config/systemd/user/notmuch.service\
					 config/systemd/user/redshift.service.d/override.conf\
					 config/systemd/user/conky@.service\
					 config/systemd/user/conky.target\
					 config/systemd/user/keynav.service
BIN_FILES = bin/lights\
						bin/pinentry-rofi.scm\
						bin/setkeyboard\
						bin/udev-setkeyboard\
						bin/setwallpaper\
						bin/wmake\
						bin/sesame-ouvre-toi
DEST_LINKS   = $(addprefix $(HOME)/.,$(DOTFILES)) $(addprefix $(HOME)/,$(BIN_FILES))
CONFIG_FILES = $(shell git ls-tree --full-tree -r @ | grep -e 'blob.*[a-zA-Z]\+\.in' | gawk '{print $$4}')
CONFIG_OUT   = $(CONFIG_FILES:.in=)

.PHONY: all links subdirs clean
all: configure links subdirs

help: ## Prints help for targets with comments
	@cat $(MAKEFILE_LIST) | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

configure: $(CONFIG_OUT) ## Configure all the files (strings substitutions)

$(CONFIG_OUT): $(CONFIG_FILES)
		m4 macros.m4 $@.in > $@

links: dirs $(DEST_LINKS) ## Produce all symlinks on system

dirs:
	mkdir -p $(dir $(DEST_LINKS))

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

clean-config: ## Clean configured files (result of m4 processing)
	rm -f $(CONFIG_OUT)

clean-links: ## Clean links on the system
	rm -ir $(DEST_LINKS) ; true
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir clean; \
	done

clean: clean-links clean-config ## Clean all

# vim:set noet sts=0 sw=2 ts=2 tw=80:

