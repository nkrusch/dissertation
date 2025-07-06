SHELL := /bin/bash

all: compile

full: compile terms compile

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

%.tex: %.ott
	ott -i $< -o $@ -tex_wrap false

loc:
	cloc . --exclude-dir=env,.github,.idea,fonts

clean:
	@rm -rf *.pdf *.mst *.acn *.loa *.alg *glg *.glo *.gls *.ist *.slg \
 	*.listing *.sym *.aux *.acr *.sbl *.idx *.ind *.ilg *.xdv *.bbl \
 	*.bcf *.blg *.out *.fdb_latexmk *.fls *.log *.run.xml *.tex.blg \
 	*.synctex.gz *.vtc *.lot *.lof *.lol *.toc *~ main.pdf $(ARC)
