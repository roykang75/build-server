# build-server
build-server inistall script

빌드 스크립트 구성은 다음과 같다.

서버 환경:
* OS: Ubuntu 16.04 LTS
* IP: 192.168.10.90

* **시스템 구성도**
![](/assets/build_system.png)  


Contents  
1. [openLDAP 설치 (docker)](https://github.com/roykang75/build-server/blob/master/setupOpenLDAP.md)  
2. [phpLDAPadmin 설치 (docker)](https://github.com/roykang75/build-server/blob/master/setupPHPLDAPadmin.md)  
3. [GitLab 설치 (docker)](https://github.com/roykang75/build-server/blob/master/setupGitLab.md)  
4. [Jenkins 설치](https://github.com/roykang75/build-server/blob/master/setupJenkins.md)  
5. [build-pf-pro 설치 for Jenkins (docker)](https://github.com/roykang75/build-server/blob/master/setupBuild-pf-pro.md)  
6. [Netdata 설치 (서버 모니터링 툴)](https://github.com/roykang75/build-server/blob/master/setupNetdata.md)  

## 서버 업데이트
```
#! /bin/bash

sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y ldap-utils # ldapsearch utilities

# TimeZone을 Seoul로 설정
sudo ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
cat /etc/localtime
```