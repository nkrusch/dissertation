SRC := $(wildcard *.tex)
PDF_IMG := ${SRC:%.tex=fig_%.pdf}

all: $(PDF_IMG) mv_pdf_pics

fig_%.pdf : %.tex
	@latexmk -pdf -xelatex -jobname=$(subst .pdf,,$@) $<

mv_pdf_pics:
	@mv $(PDF_IMG) ../pdf

clean:
	@rm -rf *.dvi *.aux *.fdb_latexmk *.fls *.log *.xdv
