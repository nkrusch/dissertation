FROM ghcr.io/xu-cheng/texlive-historic-debian:2024

LABEL org.opencontainers.image.authors="Neea Rusch"
LABEL org.opencontainers.image.title="Dissertation Artifact"
LABEL org.opencontainers.image.description="Docker image of my dissertation"
LABEL org.opencontainers.image.source="https://github.com/nkrusch/dissertation"
LABEL org.opencontainers.image.licenses="Creative Commons Attribution 4.0 International"

# versions
ARG VER_PYMWP="0.5.5"
ARG VER_DAFNY="4.10.0"
ARG VER_COQ="8.20.1"
ARG VER_MATHCOMP="2.4.0"
ARG VER_OCAML="5.1.0"
ARG VER_ELPI="2.5.2"
ARG VER_BH="1.9.0"
ARG VER_DAFNY="4.10.0"

# paths
ARG EXAMPLES="https://github.com/statycc/pymwp/releases/download/$VER_PYMWP/examples.zip"
ARG PROJ="/usr/dissertation"
ARG EX_DIR="$PROJ/examples"
ARG ZIP_EX="$PROJ/examples.zip"
ENV PATH="${PATH}:/root/.dotnet/tools:/root/.opam/$VER_OCAML/bin:/venv/bin:$PROJ/.opam/$VER_OCAML/bin"
ENV DOTNET_ROOT=/root/.dotnet
ENV DEBIAN_FRONTEND=noninteractive
ENV PIP_ROOT_USER_ACTION=ignore
ARG NJOBS=4

# system packages
RUN apt-get update  \
    && apt-get install -qqy \
      bash make unzip wget nano \
      python3-full python3-pip ocaml opam \
      z3 libz3-dev python3-z3 \
      libicu-dev libgmp-dev pkg-config \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p $PROJ
COPY . $PROJ
WORKDIR $PROJ

# install pymwp + examples
ADD --chmod=777 $EXAMPLES $ZIP_EX
RUN unzip $ZIP_EX -d $EX_DIR  \
    && rm -rf $ZIP_EX \
    && pip3 install pymwp==$VER_PYMWP --break-system-packages

# install Dafny
RUN apt-get update -y \
    && apt-get install -y apt-transport-https ca-certificates gnupg \
    && wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh \
    &&  chmod +x ./dotnet-install.sh \
    && ./dotnet-install.sh --version latest --runtime aspnetcore \
    && ./dotnet-install.sh --channel 8.0 \
    && export PATH="/root/.dotnet/:$PATH" \
    && dotnet tool install --global dafny --version $VER_DAFNY \
    && rm -rf dotnet-install.sh

# Rocq & ssreflect
RUN yes | opam init -j "${NJOBS}" --disable-sandboxing --comp $VER_OCAML  \
    && eval $(opam config env) \
    && opam repo add --all-switches --set-default coq-released https://coq.inria.fr/opam/released \
    && opam pin add -n -k version coq $VER_COQ \
    && opam pin add -n -k version coq-mathcomp-ssreflect $VER_MATHCOMP \
    && opam pin add -n -k version coq-elpi $VER_ELPI \
    && opam pin add -n -k version rocq-hierarchy-builder $VER_BH \
    && opam install -y -v -j "${NJOBS}" coq coq-mathcomp-ssreflect ocamlbuild \
    && opam clean -a -c -s --logs

RUN opam config env >> /root/.bashrc \
    && bash -c "source /root/.bashrc"

ENTRYPOINT ["/bin/bash"]
