TARGETS    = options.vim utilities.vim mappings.vim after plugins-config syntax ftplugin ftdetect
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
	ln -s $(CURDIR)/$< $@ ; true

$(VIMPLUG_DEST_LINK): vim-plug/plug.vim
	ln -s $(CURDIR)/$< $@ ; true

clean:
	rm -irf $(DEST_LINKS)

# vim:set noet sts=0 sw=2 ts=2 tw=80:

