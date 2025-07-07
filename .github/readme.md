# Dissertation

[![Compile](https://github.com/nkrusch/thesis/actions/workflows/compile.yaml/badge.svg)](https://github.com/nkrusch/thesis/actions/workflows/compile.yaml)
[![Package](https://github.com/nkrusch/dissertation/actions/workflows/package.yaml/badge.svg)](https://github.com/nkrusch/dissertation/actions/workflows/package.yaml)

Repository to host, compile, and share my dissertation.

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

## Dissertation Formatting Guidelines

* [Augusta University ETD Guides](https://guides.augusta.edu/etd)
* [AU Dissertation Guide Booklet v.2024](https://augustauniversity.app.box.com/s/vj0ygpy8tvyqmsbae8y0qp9767ta7jb9)
* [Dissertation template](https://github.com/aubertc/au_ccs_dissertation_template/) (LaTeX/markdown)
* [Preparing Your Manuscript for Submission (ProQuest)](https://about.proquest.com/globalassets/proquest/files/pdf-files/preparing-your-manuscript.pdf)

List of doctoral dissertations from Augusta University

* Go to: https://www.proquest.com
* Query: `DG(Ph.D) AND SCH(1907)`
 