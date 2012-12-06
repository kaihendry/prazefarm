INFILES = $(shell find . -name "*.src.html")
OUTFILES = $(INFILES:.src.html=.html)
TEMP:= $(shell mktemp -u /tmp/config.XXXXXX)

all: $(OUTFILES)

%.html: %.src.html
	m4 -PEIinc $< > $(TEMP)
	anolis $(TEMP) $@
	rm -f $(TEMP)

clean:
	rm -f $(OUTFILES)

PHONY: all clean
