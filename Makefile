SHELL := /bin/bash

ARC_FLTR  := $(patsubst %,! -name '%',dissertation .git .github .gitignore *.zip main.pdf)
ARC_ITEMS := $(patsubst ./%,%,$(shell find . -mindepth 1 -maxdepth 1 $(ARC_FLTR)))
ARC_NAME  := dissertation

all: compile
archive: sources.zip

full: compile
	make terms && make compile

compile:
	latexmk -pdf -xelatex "main.tex"

terms:
	makeglossaries main

figures:
	make -C pictures

%.zip: clean
	@mkdir -p $(ARC_NAME) && $(foreach x, $(ARC_ITEMS), cp -R $(x) $(ARC_NAME) ;)
	zip -r $@ $(ARC_NAME) && rm -rf $(ARC_NAME)

clean:
	@rm -rf *.pdf *.mst *.acn *.loa *.alg *glg *.glo *.gls *.ist *.slg \
 	*.listing *.sym *.aux *.acr *.sbl *.idx *.ind *.ilg *.xdv *.bbl \
 	*.bcf *.blg *.out *.fdb_latexmk *.fls *.log *.run.xml *.tex.blg \
 	*.synctex.gz *.vtc *.lot *.lof *.lol *.toc code/.*.aux *~ main.pdf
	@$(foreach x,__MACOSX *.DS_Store, find . -name $(x) -exec rm -rf {} + ;)
	@cd code && rm -rf *.vo *.vos *.vio
	@rm -rf $(ARC)