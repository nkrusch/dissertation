SRC := $(shell find *.tex ! -name "_*")
PDF_IMG := ${SRC:%.tex=fig_%.pdf}

all: $(PDF_IMG)
	@mv $(PDF_IMG) ../pdf
	@rm -rf *.dvi *.aux *.fdb_latexmk *.fls *.log *.xdv *.gz *.pdf

fig_%.pdf : %.tex
	@latexmk -pdf -lualatex -jobname=$(subst .pdf,,$@) $<
