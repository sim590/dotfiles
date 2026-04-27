
TARGETS    := bin/vrr_fullscreen.sh
DEST_DIR   := $(HOME)/bin/sway
DEST_LINKS := $(addprefix $(DEST_DIR)/,$(notdir $(TARGETS)))

.PHONY: all links

all: links

links: $(DEST_LINKS)

$(DEST_DIR):
	mkdir -p $@

$(DEST_DIR)/%: bin/% | $(DEST_DIR)
	ln -sf $(CURDIR)/$< $@

#  vim: set sts=0 ts=2 sw=0 tw=120 noet :
