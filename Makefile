all:
	pdflatex main

compile:
	latexmk -pdf main && biber main && latexmk -pdf main

watch:
	ls *.tex *.bib */*.tex */*.sty .latex/* | entr make

pubs:
	make -C papers

clean:
	@rm -rf *.pdf *.aux *.bbl *.bcf *.blg *.out *.fdb_latexmk \
	*.fls *.log *.run.xml *.tex.blg *.synctex.gz *.vtc *.lot *.lof *.toc \
	*~ main.pdf
