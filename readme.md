# Dissertation

[![Compile](https://github.com/nkrusch/thesis/actions/workflows/compile.yaml/badge.svg)](https://github.com/nkrusch/thesis/actions/workflows/compile.yaml)
[![Status](https://img.shields.io/badge/review-FF5722?style=flat-square&logo=%20&logoColor=ffffff&label=Status&labelColor=333333)](https://github.com/nkrusch/dissertation/releases)

Repository to host, compile, and share my dissertation.

### Formatting references 

* [Augusta University ETD Guides](https://guides.augusta.edu/etd)
* [AU Dissertation Guide Booklet v.2024](https://augustauniversity.app.box.com/s/vj0ygpy8tvyqmsbae8y0qp9767ta7jb9)
* [Dissertation template](https://github.com/aubertc/au_ccs_dissertation_template/) (LaTeX/markdown)
* [Preparing Your Manuscript for Submission (ProQuest)](https://about.proquest.com/globalassets/proquest/files/pdf-files/preparing-your-manuscript.pdf)

### 📁 Repository Organization

```
  .
  ├─ 🗀 .github/         : Automated workflows and readmes
  ├─ 🗀 code/            : All code listings 
  ├─ 🗀 fonts/           : Custom fonts
  ├─ 🗀 latex/           : Custom LaTeX
  ├─ 🗀 pdf/             : Static resources (figures, manuscripts)
  ├─ 🗀 pictures/        : TikZ drawings 
  ├─ 🗀 references/      : Bib and indices
  ├─ 🗀 text/            : Dissertation content
  ├─ args.tex            : Template configuration
  ├─ content.tex         : Dissertation sections
  ├─ LICENSE             : CC Attribution 4.0 International 
  ├─ main.tex            : TGS ETD template 
  ├─ Makefile            : Build commands
  └─ *                   : Configuration files 
```

### 🐳 Docker environment for compilation

Pull latest [texlive-full image](https://github.com/xu-cheng/latex-docker/pkgs/container/texlive-full), then launch the container.
Run the container from the root of this repository.

```
docker pull ghcr.io/xu-cheng/texlive-full:latest 
docker run -v "$(pwd):/dissertation" -it --rm ghcr.io/xu-cheng/texlive-full
```

Insider the container run `cd dissertation && make` to compile the dissertation.
