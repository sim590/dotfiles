base_TARGETS = accounts \
							 colors \
							 gpg \
							 gpg.rc \
							 mailboxes \
							 mailcap \
							 mappings \
							 muttrc
bin_TARGETS = bin/RunningX \
							bin/bgrun \
							bin/excel2text \
							bin/ppt2text \
							bin/word2text
TARGETS = $(base_TARGETS) $(bin_TARGETS)
DEST       = $(HOME)/.mutt
DEST_LINKS = $(addprefix $(DEST)/,$(base_TARGETS)) \
						 $(addprefix $(HOME)/bin/mutt/,$(subst bin/,,$(bin_TARGETS)))

.PHONY: all links
all: links

links: dirs $(DEST_LINKS)

dirs:
	mkdir -p $(dir $(DEST_LINKS))

define MAKE_LINKS
$(1): $(2)
	ln -s $$(CURDIR)/$$< $$@ ; true
endef
$(eval $(call MAKE_LINKS,$(DEST)/%, %))
$(eval $(call MAKE_LINKS,$(HOME)/bin/mutt/%, bin/%))

clean:
	rm -ir $(DEST_LINKS) ; true

# vim:set noet sts=0 sw=2 ts=2 tw=80:

