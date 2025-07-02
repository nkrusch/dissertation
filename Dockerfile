FROM ghcr.io/xu-cheng/texlive-debian:latest
LABEL org.opencontainers.image.authors="Neea Rusch" \
      org.opencontainers.image.title="Dissertation Companion Artifact Image" \
      org.opencontainers.image.source="https://github.com/nkrusch/dissertation" \
      org.opencontainers.image.licenses="Creative Commons Attribution 4.0 International"

# paths
ARG HOME="/usr/dissertation"
ARG EX_DIR="$HOME/examples"
ARG DAFNY_PATH="/usr/lib/"

# versions
ENV VER_PYMWP="0.5.4"
ENV VER_DAFNY="4.10.0"
ENV VER_COQ="8.20.1"
ENV VER_MATHCOMP="2.4.0"
ENV VER_OCAML="5.1.0"

# downloads
ARG EXAMPLES="https://github.com/statycc/pymwp/releases/download/$VER_PYMWP/examples.zip"
ARG DAFNY_URL="https://github.com/dafny-lang/dafny/releases/download/v$VER_DAFNY/dafny-$VER_DAFNY-x64-ubuntu-20.04.zip"
ARG DAFNY_ARCH="dafny.zip"
ARG MS_CERT="packages-microsoft-prod.deb"
ARG README=".github/artifact.txt"
ARG JOBS=4

# ENV settings
ENV DEBIAN_FRONTEND=noninteractive
ENV PIP_ROOT_USER_ACTION=ignore
ENV VIRTUAL_ENV=/venv
ENV PATH=/root/.local/bin:$DAFNY_PATH/dafny:/$VIRTUAL_ENV/bin:$PATH

# Debian: need for Dafny
RUN apt update \
    && apt-get install -y wget \
    && wget https://packages.microsoft.com/config/debian/12/$MS_CERT -O $MS_CERT \
    && dpkg -i $MS_CERT \
    && rm $MS_CERT

# necessary pre-packages
RUN apt update  \
    && apt-get install -qqy \
      bash make unzip nano python3-full python3-pip \
      dotnet-host ocaml opam libgmp-dev pkg-config \
    && apt-get install -qqy dotnet-sdk-8.0  \
    && apt-get upgrade \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p $HOME
COPY . $HOME
COPY $README $HOME/readme.txt
WORKDIR $HOME

# install pymwp and examples
ADD --chmod=777 $EXAMPLES $HOME/examples.zip
RUN rm -rf $EX_DIR  \
    && unzip $HOME/examples.zip -d $EX_DIR  \
    && rm -rf $HOME/examples.zip \
    && python3 -m venv $VIRTUAL_ENV  \
    && $VIRTUAL_ENV/bin/pip install pymwp==$VER_PYMWP

# Dafny
ADD --chmod=777 $DAFNY_URL $HOME/$DAFNY_ARCH
RUN unzip $HOME/$DAFNY_ARCH -d $DAFNY_PATH  \
    && rm -rf $HOME/$DAFNY_ARCH

# Rocq & ssreflect
RUN yes | opam init --disable-sandboxing --comp $VER_OCAML  \
    && eval $(opam config env) \
    && opam repo add --all-switches --set-default coq-released https://coq.inria.fr/opam/released \
    && opam pin add -n -k version coq $VER_COQ \
    && opam install -y -v -j $JOBS coq coq-mathcomp-ssreflect.$VER_MATHCOMP ocamlbuild \
    && opam clean -a -c -s --logs

RUN opam config env >> /root/.bashrc \
    && bash -c "source /root/.bashrc"

ENTRYPOINT /bin/bash
