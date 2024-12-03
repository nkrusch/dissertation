all:
	pdflatex main

compile:
	pdflatex main && biber main && pdflatex main

watch:
	ls *.tex *.bib */*.tex */*.sty | entr make

clean:
	rm -rf *.pdf *.aux *.bbl *.bcf *.blg *.out *.fdb_latexmk *.fls *.log *.run.xml *.tex.blg *.synctex.gz *.vtc
