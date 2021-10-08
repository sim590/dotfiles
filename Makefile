SUBDIRS = awesome qutebrowser vim ncmpcpp beets ranger mutt

ZSH_CONFIG = \
						 zsh/zshrc.debian \
						 zsh/zshrc.env \
						 zsh/zshrc.local \
						 zsh/zshrc.fzf \
						 zsh/zshrc.wine \
						 zsh/zshrc.alias
XDG_CONFIG_CONTENT = \
					 config/zathura/zathurarc\
					 config/mpd/mpd.conf\
					 config/mpv/input.conf\
					 config/systemd/user/mbsync.timer\
					 config/systemd/user/mbsync.service\
					 config/systemd/user/notmuch.service\
					 config/systemd/user/redshift.service.d/override.conf\
					 config/systemd/user/conky@.service\
					 config/systemd/user/conky.target\
					 config/systemd/user/keynav.service\
					 config/systemd/user/ipfs.service
DOTFILES = gitconfig\
					 vimrc\
					 Xresources\
					 taskrc\
					 tigrc\
					 Xmodmap\
					 mbsyncrc\
					 zshrc\
					 zplug\
					 conky\
					 keynavrc\
					 fzf_env\
					 gnupg/gpg-agent.conf
BIN_FILES = bin/lights\
						bin/pinentry-rofi.scm\
						bin/setkeyboard\
						bin/udev-setkeyboard\
						bin/setwallpaper\
						bin/wmake\
						bin/rofi\
						bin/pqutebrowser\
						bin/sesame-ouvre-toi
ZSH_DEST_LINKS        = $(addprefix $(HOME)/.,$(subst zsh/,,${ZSH_CONFIG}))
XDG_CONFIG_DEST_LINKS = $(addprefix $(HOME)/.,${XDG_CONFIG_CONTENT})
DOTFILES_DEST_LINKS   = $(addprefix $(HOME)/.,$(DOTFILES))
BIN_DEST_LINKS			  = $(addprefix $(HOME)/,$(BIN_FILES))
DEST_LINKS            = ${ZSH_DEST_LINKS} \
												${XDG_CONFIG_DEST_LINKS} \
												${DOTFILES_DEST_LINKS} \
												${BIN_DEST_LINKS}
CONFIG_FILES = $(shell git ls-tree --full-tree -r @ | grep -e 'blob.*[a-zA-Z]\+\.in' | gawk '{print $$4}')
CONFIG_OUT   = $(CONFIG_FILES:.in=)

.PHONY: all links subdirs clean
all: configure links subdirs

help: ## Prints help for targets with comments
	@cat $(MAKEFILE_LIST) | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

configure: $(CONFIG_OUT) ## Configure all the files (strings substitutions)

$(CONFIG_OUT): $(CONFIG_FILES)
		m4 $(foreach def,$(M4_DEFINE),-D$(def)) macros.m4 $@.in > $@
		chmod $(if $(findstring bin/,$@),755,644) $@

links: dirs $(DEST_LINKS) ## Produce all symlinks on system

dirs:
	mkdir -p $(dir $(DEST_LINKS))

define MAKE_LINKS
$(1): $(2)
	ln -s $$(CURDIR)/$$< $$@ ; true
endef
$(eval $(call MAKE_LINKS,$(HOME)/.%, %))
$(eval $(call MAKE_LINKS,$(HOME)/.%, zsh/%))
$(eval $(call MAKE_LINKS,$(HOME)/bin/%, bin/%))

zshrc:
	git submodule update --init zsh/grml
	ln -s zsh/grml/etc/zsh/zshrc

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

