FROM ubuntu:14.04
MAINTAINER Tony Kelman <tony@kelman.net>

RUN dpkg --add-architecture i386 && apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates git \
      build-essential gcc-multilib g++-multilib gfortran-multilib \
      python curl m4 cmake libssl-dev libssl-dev:i386 && \
    rm -rf /var/lib/apt/lists/* && \
    git clone https://github.com/JuliaLang/julia /home/julia-x86_64 && \
    DEPS="openblas arpack suitesparse fftw" && \
    for dep in $DEPS; do \
      cd /home/julia-x86_64 && make -j2 -C deps install-$dep; \
    done && \
    for dep in $DEPS; do \
      cd /home/julia-x86_64 && make -C deps distclean-$dep; \
    done
# distclean should leave in place the installed libraries and headers
