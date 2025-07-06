# Dissertation

[![Compile](https://github.com/nkrusch/thesis/actions/workflows/compile.yaml/badge.svg)](https://github.com/nkrusch/thesis/actions/workflows/compile.yaml)
[![Package](https://github.com/nkrusch/dissertation/actions/workflows/package.yaml/badge.svg)](https://github.com/nkrusch/dissertation/actions/workflows/package.yaml)

Repository to host, compile, and share my dissertation.

## Repository Organization

    .
    ├─ 🗀 .github/         : Automated workflows
    ├─ 🗀 code/            : Code listings
    ├─ 🗀 fonts/           : Custom fonts
    ├─ 🗀 latex/           : Custom LaTeX
    ├─ 🗀 pdf/             : Static resources (figures, manuscripts)
    ├─ 🗀 pictures/        : TikZ drawings
    ├─ 🗀 references/      : Bib and indices
    ├─ 🗀 text/            : Dissertation content
    ├─ args.tex            : Template configuration
    ├─ content.tex         : Dissertation sections
    ├─ Dockerfile          : Execution environment
    ├─ LICENSE             : License text
    ├─ main.tex            : The TGS ETD template
    ├─ Makefile            : Build commands
    └─ *                   : Configuration files

## Compilation with Docker

Using [Docker](https://docs.docker.com/engine/install/),
pull and launch the latest container image.
 
    docker pull --platform=linux/amd64 ghcr.io/nkrusch/dissertation:main
    docker run -it --rm ghcr.io/nkrusch/dissertation:main

**1️⃣ Compile.**
Insider the container, compile the dissertation by running:

    make -j N

where `N` is the number of available cores.
The command generates a file `main.pdf` inside the container.

**2️⃣ View the document.**
Run the following steps in a separate terminal, outside the container.

1. Run `docker ps` to find the `container_id`.
2. Replace `container_id` with the appropriate value. 


    docker cp container_id:/usr/dissertation/main.pdf ~/Desktop/main.pdf

The command to copies `main.pdf` to the Desktop of the host.

## Formatting Guidelines

* [Augusta University ETD Guides](https://guides.augusta.edu/etd)
* [AU Dissertation Guide Booklet v.2024](https://augustauniversity.app.box.com/s/vj0ygpy8tvyqmsbae8y0qp9767ta7jb9)
* [Dissertation template](https://github.com/aubertc/au_ccs_dissertation_template/) (LaTeX/markdown)
* [Preparing Your Manuscript for Submission (ProQuest)](https://about.proquest.com/globalassets/proquest/files/pdf-files/preparing-your-manuscript.pdf)
