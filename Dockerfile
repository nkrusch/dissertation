# --------------------------------------------------
# docker build --platform linux/amd64 . -t rdiss
# docker run -it --rm rdiss
# --------------------------------------------------
FROM ghcr.io/xu-cheng/texlive-debian:latest
LABEL org.opencontainers.image.authors="Neea Rusch" \
      org.opencontainers.image.title="Dissertation Companion Artifact Image" \
      org.opencontainers.image.source="https://github.com/nkrusch/dissertation" \
      org.opencontainers.image.licenses="Creative Commons Attribution 4.0 International"

ARG HOME="/usr/dissertation"
ARG EX_DIR="$HOME/examples"
ARG EXAMPLES="https://github.com/statycc/pymwp/releases/download/0.5.4/examples.zip"
ARG DAFNY_URL="https://github.com/dafny-lang/dafny/releases/download/v4.10.0/dafny-4.10.0-x64-ubuntu-20.04.zip"
ARG DAFNY_ARCH="dafny.zip"
ARG DAFNY_PATH="/usr/lib/"
ARG MS_CERT="packages-microsoft-prod.deb"

ENV DEBIAN_FRONTEND=noninteractive
ENV VIRTUAL_ENV=/venv
ENV PATH=/root/.local/bin:$DAFNY_PATH/dafny:/$VIRTUAL_ENV/bin:$PATH

# @Debian: need for Dafny
RUN apt update \
    && apt-get install -y wget \
    && wget https://packages.microsoft.com/config/debian/12/$MS_CERT -O $MS_CERT \
    && dpkg -i $MS_CERT \
    && rm $MS_CERT

RUN apt update  \
    && apt-get install -y bash make unzip nano python3-full python3-pip dotnet-host opam libgmp-dev pkg-config
RUN apt update  \
    && apt-get install -y dotnet-sdk-8.0  \
    && apt-get upgrade
RUN mkdir -p $HOME
COPY . $HOME
WORKDIR $HOME

# install pymwp and examples
ADD --chmod=777 $EXAMPLES $HOME/examples.zip
RUN rm -rf $EX_DIR  \
    && unzip $HOME/examples.zip -d $EX_DIR  \
    && rm -rf $HOME/examples.zip
RUN python3 -m venv $VIRTUAL_ENV  \
    && $VIRTUAL_ENV/bin/pip install pymwp

# Dafny
ADD --chmod=777 $DAFNY_URL $HOME/$DAFNY_ARCH
RUN unzip $HOME/$DAFNY_ARCH -d $DAFNY_PATH  \
    && rm -rf $HOME/$DAFNY_ARCH

# Rocq & ssreflect
RUN opam init -y --shell-setup --disable-sandboxing  && opam switch create 5.2.1 && eval $(opam env --switch=5.2.1)
RUN opam repo add coq-released https://coq.inria.fr/opam/released
RUN opam update && opam install -y coq.8.20.1 coq-mathcomp-ssreflect.2.3.0

ENTRYPOINT ["/bin/sh"]
