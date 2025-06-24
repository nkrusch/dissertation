### 🐳 Docker environment for dissertation compilation

**On an amd64/x86 machine** run:

    docker pull ghcr.io/xu-cheng/texlive-full:20250601
    docker run -v "$(pwd):/dissertation" -it --rm ghcr.io/xu-cheng/texlive-full

The commands will:
1. Set up a compatible compilation environment
   (based on [texlive-full](https://github.com/xu-cheng/latex-docker/pkgs/container/texlive-full)).
2. Launch the container -- make sure to launch the container at the sources root folder.

Once insider the container, run the following command to compile the dissertation.

    cd dissertation && make


### 📁 Source code organization

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
