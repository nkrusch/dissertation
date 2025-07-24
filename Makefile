SHELL := /bin/bash

compile: main.pdf

all: compile
full: compile
	make terms && make compile

%.pdf: %.tex
	latexmk -pdf -xelatex $<

terms:
	makeglossaries main

figures:
	make -C pictures

clean:
	@rm -rf *.pdf *.mst *.acn *.loa *.alg *glg *.glo *.gls *.ist *.slg \
 	*.listing *.sym *.aux *.acr *.sbl *.idx *.ind *.ilg *.xdv *.bbl \
 	*.bcf *.blg *.out *.fdb_latexmk *.fls *.log *.run.xml *.tex.blg \
 	*.synctex.gz *.vtc *.lot *.lof *.lol *.toc code/.*.aux *~ main.pdf
