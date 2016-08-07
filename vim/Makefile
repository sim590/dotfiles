TARGETS    = functions.vim mappings.vim after plugins-config syntax
DEST       = $(HOME)/.vim/
DEST_LINKS = $(addprefix $(DEST)/,$(TARGETS))

.PHONY: all links
all: links

links: $(DEST) $(DEST_LINKS)

$(DEST):
	mkdir -p $@
$(DEST)/%: %
	ln -s $(CURDIR)/$< $@
clean:
	rm -rf $(DEST_LINKS)
