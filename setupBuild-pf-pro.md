# build-pf-pro

## 5. build-pf-pro 설치
```
# $ docker run --name build-pf-pro -v /data/work/src:/work -it ubuntu:16.04 /bin/bash
```

**docker 명령어**
```
$ docker run --name build-pf-pro -v /data/work/src:/work -it ubuntu:16.04 /bin/bash
```

**Android 5.1 build를 위한 utilities 설치**

ubuntu 16.04 update 하고, docker에 기본적으로 탑재되어 있지 않은 sudo와 vim을 설치합니다.  
```
# apt-get update && apt-get upgrade -y
# apt-get install -y sudo vim
```

빌드를 위한 계정을 생성하고 sudo 권한을 부여합니다.  
```
# adduser pettra
# visudo -f /etc/sudoers
# User privilege specification
    root    ALL=(ALL:ALL) ALL
    pettra  ALL=(ALL:ALL) ALL  # 추가
```

계정을 pettra로 전환하고, Android 5.1 빌드를 위한 유틸리티를 설치합니다.    
```
# su - pettra
$ sudo apt-get install -y git-core gnupg flex bison gperf build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev libgl1-mesa-dev libxml2-utils xsltproc unzip
$ sudo apt-get install -y git repo xz-utils
$ sudo apt-get install -y bc u-boot-tools realpath ccache
```
JDK 1.7 버전을 설치합니다.
```
$ sudo apt-get install -y software-properties-common
$ sudo add-apt-repository ppa:openjdk-r/ppa  
$ sudo apt-get update && sudo apt-get install -y openjdk-7-jdk 
```
ssh key를 생성합니다.  
```
$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/root/.ssh/id_rsa): [Enter] 키 입력
Enter passphrase (empty for no passphrase): [Enter] 키 입력
Enter same passphrase again: [Enter] 키 입력
Your identification has been saved in /home/pettra/.ssh/id_rsa.
Your public key has been saved in /home/pettra/.ssh/id_rsa.pub.
The key fingerprint is:
20:e9:b0:5b:5a:2b:ad:e8:4d:e4:b3:a0:32:49:2d:97 evan
The key's randomart image is:
+--[ RSA 2048]----+
|                 |
|     .           |
|  . o .          |
|   + . .         |
|  o.=   S        |
| ooE .           |
|.o*+o            |
|=.+oo            |
|=o.o             |
+-----------------+
```

다음과 같이 개인키(id_rsa), 공개키(id_rsa.pub) 파일이 생성됩니다.  
```
$ ll ~/.ssh/id_rsa*
-rw------- 1 pettra pettra 1743 Sep  4 14:28 /home/pettra/.ssh/id_rsa
-rw-r--r-- 1 pettra pettra  390 Sep  4 14:28 /home/pettra/.ssh/id_rsa.pub
```

