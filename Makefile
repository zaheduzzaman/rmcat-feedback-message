VERSION = 01

DRAFTS = draft-ietf-avtcore-cc-feedback-message-$(VERSION).pdf \
         draft-ietf-avtcore-cc-feedback-message-$(VERSION).txt 

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

