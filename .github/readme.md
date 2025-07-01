# Dissertation

[![Compile](https://github.com/nkrusch/thesis/actions/workflows/compile.yaml/badge.svg)](https://github.com/nkrusch/thesis/actions/workflows/compile.yaml)

Repository to host, compile, and share my dissertation.

### Formatting guides 
    
* [Augusta University ETD Guides](https://guides.augusta.edu/etd)
* [AU Dissertation Guide Booklet v.2024](https://augustauniversity.app.box.com/s/vj0ygpy8tvyqmsbae8y0qp9767ta7jb9)
* [Dissertation template](https://github.com/aubertc/au_ccs_dissertation_template/) (LaTeX/markdown)
* [Preparing Your Manuscript for Submission (ProQuest)](https://about.proquest.com/globalassets/proquest/files/pdf-files/preparing-your-manuscript.pdf)

### Repository Organization

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

### Compilation with Docker

From the repository root, pull the latest [texlive-full][texlive] image, then launch the container.

    export DOCKER_DEFAULT_PLATFORM=linux/amd64
    docker pull ghcr.io/xu-cheng/texlive-full:latest 
    docker run -v "$(pwd):/dissertation" -it --rm ghcr.io/xu-cheng/texlive-full

Insider the container, compile the dissertation by running:

    cd dissertation && make

The output should be a `main.pdf` at the repository root.

[texlive]: https://github.com/xu-cheng/latex-docker/pkgs/container/texlive-full