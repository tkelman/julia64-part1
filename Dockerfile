FROM opensuse:42.1
MAINTAINER Tony Kelman <tony@kelman.net>

RUN zypper -n install git ca-certificates-mozilla make which tar curl \
        python patch m4 cmake gcc5-c++ gcc5-fortran libopenssl-devel \
        glibc-locale ncurses-utils && \
    git clone https://github.com/JuliaLang/julia /home/julia-x86_64 && \
    cd /home/julia-x86_64 && \
    echo 'override MARCH = x86-64' >> Make.user && \
    echo 'override CC = gcc-5' >> Make.user && \
    echo 'override CXX = g++-5' >> Make.user && \
    echo 'override FC = gfortran-5' >> Make.user && \
    make -j4 -C deps install && \
    make -j4 -C deps distcleanall && \
    echo "# the following line is a hack to avoid rebuilding deps after distclean'ed" >> Make.user
    echo 'override DEP_LIBS =' >> Make.user
# distclean should leave in place the installed libraries and headers
WORKDIR /home/julia-x86_64
