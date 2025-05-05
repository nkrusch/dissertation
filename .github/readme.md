# Dissertation

[![Compile](https://github.com/nkrusch/thesis/actions/workflows/compile.yaml/badge.svg)](https://github.com/nkrusch/thesis/actions/workflows/compile.yaml)
[![Status](https://img.shields.io/badge/draft-FF4081?style=flat-square&logo=%20&logoColor=ffffff&label=Status&labelColor=333333)](https://github.com/nkrusch/dissertation/releases)

Repository to host, compile, and share my dissertation.

### Formatting references 

* [Augusta University ETD Guides](https://guides.augusta.edu/etd)
* [AU Dissertation Guide Booklet v.2024](https://augustauniversity.app.box.com/s/vj0ygpy8tvyqmsbae8y0qp9767ta7jb9)
* [LaTeX Dissertation template](https://github.com/aubertc/au_ccs_dissertation_template/)
* [Word template preview](https://augustauniversity.box.com/s/jcdajhkgoeedza3aabeb9x1fer8dv84t)

### 🐳 Docker environment for compilation

The same environment as used by the actions.

Pull latest [texlive-full image](https://github.com/xu-cheng/latex-docker/pkgs/container/texlive-full), then launch the container.
Run the container from the root of this repository.

```
docker pull ghcr.io/xu-cheng/texlive-full:latest 
docker run -v "$(pwd):/dissertation" -it --rm ghcr.io/xu-cheng/texlive-full
```

Inside the container:
```
cd dissertation && make
```
