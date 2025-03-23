TEMPLATE_VERSION := 0.2.1

TEMPLATE := https://github.com/the-au-forml-lab/au_ccs_dissertation_template/releases/download/$(TEMPLATE_VERSION)/tex_version.zip
ABSTRACT := text/abstract.tex

all: compile

compile:
	latexmk -pdf -xelatex "main.tex"

action:  # action workflow runs this command
	xelatex -no-pdf -file-line-error -halt-on-error -interaction=nonstopmode -recorder  "main.tex"

watch:
	ls *.tex */*.tex references/* latex/* | entr -n make compile

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
	@rm -rf *.pdf *.mst *.acn *.alg *glg *.glo *.gls *.ist *.slg *.sym *.aux *.acr *.sbl *.idx *.ind *.ilg *.xdv *.bbl *.bcf *.blg *.out *.fdb_latexmk *.fls *.log *.run.xml *.tex.blg *.synctex.gz *.vtc *.lot *.lof *.lol *.toc *~ main.pdf

count:  # the abstract has a word limit
	@echo $$(wc -w < $(ABSTRACT)) '\t---' $(basename $(ABSTRACT))

loc:
	cloc . --exclude-dir=tex_version,env,.github,.idea