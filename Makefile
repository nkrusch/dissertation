TEMPLATE_VERSION := 0.2.1

TEMPLATE := https://github.com/the-au-forml-lab/au_ccs_dissertation_template/releases/download/$(TEMPLATE_VERSION)/tex_version.zip
ABSTRACT := text/abstract.tex

all: compile

compile:
	latexmk -pdf -xelatex main

watch:
	ls *.tex *.bib */*.tex */*.sty .latex/* | entr make

pull_template:
	@wget $(TEMPLATE) -O template.zip
	@unzip -o template.zip
	@rm -rf template.zip

update_main:
	cp tex_version/main.tex main.tex

clean:
	@rm -rf *.pdf *.aux *.acr *.xdv *.bbl *.bcf *.blg *.out *.fdb_latexmk *.fls *.log *.run.xml *.tex.blg *.synctex.gz *.vtc *.lot *.lof *.toc *~ main.pdf

count:
	@echo $$(wc -w < $(ABSTRACT)) '\t---' $(basename $(ABSTRACT))