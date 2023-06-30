all: main

compile:
	latexmk -pdf -bibtex -f thesis.tex

.PHONY: main
main:
	ls *.tex *.bib */*.tex | entr make compile

clean:
	find . -name \*.aux -type f -delete
	find . -name \*.bbl -type f -delete
	find . -name \*.blg -type f -delete
	find . -name \*.fdb_latexmk -type f -delete
	find . -name \*.fls -type f -delete
	find . -name \*.log -type f -delete
	find . -name \*.out -type f -delete
	find . -name \*.bcf -type f -delete
	find . -name \*.nav -type f -delete
	find . -name \*.run.xml -type f -delete
	find . -name \*.snm -type f -delete
	find . -name \*.toc -type f -delete
	find . -name \*.vrb -type f -delete
	find . -name \*.synctex.gz -type f -delete
	rm -rf `biber --cache`
