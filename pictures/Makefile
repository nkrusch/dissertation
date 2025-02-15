SRC := $(wildcard *.tex)
PDF_IMG := ${SRC:%.tex=fig_%.pdf}

all: $(PDF_IMG) mv_pdf_pics clean

fig_%.pdf : %.tex
	@latexmk -pdf -lualatex -jobname=$(subst .pdf,,$@) $<

mv_pdf_pics:
	@mv $(PDF_IMG) ../pdf

clean:
	@rm -rf *.dvi *.aux *.fdb_latexmk *.fls *.log *.xdv *.gz *.pdf
