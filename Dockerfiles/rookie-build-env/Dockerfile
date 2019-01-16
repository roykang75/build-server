# 1. ubuntu 16.04 & build utils install

FROM    ubuntu:16.04

MAINTAINER roykang@dogtra.com

RUN    ln -sf /bin/bash /bin/sh

RUN    apt-get -y update

#JAVA INSTALL
RUN    apt-get -y install software-properties-common
RUN    add-apt-repository -y ppa:openjdk-r/ppa
RUN    apt-get update
#RUN    apt-get -y install openjdk-8-jdk
RUN    apt-get install -y openjdk-7-jdk 

#BUILD UTIL INSTALL
RUN    apt-get -y install gnupg
RUN    apt-get -y install flex
RUN    apt-get -y install bison
RUN    apt-get -y install gperf
RUN    apt-get -y install zip
RUN    apt-get -y install curl
RUN    apt-get -y install zlib1g-dev
RUN    apt-get -y install gawk
RUN    apt-get -y install build-essential
RUN    apt-get -y install libc6-dev-i386
RUN    apt-get -y install gcc-multilib
RUN    apt-get -y install g++-multilib
RUN    apt-get -y install lib32ncurses5-dev
RUN    apt-get -y install nfs-common
RUN    apt-get -y install bc
RUN    apt-get -y install libxml2-utils
RUN    apt-get -y install u-boot-tools
RUN    apt-get -y install python
RUN    apt-get -y install make
RUN    apt-get -y install ccache
RUN    apt-get -y install lib32z-dev
RUN    apt-get -y install libgl1-mesa-dev

#CREATE USER
RUN    useradd roy

#COPY TOOLCHAIN

#ETC UTIL INSTALL
RUN    curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo
RUN    chmod a+x /usr/local/bin/repo
RUN    apt-get -y install git
RUN    apt-get -y install vim
RUN    echo "root:Docker!" | chpasswd

#COPY BUILD SCRIPT
COPY    run_build.sh /work/src/pf-pro

