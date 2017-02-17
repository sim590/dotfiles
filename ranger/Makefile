TARGETS    = commands.py rc.conf rifle.conf scope.sh plugins/plugin_udisksctl.py
DEST_DIR   = $(HOME)/.config/ranger $(HOME)/.config/ranger/plugins
DEST_LINKS = $(addprefix $(DEST_DIR)/,$(TARGETS))

.PHONY: all links
all: links

links: dirs $(DEST_LINKS)

dirs:
	@mkdir -p $(DEST_DIR)

$(DEST_DIR)/%: %
	ln -s $(CURDIR)/$< $@ ; true

clean:
	rm -irf $(DEST_LINKS)
