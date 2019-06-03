# build-server
build-server inistall script

빌드 스크립트 구성은 다음과 같다.

서버 환경:
* OS: Ubuntu 16.04 LTS
* IP: 192.168.10.90
* DNS: pettra.com

* **시스템 구성도**
![](/assets/build_system.png)  

## 사전 작업  
사전 작업을 반듯이 진행하고 서버를 설치해야 합니다.  
만약 이를 지키지 않는 경우, 설치 또는 운영에러가 발생할 수 있습니다.  

### 서버 업데이트  
```
#! /bin/bash

sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y ldap-utils # ldapsearch utilities

# TimeZone을 Seoul로 설정
sudo ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
cat /etc/localtime
```

### 디렉토리 구조  
본 예제는 pettra 계정이 있다는 가정하에 작업이 진행됩니다.  
/data 는 다른 HDD의 mount 디렉토리일 수도 있고, 일반 디렉토리일 수도 있습니다.  

/data가 일반 디렉토리인 경우는 다음과 같이 처리합니다.  
```
$ sudo mkdir /data
$ sudo chown pettra data # data 디렉토리의 owner를 pettra로 변경합니다.
$ sudo chgrp pettra data # data 디렉토리의 group을 pettra로 변경합니다.
$ ls -al
drwxr-xr-x   3 pettra  pettra   4096  6월  3 14:55 data/
$ cd data
$ mkdir srv  # 앞으로 설치할 서버들의 configuration file들을 저장할 위치를 생성합니다.
```

Contents  
1. [openLDAP 설치 (docker)](https://github.com/roykang75/build-server/blob/master/setupOpenLDAP.md)  
2. [phpLDAPadmin 설치 (docker)](https://github.com/roykang75/build-server/blob/master/setupPHPLDAPadmin.md)  
3. [GitLab 설치 (docker)](https://github.com/roykang75/build-server/blob/master/setupGitLab.md)  
4. [Jenkins 설치](https://github.com/roykang75/build-server/blob/master/setupJenkins.md)  
5. [build-pf-pro 설치 for Jenkins (docker)](https://github.com/roykang75/build-server/blob/master/setupBuild-pf-pro.md)  
6. [GitLab - Jenkins - Build docker간 연동](https://github.com/roykang75/build-server/blob/master/setupGitLab_Jenkins_Build.md)
7. [Netdata 설치 (서버 모니터링 툴)](https://github.com/roykang75/build-server/blob/master/setupNetdata.md)  

## Docker  
Docker Study: [가장 빨리 만나는 Docker](http://pyrasis.com/docker.html)

## 네트워크 기본 지식  
**Client가 DNS를 찾는 순서**  
(1) Cache: PC를 power on한 후, 방문한 DNS의 cache 정보이다. PC를 재부팅하면 사라진다.  
(2) hosts 파일  
    - Linux: /etc/hosts
    - Windows: C:\windows\system32\drivers\etc\hosts  
(3) DNS 서버    

**인터넷 지식**  
    [Hosts (호스트) 파일이란?](https://github.com/roykang75/build-server/blob/master/whatIsHosts.md)
