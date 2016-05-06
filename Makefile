TEX=pdflatex
BIBTEX=bibtex

all: 04-lecture-notes.pdf

# This does a little more work than strictly necessary, but for regular-sized
# documents you probably won't notice on today's machines...
04-lecture-notes.pdf: 04-lecture-notes.tex 04-lecture-notes.bib plot.pdf
	$(TEX) $<
	while ($(BIBTEX) $(basename $<).aux ; \
	$(TEX) $< ; \
	grep -q "Rerun to get cross-references" $(basename $<).log ) do true ; \
	done

plot.pdf: plot.py
	python $^

.PHONY: clean
clean:
	rm -rf *.aux *.log *.toc *.lof *.nav *.out *.snm *.lot *.pdf *.bbl \
	*.blg *.dvi *.idx *.ilg *.ind
