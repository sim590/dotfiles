TARGETS    = config.py password_fill_rc
DEST       = $(HOME)/.config/qutebrowser/
DEST_LINKS = $(addprefix $(DEST)/,$(TARGETS))

.PHONY: all links
all: links

links: $(DEST) $(DEST_LINKS)

$(DEST):
	mkdir -p $@
$(DEST)/%: %
	ln -s $(CURDIR)/$< $@ ; true
clean:
	rm -ir $(DEST_LINKS) ; true

# vim:set noet sts=0 sw=2 ts=2 tw=80:

