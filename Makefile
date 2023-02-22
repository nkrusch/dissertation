all: main

compile:
	latexmk -pdf -bibtex -f thesis.tex

.PHONY: main
main:
	ls *.tex *.bib */*.tex | entr make compile

