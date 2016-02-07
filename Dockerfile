FROM centos:6
MAINTAINER Tony Kelman <tony@kelman.net>

RUN yum update -y && \
    yum install -y git make patch which tar bzip2 xz m4 \
      cmake gcc-c++ gcc-gfortran openssl-devel && \
    git clone https://github.com/JuliaLang/julia -b release-0.4 /home/julia-x86_64 && \
    make -j4 -C /home/julia-x86_64/deps
WORKDIR /home/julia-x86_64
