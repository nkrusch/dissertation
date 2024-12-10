TEMPLATE := https://raw.githubusercontent.com/the-au-forml-lab/au_ccs_dissertation_template/refs/heads/master/tex_version/main.tex
COUNTABLE := text/abstract.tex
COLOR_EMPHASIS := \033[0;32m
COLOR_END := \033[0m

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
	@($(foreach file, $(COUNTABLE), echo "$(COLOR_EMPHASIS)" $$(wc -w < $(file)) "$(COLOR_END)" '\t---' $(basename $(file)) ; ))