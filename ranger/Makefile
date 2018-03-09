TARGETS          := commands.py rc.conf rifle.conf scope.sh plugins

DEVICONS_TARGETS := devicons.py devicons_linemode.py
DEVICONS_LINKS   := $(addprefix plugins/,$(DEVICONS_TARGETS))

DEST_DIR         := $(HOME)/.config/ranger
DEST_LINKS       := $(addprefix $(DEST_DIR)/,$(TARGETS))

.PHONY: all links
all: links

links: dirs $(DEVICONS_LINKS) $(DEST_LINKS)

dirs:
	@mkdir -p $(DEST_DIR)

define MAKE_LINKS
$(1): $(2)
	ln -s $$(CURDIR)/$$< $$@ ; true
endef
$(eval $(call MAKE_LINKS,plugins/%,devicons/%))
$(eval $(call MAKE_LINKS,$(DEST_DIR)/%))

clean:
	rm -irf $(DEST_LINKS) $(DEVICONS_LINKS)

# vim:set noet sts=0 sw=2 ts=2 tw=80:

