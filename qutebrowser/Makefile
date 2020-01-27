TARGETS    = \
						 config.py \
						 base.py \
						 keys.py \
						 privacy.py \
						 utils.py \
						 password_fill_rc

DEST       = $(HOME)/.config/qutebrowser/
DEST_LINKS = $(addprefix $(DEST)/,$(TARGETS))

.PHONY: all links
all: links

links: dirs $(DEST_LINKS)

dirs:
	mkdir -p $(dir $(DEST_LINKS))

$(DEST)/%: %
	ln -s $(CURDIR)/$< $@ ; true
clean:
	rm -ir $(DEST_LINKS) ; true

# vim:set noet sts=0 sw=2 ts=2 tw=80:

