INFILES = $(shell find . -name "*.src.html")
OUTFILES = $(INFILES:.src.html=.html)
TEMP:= $(shell mktemp -u /tmp/config.XXXXXX)

all: $(OUTFILES)

%.html: %.src.html menu.inc footer.inc header.inc
	m4 -PEIinc $< > $(TEMP)
	toc $(TEMP) > $@
	rm -f $(TEMP)

upload: all
	@aws s3 --profile mine sync --delete --exclude Makefile \
		--exclude '*.inc' \
		--exclude 'assets' \
		--exclude '.git/*' \
		--exclude 'node_modules/' \
		--exclude '*.src.html' \
		--storage-class STANDARD_IA \
		--acl public-read . s3://prazefarm/
	@aws --profile mine s3 sync --cache-control="max-age=86400" --storage-class STANDARD_IA --acl public-read assets s3://prazefarm/assets
	@aws --profile mine cloudfront create-invalidation --distribution-id E3C8Z7VRIZH2B3 --invalidation-batch "{ \"Paths\": { \"Quantity\": 1, \"Items\": [ \"/*\" ] }, \"CallerReference\": \"$(shell date +%s)\" }"

clean:
	rm -f $(OUTFILES)

PHONY: all clean
