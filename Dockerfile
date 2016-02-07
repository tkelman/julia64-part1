FROM centos:7
MAINTAINER Tony Kelman <tony@kelman.net>

RUN yum update -y && \
    yum install -y git make patch which bzip2 m4 \
      cmake gcc-c++ gcc-gfortran openssl-devel && \
    git clone https://github.com/JuliaLang/julia /home/julia-x86_64 && \
    cd /home/julia-x86_64 && \
    make -j4 -C deps install && \
    make -j4 -C deps distcleanall && \
    echo "# the following line is a hack to avoid rebuilding deps after distclean'ed" >> Make.user && \
    echo 'override DEP_LIBS =' >> Make.user
# distclean should leave in place the installed libraries and headers
WORKDIR /home/julia-x86_64
