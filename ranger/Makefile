TARGETS := commands.py\
	rc.conf\
	rifle.conf\
	scope.sh\
	devicons.py\
	plugins

DEVICONS_LINKS := devicons.py plugins/devicons_linemode.py
DEST_DIR       := $(HOME)/.config/ranger
DEST_LINKS     := $(addprefix $(DEST_DIR)/,$(TARGETS))

.PHONY: all links
all: links

links: dirs $(DEVICONS_LINKS) $(DEST_LINKS)

dirs:
	mkdir -p $(dir $(DEST_LINKS))

define MAKE_LINKS
$(1): $(2)
	ln -s $$(CURDIR)/$$< $$@ ; true
endef
$(eval $(call MAKE_LINKS,plugins/devicons_linemode.py,devicons/devicons_linemode.py))
$(eval $(call MAKE_LINKS,devicons.py,devicons/devicons.py))
$(eval $(call MAKE_LINKS,$(DEST_DIR)/%,%))

clean:
	rm -ir $(DEST_LINKS) $(DEVICONS_LINKS) ; true

# vim:set noet sts=0 sw=2 ts=2 tw=80:

