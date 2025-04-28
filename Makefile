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
	#cp ../review/0-acks/text.tex text/ch-acks.tex
	cp ../review/0-abs/abstract.txt text/ch-abstract.tex
	cp ../review/1-aims/text.tex text/ch-aims.tex
	cp ../review/1-bg-intro/text.tex text/bg-intro.tex
	cp ../review/1-formal/text.tex text/bg-formal.tex
	cp ../review/1-icc/text.tex text/bg-icc.tex
	cp ../review/1-loops/text.tex text/bg-loops.tex
	cp ../review/1-mwp/text.tex text/bg-mwp.tex
	cp ../review/1-security/text.tex text/bg-security.tex
	cp ../review/1-static/text.tex text/bg-static.tex
	cp ../review/2-guide/text.tex text/pubs-pymwp-guide.tex
	cp ../review/3-coqpl/text.tex text/pubs-coqpl.tex
	cp ../review/3-ni/text.tex text/pubs-ni.tex
	#cp ../review/4-discussion/text.tex text/ch-discussion.tex
	cp ../review/5-summary/text.tex text/ch-summary.tex
	cp ../review/bib.bib references/references.bib
	cp -R ../review/listings/. code

%.tex: %.ott
	ott -i $< -o $@ -tex_wrap false

loc:
	cloc . --exclude-dir=tex_version,env,.github,.idea

clean:
	@rm -rf *.pdf *.mst *.acn *.loa *.alg *glg *.glo *.gls *.ist *.slg \
 	*.listing *.sym *.aux *.acr *.sbl *.idx *.ind *.ilg *.xdv *.bbl \
 	*.bcf *.blg *.out *.fdb_latexmk *.fls *.log *.run.xml *.tex.blg \
 	*.synctex.gz *.vtc *.lot *.lof *.lol *.toc *~ main.pdf