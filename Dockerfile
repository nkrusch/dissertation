FROM  python:3.11.9-alpine3.20
LABEL org.opencontainers.image.authors="Neea Rusch" \
      org.opencontainers.image.title="Dissertation Companion Image" \
      org.opencontainers.image.source="https://github.com/nkrusch/dissertation" \
      org.opencontainers.image.licenses="MIT"

ARG HOME="/usr/dissertation"
ARG EXAMPLES="https://github.com/statycc/pymwp/releases/download/0.5.4/examples.zip"
ARG DAFNY_URL="https://github.com/dafny-lang/dafny/releases/download/v4.10.0/dafny-4.10.0-x64-ubuntu-20.04.zip"
ARG DAFNY_ARCH="dafny.zip"
ARG DAFNY_PATH="/usr/lib/"

ENV PATH=/root/.local/bin:$PATH:$DAFNY_PATH/dafny

RUN apk update && apk upgrade
RUN apk --no-cache add bash make dotnet6-sdk unzip nano wget libc6-compat
RUN mkdir -p $HOME
COPY . $HOME
WORKDIR $HOME

RUN pip3 install pymwp --no-cache-dir
# download examples

ADD --chmod=777 $DAFNY_URL $HOME/$DAFNY_ARCH
RUN unzip $HOME/$DAFNY_ARCH -d $DAFNY_PATH && rm -rf $HOME/$DAFNY_ARCH

# opam repo add coq-released https://coq.inria.fr/opam/released && opam update
# opam install coq coq-mathcomp-ssreflect
# ADD: Coq 8.20
# Mathematical Components (v2.3.0)

ENTRYPOINT ["/bin/sh"]
