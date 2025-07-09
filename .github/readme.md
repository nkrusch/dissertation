# Dissertation

[![Compile](https://github.com/nkrusch/thesis/actions/workflows/compile.yaml/badge.svg)](https://github.com/nkrusch/thesis/actions/workflows/compile.yaml)
[![Package](https://github.com/nkrusch/dissertation/actions/workflows/package.yaml/badge.svg)](https://github.com/nkrusch/dissertation/actions/workflows/package.yaml)

The source code repository of my doctoral dissertation.


## Compilation with Docker

Using [Docker](https://docs.docker.com/engine/install/),
pull and launch the latest container image.
 
    docker pull --platform=linux/amd64 ghcr.io/nkrusch/dissertation:main
    docker run --name dimage -it --rm ghcr.io/nkrusch/dissertation:main  

### Compile 

(in container) Compile the dissertation by running:

    make full -j N

where `N` is the number of cores. The output is a file `main.pdf`.

### View Document

(on host) In a separate terminal, copy `main.pdf` to the host.

    docker cp dimage:/usr/dissertation/main.pdf .


## Repository Organization

<pre>
    .
    ├─ 🗀 .github/         : Automated workflows
    ├─ 🗀 code/            : Code listings
    ├─ 🗀 fonts/           : Custom fonts
    ├─ 🗀 latex/           : Custom LaTeX
    ├─ 🗀 pdf/             : Static resources (figures, manuscripts)
    ├─ 🗀 pictures/        : TikZ drawings
    ├─ 🗀 references/      : Bib and indices
    ├─ 🗀 text/            : Dissertation content
    ├─ Dockerfile          : Execution environment
    ├─ LICENSE             : License text
    ├─ Makefile            : Build commands
    ├─ args.tex            : Template configuration
    ├─ content.tex         : Dissertation sections
    ├─ main.tex            : The TGS ETD template
    ├─ readme.txt          : Artifact readme
    └─ *                   : Configuration files
</pre>


## Dissertation Formatting Guidelines

* [Augusta University Electronic Theses and Dissertations (ETD)](https://guides.augusta.edu/etd) - by AU Libraries
* [Thesis/Dissertation Preparation Booklet v.2024](https://augustauniversity.app.box.com/s/vj0ygpy8tvyqmsbae8y0qp9767ta7jb9) - AU formatting requirements
* [Dissertation template](https://github.com/aubertc/au_ccs_dissertation_template/) - the standard and alternative template in LaTeX/markdown
* [Preparing Your Manuscript for Submission](https://about.proquest.com/globalassets/proquest/files/pdf-files/preparing-your-manuscript.pdf) - by ProQuest

**Doctoral dissertations from Augusta University**

Query on [proquest.com](https://www.proquest.com):

    DG(Ph.D) AND SCH(1907)
 