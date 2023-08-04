SRC:=$(wildcard *.tex *.bib *.sty *.cls) 

.SUFFIXES: .pdf .dot

main.pdf: $(SRC)
	latexmk -pdf main
#	pdflatex main
#	bibtex main
#	pdflatex main

clean:
	rm -f *.bbl *.log *.out *.aux *.bcf *.blg *~ main.pdf

.PHONY: main.pdf 
 
