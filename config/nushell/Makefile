
TARGETS    := plugins/nu_plugin_secret
DEST_DIR   := $(HOME)/.config/nushell
DEST_LINKS := $(addprefix $(DEST_DIR)/,$(TARGETS))

.PHONY: all links carapace plugins nu_plugin_secret
all: links

links: dirs $(DEVICONS_LINKS) $(DEST_LINKS)

dirs:
	mkdir -p $(dir $(DEST_LINKS))

define MAKE_LINKS
$(1): $(2)
	ln -s $$(CURDIR)/$$< $$@ ; true
endef
$(eval $(call MAKE_LINKS,$(DEST_DIR)/%,%))

plugins: nu_plugin_secret

carapace:
	@if which carapace >/dev/null; then\
		carapace _carapace nushell > ~/.cache/nushell/carapace.nu ;\
		echo "Carapace configuré." ;\
	else \
		echo "Carapace est nécessaire pour configurer la complétion.";\
		echo "Voir https://github.com/carapace-sh/carapace-bin";\
	fi

nu_plugin_secret:
	git submodule update --init plugins/nu_plugin_secret
	(cd plugins/nu_plugin_secret && cargo build --release)

clean:
	(cd plugins/nu_plugin_secret && cargo clean)

