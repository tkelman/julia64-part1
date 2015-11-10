FROM ubuntu:14.04
MAINTAINER Tony Kelman <tony@kelman.net>

RUN dpkg --add-architecture i386 && apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates git \
      build-essential gcc-multilib g++-multilib gfortran-multilib \
      python curl m4 cmake libssl-dev libssl-dev:i386 && \
    rm -rf /var/lib/apt/lists/* && \
    git clone https://github.com/JuliaLang/julia /home/julia-x86_64 && \
    cd /home/julia-x86_64 && \
    DEPS="openblas arpack suitesparse pcre gmp mpfr" && \
    for dep in $DEPS; do \
      make -j2 -C deps install-$dep; \
    done && \
    for dep in $DEPS; do \
      make -C deps distclean-$dep; \
    done
# distclean should leave in place the installed libraries and headers
WORKDIR /home/julia-x86_64
