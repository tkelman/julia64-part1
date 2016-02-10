FROM opensuse:42.1
MAINTAINER Tony Kelman <tony@kelman.net>

RUN zypper -n install git ca-certificates-mozilla make which tar \
        curl patch m4 cmake gcc5-c++ gcc5-fortran libopenssl-devel \
        python python-xml glibc-locale ncurses-utils && \
    git clone https://github.com/JuliaLang/julia /home/julia-x86_64 && \
    cd /home/julia-x86_64 && \
    echo 'override MARCH = x86-64' >> Make.user && \
    echo 'override CC = gcc-5' >> Make.user && \
    echo 'override CXX = g++-5' >> Make.user && \
    echo 'override FC = gfortran-5' >> Make.user && \
    DEPS="openblas arpack suitesparse pcre \
          gmp mpfr libgit2 unwind patchelf" && \
    INSTALL="" && DISTCLEAN="" && \
    for dep in $DEPS; do \
      INSTALL="$INSTALL install-$dep" && \
      DISTCLEAN="$DISTCLEAN distclean-$dep"; \
    done && \
    make -j4 -C deps $INSTALL && \
    make -j4 -C deps $DISTCLEAN
# distclean should leave in place the installed libraries and headers
WORKDIR /home/julia-x86_64
