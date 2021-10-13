TARGETS    = \
						 config.py \
						 base.py \
						 keys.py \
						 privacy.py \
						 utils.py \
						 password_fill_rc

BIN_FILES      = bin/mpv
BIN_DEST       = $(HOME)/bin/qutebrowser_bin
BIN_DEST_LINKS = $(addprefix $(HOME)/bin/qutebrowser_bin/,$(patsubst bin/%,%,$(BIN_FILES)))
DEST           = $(HOME)/.config/qutebrowser/
DEST_LINKS     = $(addprefix $(DEST)/,$(TARGETS)) \
								 ${BIN_DEST_LINKS}

.PHONY: all links
all: links

links: dirs $(DEST_LINKS)

dirs:
	mkdir -p $(dir $(DEST_LINKS))

define MAKE_LINKS
$(1): $(2)
	ln -s $$(CURDIR)/$$< $$@ ; true
endef
$(eval $(call MAKE_LINKS,$(DEST)/%, %))
$(eval $(call MAKE_LINKS,$(BIN_DEST)/%, bin/%))

clean:
	rm -ir $(DEST_LINKS) ; true

# vim:set noet sts=0 sw=2 ts=2 tw=80:

