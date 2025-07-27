# Dissertation

[![Compile](https://github.com/nkrusch/thesis/actions/workflows/compile.yaml/badge.svg)](https://github.com/nkrusch/thesis/actions/workflows/compile.yaml)
[![Package](https://github.com/nkrusch/dissertation/actions/workflows/package.yaml/badge.svg)](https://github.com/nkrusch/dissertation/actions/workflows/package.yaml)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.15288398.svg)](https://doi.org/10.5281/zenodo.15288398)

This is the source code of my doctoral dissertation,  which I will defend at Augusta University in August 2025.

This readme describes only the technical details, like how to compile the document.
See [this webpage](https://neea.pl/posts/dissertation) for presentation of the content.

I am not aware of any other open source doctoral dissertations from Augusta University.
I am hopeful that making this resource public will be useful to future students, especially those who want to write a dissertation in LaTeX.
Here is the [starter template](https://github.com/aubertc/au_ccs_dissertation_template/) that I have been extending.
This repository is also set up with automated workflows that may be of interest to technically advanced users.

## Formatting Guidelines

The content and formatting requirements are documented in these resources.

* [Augusta University Electronic Theses and Dissertations (ETD)](https://guides.augusta.edu/etd) — guide by AU Libraries
* [Thesis/Dissertation Preparation Booklet v.2024](https://augustauniversity.app.box.com/s/vj0ygpy8tvyqmsbae8y0qp9767ta7jb9) — AU formatting requirements
* [Dissertation template](https://github.com/aubertc/au_ccs_dissertation_template/) — LaTeX/markdown template for AU TGS dissertations
* [Preparing Your Manuscript for Submission](https://about.proquest.com/globalassets/proquest/files/pdf-files/preparing-your-manuscript.pdf) — guide by ProQuest

## Repository Organization
 
    .
    ├─ 🗀 .github/         : Automated workflows
    ├─ 🗀 code/            : Code listings
    ├─ 🗀 fonts/           : Custom fonts
    ├─ 🗀 latex/           : LaTeX commands
    ├─ 🗀 pdf/             : Static files
    ├─ 🗀 pictures/        : TikZ drawings
    ├─ 🗀 references/      : Bibs and indices
    ├─ 🗀 text/            : Dissertation text content
    ├─ args.tex            : Template configuration
    ├─ content.tex         : Chapter organization
    ├─ main.tex            : The base template
    ├─ readme.txt          : Artifact readme
    └─ *                   : Other configuration files, license, etc.

The document follows roughly this dependency schema.
 
               ┌──── args.tex ◂────── latex/*      
    main.tex ◂─┼──── content.tex ◂─┬─ text ◂───────┬─ pdf/*  ◂─── pictures/*      
               └──── fonts/*       └─ references/* └─ code/*
                    

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
Some dissertations are embargoed, such that the full text is not available.
The dissertation details specify the end date of the embargo.

* Query to find all AU doctoral dissertations:

        DG(Ph.D) AND SCH(1907)

* Query to find all AU doctoral dissertations in computer science:

        DG(Ph.D) AND SCH(1907) AND DEP(Computer and Cyber Sciences)


