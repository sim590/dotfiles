TARGETS    = rc rc.lua
DEST       = $(HOME)/.config/awesome/
DEST_LINKS = $(addprefix $(DEST)/,$(TARGETS))

.PHONY: all links
all: links

links: $(DEST) $(DEST_LINKS)

$(DEST):
	mkdir -p $@
$(DEST)/%: %
	ln -s $(CURDIR)/$< $@
clean:
	rm -irf $(DEST_LINKS)
