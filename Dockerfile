FROM centos:7
MAINTAINER Tony Kelman <tony@kelman.net>

RUN yum update -y && \
    yum install -y git make patch which bzip2 m4 \
      cmake gcc-c++ gcc-gfortran openssl-devel && \
    git clone https://github.com/JuliaLang/julia /home/julia-x86_64 && \
    cd /home/julia-x86_64 && \
    DEPS="openblas arpack suitesparse pcre gmp mpfr libgit2" && \
    INSTALL="" && DISTCLEAN="" && \
    for dep in $DEPS; do \
      INSTALL="$INSTALL install-$dep" && \
      DISTCLEAN="$DISTCLEAN distclean-$dep"; \
    done && \
    make -j4 -C deps $INSTALL && \
    make -j4 -C deps $DISTCLEAN
# distclean should leave in place the installed libraries and headers
WORKDIR /home/julia-x86_64
