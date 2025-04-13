TEMPLATE_VERSION := 0.2.1
TEMPLATE := https://github.com/the-au-forml-lab/au_ccs_dissertation_template/releases/download/$(TEMPLATE_VERSION)/tex_version.zip

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

update:
	cp ../review/s1-aims/text.tex text/ch-aims.tex
	cp ../review/s2-intro/text.tex text/bg-intro.tex
	cp ../review/s2-icc/text.tex text/bg-icc.tex
	cp ../review/s2-static/text.tex text/bg-static.tex
	cp ../review/s2-mwp/text.tex text/bg-mwp.tex
	cp ../review/s2-loops/text.tex text/bg-loops.tex
	cp ../review/s2-security/text.tex text/bg-security.tex
	cp ../review/tool-guide/text.tex text/pubs-pymwp-guide.tex
	cp ../review/bib.bib references/references.bib
	cp -R ../review/listings/. code

%.tex: %.ott
	ott -i $< -o $@ -tex_wrap false

loc:
	cloc . --exclude-dir=tex_version,env,.github,.idea

pull_template:
	@wget $(TEMPLATE) -O template.zip
	@unzip -o template.zip
	@rm -rf template.zip

clean:
	@rm -rf *.pdf *.mst *.acn *.loa *.alg *glg *.glo *.gls *.ist *.slg \
 	*.listing *.sym *.aux *.acr *.sbl *.idx *.ind *.ilg *.xdv *.bbl \
 	*.bcf *.blg *.out *.fdb_latexmk *.fls *.log *.run.xml *.tex.blg \
 	*.synctex.gz *.vtc *.lot *.lof *.lol *.toc *~ main.pdf