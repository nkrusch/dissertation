.SUFFIXES: .pdf .dot

SRC:=$(wildcard *.tex *.bib *.sty *.cls)

all:
	latexmk -pdf main

clean:
	rm -f *.bbl *.log *.out *.aux *.bcf *.blg *~ main.pdf

