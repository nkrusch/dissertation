# Dissertation


[![Compile](https://github.com/nkrusch/thesis/actions/workflows/compile.yaml/badge.svg)](https://github.com/nkrusch/thesis/actions/workflows/compile.yaml)
![Static Badge](https://img.shields.io/badge/draft-FF4081?style=flat-square&logo=%20&logoColor=ffffff&label=Status&labelColor=333333)

Repository to host, automatically compile, and share my dissertation.

### References

* [Augusta University ETD Guides](https://guides.augusta.edu/etd)
* [AU Dissertation Guide Booklet v.2024](https://augustauniversity.app.box.com/s/vj0ygpy8tvyqmsbae8y0qp9767ta7jb9)
* [LaTeX template link](https://github.com/aubertc/au_ccs_dissertation_template/)
* [Word template preview](https://augustauniversity.box.com/s/jcdajhkgoeedza3aabeb9x1fer8dv84t)

### Docker Environment for compilation

This is the same as used by the workflow.
Run the container from the root of this repository.

```
# get latest https://github.com/xu-cheng/latex-docker/pkgs/container/texlive-full
docker pull ghcr.io/xu-cheng/texlive-full:latest 
docker run -v "$(pwd):/dissertation" -it --rm ghcr.io/xu-cheng/texlive-full
# inside the container:
cd dissertation && make
```

To install new packages in the container:

```
apk update && apk add
# install whatever package
apk add nano 
```