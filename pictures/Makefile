IMAGES := $(patsubst %.tex,fig_%,$(shell find *.tex ! -name "_*"))

all: $(IMAGES)
	@mv fig_*.pdf ../pdf
	@rm -rf *.dvi *.aux *.fdb_latexmk *.fls *.log *.xdv *.gz *.pdf

fig_% : %.tex
	@latexmk -pdf -lualatex -jobname=$@ $<
