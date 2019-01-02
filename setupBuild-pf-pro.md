# build-pf-pro

## 5. build-pf-pro 설치
* **ubuntu 16.04 container 생성**
    ```
    $ docker run --name build-pf-pro -v /data/work/src:/work -it ubuntu:16.04 /bin/bash
    # apt-get update && apt-get upgrade -y
    # apt-get install -y sudo vim
    # adduser jenkins
    # visudo -f /etc/sudoers
    # User privilege specification
        root    ALL=(ALL:ALL) ALL
        jenkins ALL=(ALL:ALL) ALL  # 추가
    # su - jenkins
    $ sudo apt-get install -y git-core gnupg flex bison gperf build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev libgl1-mesa-dev libxml2-utils xsltproc unzip
    $ sudo apt-get install -y git repo xz-utils
    $ sudo apt-get install -y bc u-boot-tools realpath ccache
    $ sudo apt-get install -y software-properties-common
    $ sudo add-apt-repository ppa:openjdk-r/ppa  
    $ sudo apt-get update && sudo apt-get install -y openjdk-7-jdk 
    ```
