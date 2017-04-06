TARGETS    = config.yaml
DEST       = $(HOME)/.config/beets/
DEST_LINKS = $(addprefix $(DEST)/,$(TARGETS))

.PHONY: all links
all: links

links: $(DEST) $(DEST_LINKS)

$(DEST):
	mkdir -p $@
$(DEST)/%: %
	ln -s $(CURDIR)/$< $@ ; true
clean:
	rm -irf $(DEST_LINKS)
