# vim:filetype=dockerfile
FROM ubuntu:trusty
MAINTAINER Travis CI GmbH <contact+shellcheck-builder@travis-ci.org>

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get install -y software-properties-common && \
    apt-add-repository -y ppa:hvr/ghc && \
    apt-get update -y
RUN apt-get install --no-install-recommends -y \
      cabal-install-1.24 ghc-7.10.3 && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /src

COPY src/shellcheck/ShellCheck.cabal /src/ShellCheck.cabal

WORKDIR /src

ENV PATH /root/.cabal/bin:/opt/ghc/7.10.3/bin:/opt/cabal/1.24/bin:$PATH

RUN mkdir -p /root/.cabal/logs
RUN cabal update && \
    cabal install --only-dependencies

COPY src/shellcheck /src

RUN cabal install /src

CMD ["shellcheck", "-"]
