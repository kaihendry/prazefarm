INFILES = $(shell find . -name "*.src.html")
OUTFILES = $(INFILES:.src.html=.html)
TEMP:= $(shell mktemp -u /tmp/config.XXXXXX)

all: $(OUTFILES)

%.html: %.src.html
	m4 -PEIinc $< > $(TEMP)
	toc $(TEMP) > $@
	rm -f $(TEMP)

upload:
	@aws s3 sync --delete --exclude Makefile \
		--exclude '*.inc' \
		--exclude '.git/*' \
		--exclude '*.src.html' \
		--storage-class STANDARD_IA \
		--acl public-read . s3://prazefarm/

clean:
	rm -f $(OUTFILES)

PHONY: all clean
