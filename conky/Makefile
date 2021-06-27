.PHONY: all links dirs prepare decompress-imgs

BIN_FILES = \
			bin/conky-task-progress.sh \
			bin/conky-bg-space-to-fg.sh
BIN_DEST_LINKS = $(addprefix $(HOME)/,$(BIN_FILES))
DEST_LINKS     = ${BIN_DEST_LINKS}

all: prepare links

links: dirs $(DEST_LINKS)

dirs:
	mkdir -p $(dir $(DEST_LINKS))

define MAKE_LINKS
$(1): $(2)
	ln -s $$(CURDIR)/$$< $$@ ; true
endef
$(eval $(call MAKE_LINKS,$(HOME)/bin/%, bin/%))

prepare: decompress-imgs

decompress-imgs: dateweather/imgs.tar.gz
	tar -C dateweather -xzf $<

#  vim: set sts=0 ts=4 sw=4 tw=120 noet :

