FROM centos:7
MAINTAINER Tony Kelman <tony@kelman.net>

RUN yum update && \
    yum install -y git make patch bzip2 m4 cmake \
      gcc-c++ gcc-gfortran openssl-devel && \
    git clone https://github.com/JuliaLang/julia /home/julia-x86_64 && \
    make -j4 -C /home/julia-x86_64/deps
WORKDIR /home/julia-x86_64
