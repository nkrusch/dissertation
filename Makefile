TEMPLATE_VERSION := 0.2.1

TEMPLATE := https://github.com/the-au-forml-lab/au_ccs_dissertation_template/releases/download/$(TEMPLATE_VERSION)/tex_version.zip
ABSTRACT := text/abstract.tex

all: with_glossaries

compile:
	latexmk -xelatex main

action:  # action workflow runs this command
	xelatex -no-pdf -file-line-error -halt-on-error -interaction=nonstopmode -recorder  "main.tex"

with_glossaries:
	@make compile && make terms && make compile

watch:
	ls *.tex references/* */*.tex */*.sty .latex/* | entr make compile

terms:
	makeglossaries main

figures:
	make -C pictures

pull_template:
	@wget $(TEMPLATE) -O template.zip
	@unzip -o template.zip
	@rm -rf template.zip

update_main:
	cp tex_version/main.tex main.tex

clean:
	@rm -rf *.pdf *.acn *.alg *glg *.glo *.gls *.ist *.slg *.sym *.aux *.acr *.sbl *.idx *.ind *.ilg *.xdv *.bbl *.bcf *.blg *.out *.fdb_latexmk *.fls *.log *.run.xml *.tex.blg *.synctex.gz *.vtc *.lot *.lof *.toc *~ main.pdf

count:  # the abstract has a word limit
	@echo $$(wc -w < $(ABSTRACT)) '\t---' $(basename $(ABSTRACT))