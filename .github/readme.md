# Dissertation

[![DOI](https://zenodo.org/badge/596231407.svg)](https://doi.org/10.5281/zenodo.17148077)
[![Test](https://github.com/nkrusch/dissertation/actions/workflows/test.yaml/badge.svg)](https://github.com/nkrusch/dissertation/actions/workflows/test.yaml)
[![Latest check](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fapi.github.com%2Frepos%2Fnkrusch%2Fdissertation%2Factions%2Fworkflows%2F194627837%2Fruns%3Fstatus%3Dcompleted%26per_page%3D1&query=%24.workflow_runs%5B0%5D.run_started_at&style=square&label=Latest%20check&color=546E7A)](https://github.com/nkrusch/dissertation/actions/workflows/test.yaml)

This is the source code of my doctoral dissertation _["Applied Implicit Computational Complexity"](https://neea.pl/dissertation) (Rusch, 2025)_.

I am not aware of any other _open source doctoral dissertations_ from Augusta University.
I hope that making this resource public will be useful to future candidates.
The dissertation template is also open source.
This repository uses automated workflows (e.g. to compile and build an artifact container) that may be of interest to the technically advanced candidates.

The dissertation and defense timeline and process is documented [here](https://neea.pl/posts/defense#timeline--progress).

## Formatting Guidelines

The content and formatting requirements[^1] of doctoral dissertations.

* [Dissertation template](https://github.com/aubertc/au_ccs_dissertation_template/) — LaTeX/markdown template for Augusta University graduate dissertations
* [Augusta University Electronic Theses and Dissertations (ETD)](https://guides.augusta.edu/etd) — guide by Augusta University Libraries
* [Thesis/Dissertation Preparation Booklet v.2024](https://augustauniversity.app.box.com/s/vj0ygpy8tvyqmsbae8y0qp9767ta7jb9) — Augusta University formatting requirements
* [Preparing Your Manuscript for Submission](https://about.proquest.com/globalassets/proquest/files/pdf-files/preparing-your-manuscript.pdf) — guide by ProQuest

## Repository Organization

    .
    ├─ 📁 .github          : Automated workflows
    ├─ 📁 code             : Code listings
    ├─ 📁 fonts            : Custom fonts
    ├─ 📁 latex            : LaTeX commands
    ├─ 📁 pdf              : Static files
    ├─ 📁 pictures         : TikZ drawings
    ├─ 📁 references       : Bibs and indices
    ├─ 📁 text             : Dissertation text content
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

Time: 5-10 min &bull; Prerequisites: [LaTeX]

At repository root, compile the dissertation by running:

    make full 

The output is a file `main.pdf`.

### 🐳 With Docker

Time: 10-15 min &bull; Prerequisites: [Docker]

**Setup container**

Pull and launch the latest container (on some machines you may need sudo):

    docker pull --platform=linux/amd64 ghcr.io/nkrusch/dissertation:artifact
    docker run --name dimage -it --rm ghcr.io/nkrusch/dissertation:artifact  

**Compile**

In container, compile the dissertation by running:

    make full

**View Document**

On host, in a separate terminal, copy the compiled document to the host:

    docker cp dimage:/usr/dissertation/main.pdf .

## Dissertations Databases

This dissertation can be found in all the following dissertation databases.

### Open Databases <sup>🗸</sup>

<a href="https://theses.hal.science">
<picture class="theme-aware-logo">
  <source media="(prefers-color-scheme: dark)" srcset="hal-dark.svg">
  <img alt="HAL" src="hal.svg" align="right" width="164">
</picture></a>

[HAL Theses] is an open archive of PhD thesis and habilitation theses.
* [Augusta University theses on HAL](https://theses.hal.science/search/index/?q=augusta+university&language_s=en)

<a href="https://zenodo.org"><img src="zenodo.svg" width="144" alt="Zenodo" align="right" /></a>

[Zenodo] is an archival repository for all kinds of scholarly and research outputs, including theses.
There is also a community for research deposits affiliated with Augusta University.
* [Dissertations affiliated with Augusta University on Zenodo](https://zenodo.org/communities/au/records?q=&f=resource_type%3Apublication%2Binner%3Apublication-dissertation&l=list&p=1&s=10&sort=newest)

<a href="https://scholarlycommons.augusta.edu/home">
<picture class="theme-aware-logo">
  <source media="(prefers-color-scheme: dark)" srcset="au-dark.png">
  <img alt="Augusta University" src="au.png" align="right" width="144">
</picture></a>

[Scholarly Commons] is Augusta University's institutional repository.
All AU dissertations appear in Scholarly Commons.
Scholarly Commons does not require authentication, though some items are restricted.
* [Theses and Dissertations 2020-2029 on Scholarly Commons](https://scholarlycommons.augusta.edu/collections/d04fb25e-8940-44b0-857f-3d96d1ce84b8/search)
* [Computer and Cyber Sciences Theses and Dissertations on Scholarly Commons](https://scholarlycommons.augusta.edu/collections/cdf0b4b7-90b3-4a35-97dd-022b804699b5/search)

### Subscription Database <sup>ಠ_ಠ</sup>

Augusta University uses [ProQuest] as the official publisher and archival database of doctoral dissertations.
However, ProQuest is a subscription-based service.
It minimally requires authentication before a user is allowed to access full length documents.
The database access further depends on the authenticating institution and what collections the institution subscribes to.

> [!WARNING]
> ProQuest functionality and access is strongly restricted to users without a suitable institutional subscription. 

If you have sufficient permissions, this query finds all Augusta University doctoral dissertations in computer science on ProQuest:

    DG(Ph.D) AND SCH(1907) AND DEP(Computer and Cyber Sciences)


## Citation

Please acknowledge references to this dissertation, or its artifact, with the following citation.

```bibtex
@phdthesis{rusch2025,
    title   = {Applied Implicit Computational Complexity},
    author  = {Neea Rusch},
    year    = 2025,
    month   = 9,
    school  = {Augusta University},
    address = {Augusta, Georgia, United States},
    doi     = {10.5281/zenodo.17148449},
    type    = {PhD thesis}
}
 ```

[Docker]: https://docs.docker.com/engine/install/
[HAL Theses]: https://theses.hal.science
[LaTeX]: https://www.latex-project.org/get/
[ProQuest]: https://www.proquest.com
[Scholarly Commons]: https://scholarlycommons.augusta.edu/home
[Zenodo]: https://zenodo.org

[^1]: More precisely, these are _recommendations_.