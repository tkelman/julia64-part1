FROM ubuntu:14.04
MAINTAINER Tony Kelman <tony@kelman.net>

RUN dpkg --add-architecture i386 && apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates \
      git make gcc-multilib g++-multilib gfortran-multilib \
      python curl m4 cmake libssl-dev libssl-dev:i386 && \
    rm -rf /var/lib/apt/lists/* && \
    git clone https://github.com/JuliaLang/julia /home/julia-x86_64 && \
    cd /home/julia-x86_64 && \
    make -j4 -C deps install && \
    make -j4 -C deps distcleanall && \
    echo "# the following line is a hack to avoid rebuilding deps after distclean'ed" >> Make.user && \
    echo 'override DEP_LIBS =' >> Make.user
# distclean should leave in place the installed libraries and headers
WORKDIR /home/julia-x86_64
