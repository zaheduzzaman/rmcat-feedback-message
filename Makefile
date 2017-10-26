VERSION = 04

DRAFTS = draft-dt-rmcat-feedback-message-$(VERSION).pdf \
         draft-dt-rmcat-feedback-message-$(VERSION).txt 

all: $(DRAFTS)

%.txt: %.xml
	@echo "*** generate $< -> $@"
	@xml2rfc $<
	@egrep -ns --colour "\\bmust|required|shall|should|recommended|may|optional\\b" $< || true
	@egrep -ns --colour "\\btbd\\b" $< || true

%.pdf: %.txt
	@echo "*** enscript $< -> $@"
	@enscript -q -lc -f Courier11 -M A4 -p - $< | ps2pdf - $@

clean:
	-rm -f $(DRAFTS)

