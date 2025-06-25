# python:3.11.9-alpine3.20
#
# export DOCKER_DEFAULT_PLATFORM=linux/amd64
# docker build -t rdiss .
# docker run -v "$(pwd):/dissertation" -it --rm rdiss
#
# docker build --platform linux/amd64 . -t rdiss
# docker run -it --rm rdiss
FROM ghcr.io/xu-cheng/texlive-full:latest
LABEL org.opencontainers.image.authors="Neea Rusch" \
      org.opencontainers.image.title="Dissertation Companion Artifact Image" \
      org.opencontainers.image.source="https://github.com/nkrusch/dissertation" \
      org.opencontainers.image.licenses="Creative Commons Attribution 4.0 International"

ARG HOME="/dissertation"
ARG EX_DIR="$HOME/examples"
ARG EXAMPLES="https://github.com/statycc/pymwp/releases/download/0.5.4/examples.zip"
ARG DAFNY_URL="https://github.com/dafny-lang/dafny/releases/download/v4.10.0/dafny-4.10.0-x64-ubuntu-20.04.zip"
ARG DAFNY_ARCH="dafny.zip"
ARG DAFNY_PATH="/usr/lib/"

ENV PATH=/root/.local/bin:$PATH:$DAFNY_PATH/dafny

RUN apk update && apk upgrade \
    apk --no-cache add bash make dotnet6-sdk unzip nano wget libc6-compat opam
RUN mkdir -p $HOME
COPY . $HOME
WORKDIR $HOME

# install pymwp and preload examples
ADD --chmod=777 $EXAMPLES $HOME/examples.zip
RUN pip3 install pymwp --no-cache-dir \
    && rm -rf $EX_DIR \
    && unzip $HOME/examples.zip -d $EX_DIR \
    && rm -rf $HOME/examples.zip

ADD --chmod=777 $DAFNY_URL $HOME/$DAFNY_ARCH
RUN unzip $HOME/$DAFNY_ARCH -d $DAFNY_PATH \
    && rm -rf $HOME/$DAFNY_ARCH

# cc (c compiler not found)
RUN opam -y init
RUN opam switch create ocaml-base-compiler 5.2.1
RUN test -r /root/.opam/opam-init/init.sh && . /root/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
RUN opam repo add coq-released https://coq.inria.fr/opam/released  \
RUN opam update
RUN opam install -y coq.8.20.1 coq-mathcomp-ssreflect.2.3.0

ENTRYPOINT ["/bin/sh"]
