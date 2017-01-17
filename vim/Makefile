TARGETS    = functions.vim mappings.vim after plugins-config syntax
DEST_DIR   = $(HOME)/.vim
DEST_LINKS = $(addprefix $(DEST_DIR)/,$(TARGETS))
VIMPLUG_DEST_LINK = $(DEST_DIR)/autoload/plug.vim

.PHONY: all links
all: links

links: dirs $(DEST_LINKS) $(VIMPLUG_DEST_LINK)

dirs:
	@mkdir -p \
		$(DEST_DIR) \
		$(DEST_DIR)/autoload

$(DEST_DIR)/%: %
	ln -s $(CURDIR)/$< $@

$(VIMPLUG_DEST_LINK): vim-plug/plug.vim
	ln -s $(CURDIR)/$< $@

clean:
	rm -irf $(DEST_LINKS)
