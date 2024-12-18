TEMPLATE := https://raw.githubusercontent.com/the-au-forml-lab/au_ccs_dissertation_template/refs/heads/master/tex_version/main.tex
COUNTABLE := text/abstract.tex

all: compile

compile:
	latexmk -pdf -xelatex main

watch:
	ls *.tex *.bib */*.tex */*.sty .latex/* | entr make

update_template:
	wget $(TEMPLATE) -O main.tex

clean:
	@rm -rf *.pdf *.aux *.acr *.xdv *.bbl *.bcf *.blg *.out *.fdb_latexmk *.fls *.log *.run.xml *.tex.blg *.synctex.gz *.vtc *.lot *.lof *.toc *~ main.pdf

count:
	@($(foreach file, $(COUNTABLE), echo $$(wc -w < $(file)) '\t---' $(basename $(file)) ; ))