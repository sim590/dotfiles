TARGETS    = options.vim utilities.vim mappings.vim autoload after plugins-config syntax ftplugin ftdetect coc-settings.json
DEST_DIR   = $(HOME)/.vim
DEST_LINKS = $(addprefix $(DEST_DIR)/,$(TARGETS))
VIMPLUG_DEST_LINK = autoload/plug.vim

.PHONY: all links
all: links

links: dirs $(DEST_LINKS) $(VIMPLUG_DEST_LINK)

dirs:
	mkdir -p autoload
	mkdir -p $(dir $(DEST_LINKS))

define MAKE_LINKS
$(1): $(2)
	ln -s $$(CURDIR)/$$< $$@ ; true
endef
$(eval $(call MAKE_LINKS,$(DEST_DIR)/%, %))
$(eval $(call MAKE_LINKS,autoload/plug.vim,vim-plug/plug.vim))

clean:
	rm -ir $(DEST_LINKS) $(VIMPLUG_DEST_LINK) ; true

# vim:set noet sts=0 sw=2 ts=2 tw=80:

