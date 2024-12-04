DIR:=$(shell find . -type d -maxdepth 1 -mindepth 1)

_plas_  := ../../statyc/papers/published/plas2024/submitted/
_coqpl_ := ../../statyc/papers/published/coqpl/camera-ready/

all: $(DIR)

$(DIR):
	@cd $@ && latexmk -pdf main

%.cp:
	cp -R $(_$(basename $@)_) $(basename $@)

clean:
	@$(foreach d, . $(DIR), \
	(cd $(d) &&	rm -rf *.pdf *.aux *.bbl *.bcf *.blg *.out *.fdb_latexmk \
     *.fls *.log *.run.xml *.tex.blg *.synctex.gz *.vtc *.lot *.lof *.toc *~ main.pdf) ;)

.PHONY: $(DIR)
