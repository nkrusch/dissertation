FROM ghcr.io/xu-cheng/texlive-historic-debian:2024

LABEL org.opencontainers.image.authors="Neea Rusch"
LABEL org.opencontainers.image.title="Dissertation Artifact"
LABEL org.opencontainers.image.description="Docker Image of Dissertation"
LABEL org.opencontainers.image.source="https://github.com/nkrusch/dissertation"
LABEL org.opencontainers.image.licenses="Creative Commons Attribution 4.0 International"

# versions
ENV VER_PYMWP="0.5.5"
ENV VER_DAFNY="4.10.0"
ENV VER_COQ="8.20.1"
ENV VER_MATHCOMP="2.4.0"
ENV VER_OCAML="5.1.0"
ENV VER_ELPI="2.5.2"

# paths
ARG HOME="/usr/dissertation"
ARG EX_DIR="$HOME/examples"
ARG DAFNY_PATH="/usr/lib/"
ENV VENV=/venv
ENV PATH=/root/.local/bin:$DAFNY_PATH/dafny:/$VENV/bin:$HOME/.opam/$VER_OCAML/bin/:$PATH
ARG ZIP_EX="$HOME/examples.zip"
ARG ZIP_DAFNY="$HOME/dafny.zip"
ARG MS_CERT="packages-microsoft-prod.deb"

# downloads
ARG EXAMPLES="https://github.com/statycc/pymwp/releases/download/$VER_PYMWP/examples.zip"
ARG DAFNY_URL="https://github.com/dafny-lang/dafny/releases/download/v$VER_DAFNY/dafny-$VER_DAFNY-x64-ubuntu-20.04.zip"

# ENV settings
ENV DEBIAN_FRONTEND=noninteractive
ENV PIP_ROOT_USER_ACTION=ignore
ARG NJOBS=4

# Debian: need for Dafny
RUN apt update \
    && apt-get install -y wget \
    && wget https://packages.microsoft.com/config/debian/12/$MS_CERT -O $MS_CERT \
    && dpkg -i $MS_CERT \
    && rm $MS_CERT

# necessary pre-packages
RUN apt update  \
    && apt-get install -qqy \
      bash make unzip python3-full python3-pip ocaml opam \
      dotnet-host dotnet-sdk-8.0 libgmp-dev pkg-config \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p $HOME
COPY . $HOME
WORKDIR $HOME

# install pymwp and examples
ADD --chmod=777 $EXAMPLES $ZIP_EX
RUN unzip $ZIP_EX -d $EX_DIR  \
    && rm -rf $ZIP_EX \
    && python3 -m venv $VENV  \
    && $VENV/bin/pip install pymwp==$VER_PYMWP

# Dafny
ADD --chmod=777 $DAFNY_URL $ZIP_DAFNY
RUN unzip $ZIP_DAFNY -d $DAFNY_PATH  \
    && rm -rf $ZIP_DAFNY

# Rocq & ssreflect
RUN yes | opam init -j "${NJOBS}" --disable-sandboxing --comp $VER_OCAML  \
    && eval $(opam config env) \
    && opam repo add --all-switches --set-default coq-released https://coq.inria.fr/opam/released \
    && opam pin add -n -k version coq $VER_COQ \
    && opam pin add -n -k version coq-mathcomp-ssreflect $VER_MATHCOMP \
    && opam pin add -n -k version coq-elpi $VER_ELPI \
    && opam install -y -v -j "${NJOBS}" coq coq-mathcomp-ssreflect ocamlbuild \
    && opam clean -a -c -s --logs

RUN opam config env >> /root/.bashrc \
    && bash -c "source /root/.bashrc"

ENTRYPOINT ["/bin/bash"]
