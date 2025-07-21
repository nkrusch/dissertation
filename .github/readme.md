# Dissertation

[![Compile](https://github.com/nkrusch/thesis/actions/workflows/compile.yaml/badge.svg)](https://github.com/nkrusch/thesis/actions/workflows/compile.yaml)
[![Package](https://github.com/nkrusch/dissertation/actions/workflows/package.yaml/badge.svg)](https://github.com/nkrusch/dissertation/actions/workflows/package.yaml)

This is the source code of my doctoral dissertation,  which I will defend at Augusta University in August 2025.

This readme describes only the technical details, like how to compile the document.
For presentation of the content, see [this webpage](https://neea.pl/posts/dissertation).

I am not aware of any other open source doctoral dissertation from Augusta University.
I am hopeful that making this resource public will be useful to future students, especially those who want to write a dissertation in LaTeX.
Here is the [starter template](https://github.com/aubertc/au_ccs_dissertation_template/) that I have been extending.
This repository is also set up with [automated workflows](https://github.com/nkrusch/dissertation/actions) 
that may be of interest to the more technically advanced users.

## Repository Organization

<pre>
.
├─ 🗀 .github/         : Automated workflows
├─ 🗀 code/            : Code listings
├─ 🗀 fonts/           : Custom fonts
├─ 🗀 latex/           : LaTeX commands
├─ 🗀 pdf/             : Static assets (figures, manuscripts)
├─ 🗀 pictures/        : TikZ drawings
├─ 🗀 references/      : Bibs and indices
├─ 🗀 text/            : Dissertation content
├─ args.tex            : Template configuration
├─ content.tex         : Dissertation sections
├─ main.tex            : The TGS ETD template
├─ readme.txt          : Artifact readme
└─ *                   : Configuration files, etc.
</pre>

## Dissertation Formatting Guidelines

* [Augusta University Electronic Theses and Dissertations (ETD)](https://guides.augusta.edu/etd) - by AU Libraries
* [Thesis/Dissertation Preparation Booklet v.2024](https://augustauniversity.app.box.com/s/vj0ygpy8tvyqmsbae8y0qp9767ta7jb9) - AU formatting requirements
* [Dissertation template](https://github.com/aubertc/au_ccs_dissertation_template/) - LaTeX/markdown template for AU TGS dissertations
* [Preparing Your Manuscript for Submission](https://about.proquest.com/globalassets/proquest/files/pdf-files/preparing-your-manuscript.pdf) - by ProQuest

**View doctoral dissertations from Augusta University**

Query on [proquest.com](https://www.proquest.com):

    DG(Ph.D) AND SCH(1907)

To limit to computer science:

    DG(Ph.D) AND SCH(1907) AND DEP(Computer and Cyber Sciences)

## Compilation

### Compile natively on host

Prerequisites: [LaTeX](https://www.latex-project.org/get/) 

Compile the dissertation by running, at the repository root:
    
        make full -j N
    
where `N` is the number of cores.
Depending on the machine, it takes ~5-10 minutes.
The output is a file `main.pdf`.


### Compile with Docker

Using [Docker](https://docs.docker.com/engine/install/),
pull and launch the latest container image.
 
    docker pull --platform=linux/amd64 ghcr.io/nkrusch/dissertation:main
    docker run --name dimage -it --rm ghcr.io/nkrusch/dissertation:main  

1. **Compile** 

    [in container] Compile the dissertation by running:
    
        make full

2. **View Document**

    [on host] In a separate terminal, copy `main.pdf` to the host.
    
        docker cp dimage:/usr/dissertation/main.pdf .

