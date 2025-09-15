# Dissertation

[![Compile](https://github.com/nkrusch/thesis/actions/workflows/compile.yaml/badge.svg)](https://github.com/nkrusch/thesis/actions/workflows/compile.yaml)
[![Package](https://github.com/nkrusch/dissertation/actions/workflows/artifact.yaml/badge.svg)](https://github.com/nkrusch/dissertation/actions/workflows/artifact.yaml)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.15288398.svg)](https://doi.org/10.5281/zenodo.15288398)

This is the source code of my doctoral dissertation, _["Applied Implicit Computational Complexity"](https://neea.pl/dissertation) (Rusch, 2025)_.

I am not aware of any other _open source doctoral dissertation_ from Augusta University.
I hope that making this resource public will be useful to future candidates.
The LaTeX template is also open source.
This repository uses automated workflows (e.g. to compile and build an artifact container) that may be of interest to the technically advanced candidates.

For defense timeline and process, see [this page](https://neea.pl/posts/defense).

## Formatting Guidelines

The content and formatting requirements of doctoral dissertations.

* [Dissertation template](https://github.com/aubertc/au_ccs_dissertation_template/) — LaTeX/markdown template for AU TGS dissertations
* [Augusta University Electronic Theses and Dissertations (ETD)](https://guides.augusta.edu/etd) — guide by AU Libraries
* [Thesis/Dissertation Preparation Booklet v.2024](https://augustauniversity.app.box.com/s/vj0ygpy8tvyqmsbae8y0qp9767ta7jb9) — AU formatting requirements
* [Preparing Your Manuscript for Submission](https://about.proquest.com/globalassets/proquest/files/pdf-files/preparing-your-manuscript.pdf) — guide by ProQuest[^1]
  
[^1]: The ProQuest guide is sometimes different from AU guide (e.g., for margins); then AU guidelines override ProQuest.

## Repository Organization
 
    .
    ├─ 📁 .github/         : Automated workflows
    ├─ 📁 code/            : Code listings
    ├─ 📁 fonts/           : Custom fonts
    ├─ 📁 latex/           : LaTeX commands
    ├─ 📁 pdf/             : Static files
    ├─ 📁 pictures/        : TikZ drawings
    ├─ 📁 references/      : Bibs and indices
    ├─ 📁 text/            : Dissertation text content
    ├─ args.tex            : Template configuration
    ├─ content.tex         : Chapter organization
    ├─ main.tex            : The base template
    ├─ readme.txt          : Artifact readme
    └─ *                   : Other configuration files, license, etc.

The compilation follows roughly this dependency schema.
 
               ┌──── args.tex ◂──────── latex/*      
    main.tex ◂─┼──── content.tex ◂──┬── text ◂────────┬── pdf/*  ◂─── pictures/*      
               └──── fonts/*        └── references/*  └── code/*

## Dissertation Compilation

### 🖥️ Native Host

Time: 5-10 min &bull; Prerequisites: [LaTeX](https://www.latex-project.org/get/) 

[at repository root] Compile the dissertation by running:
    
    make full 

The output is a file `main.pdf`.

### 🐳 With Docker

Time: 10-15 min &bull; Prerequisites: [Docker](https://docs.docker.com/engine/install/)

1. **Setup container**
 
   Pull and launch the latest container (on some machines you may need sudo):
 
        docker pull --platform=linux/amd64 ghcr.io/nkrusch/dissertation:artifact
        docker run --name dimage -it --rm ghcr.io/nkrusch/dissertation:artifact  

2. **Compile** 

    [in container] Compile the dissertation by running:
    
        make full

3. **View Document**

    [on host] In a separate terminal, copy the compiled document to the host:
    
        docker cp dimage:/usr/dissertation/main.pdf .

## Dissertations Database

Dissertations completed at Augusta University are archived on [ProQuest](https://www.proquest.com).

Accessing the full database requires authentication.

* Query to find all AU doctoral dissertations:

        DG(Ph.D) AND SCH(1907)

* Query to find all AU doctoral dissertations in computer science:

        DG(Ph.D) AND SCH(1907) AND DEP(Computer and Cyber Sciences)


