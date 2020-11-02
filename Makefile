PREVIOUS = 08
VERSION  = 09

BASE   = draft-ietf-avtcore-cc-feedback-message
DRAFTS = $(BASE)-$(VERSION).pdf \
         $(BASE)-$(VERSION).txt 
DIFF   = $(BASE)-$(VERSION)-from-$(PREVIOUS).diff.html

all: $(DRAFTS) $(DIFF)

%.txt: %.xml
	@echo "*** generate $< -> $@"
	@xml2rfc $<
	@egrep -ns --colour "\\bmust|required|shall|should|recommended|may|optional\\b" $< || true
	@egrep -ns --colour "\\btbd\\b" $< || true

%.pdf: %.txt
	@echo "*** enscript $< -> $@"
	@enscript -q -lc -f Courier11 -M A4 -p - $< | ps2pdf - $@

$(DIFF): $(BASE)-$(VERSION).txt
	@echo "*** diff $(BASE)-$(PREVIOUS) -> $(BASE)-$(VERSION)"
	@rfcdiff --stdout $(BASE)-$(PREVIOUS).txt $(BASE)-$(VERSION).txt > $(DIFF)

clean:
	-rm -f $(DRAFTS)

