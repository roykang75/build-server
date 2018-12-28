# build-server
build-server inistall script

빌드 스크립트 구성은 다음과 같다.

서버 환경:
* OS: Ubuntu 16.04 LTS
* IP: 192.168.10.90

## 1. 서버 업데이트
```
#! /bin/bash

sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y ldap-utils # ldapsearch utilities

# TimeZone을 Seoul로 설정
sudo ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
cat /etc/localtime
```

## 2. openLDAP 설치 (docker)
```
# openLDAP 설치
# 참고 사이트: https://github.com/osixia/docker-openldap
# docker run --detach \
#    --hostname ldap.pettra.com \
#    --publish 389:389 --publish 689:689 \
#    --name openLDAP \
#    --restart always \
#    --volume /data/srv/slapd/config:/etc/ldap/slapd.d \
#    --volume /data/srv/slapd/config:/etc/ldap/slapd.d \
#    --volume /etc/localtime:/etc/localtime:ro \
#    --env LDAP_DOMAIN="pettra.com" \
#    --env LDAP_ADMIN_PASSWORD="P@ssword"
#    osixia/openldap:1.2.2
```

* **docker 명령어**
```
docker run --detach --hostname ldap.pettra.com --publish 389:389 --publish 689:689 --name openLDAP --restart always --volume /data/srv/slapd/config:/etc/ldap/slapd.d --volume /data/srv/slapd/config:/etc/ldap/slapd.d --volume /etc/localtime:/etc/localtime:ro --env  LDAP_DOMAIN="pettra.com" --env LDAP_ADMIN_PASSWORD="P@ssword" osixia/openldap:1.2.2
```
* **openLDAP 검증**
```
$ ldapsearch -x -H ldap://ldap.pettra.com -b dc=pettra,dc=com -D "cn=admin,dc=pettra,dc=com" -w P@ssword
# extended LDIF

# LDAPv3
# base <dc=pettra,dc=com> with scope subtree
# filter: (objectclass=*)
# requesting: ALL


# pettra.com
dn: dc=pettra,dc=com
objectClass: top
objectClass: dcObject
objectClass: organization
o: Example Inc.
dc: pettra

# admin, pettra.com
dn: cn=admin,dc=pettra,dc=com
objectClass: simpleSecurityObject
objectClass: organizationalRole
cn: admin
description: LDAP administrator
userPassword:: e1NTSEF9Ui96U0ppdzJKdHhud0N6RGZxb0pacnREMHBQR3Q5M3k=

# search result
search: 2
result: 0 Success

numResponses: 3
numEntries: 2

```

## 3. phpLDAPadmin 설치 (docker)
```
# 참고사이트: https://github.com/osixia/docker-phpLDAPadmin
# docker run --detach \
#    --hostname phpldapadmin.pettra.com \
#    --publish 6443:443 \
#    --name phpldapadmin \
#    --restart always \
#    --volume /etc/localtime:/etc/localtime:ro \
#    --env PHPLDAPADMIN_LDAP_HOSTS=IPAddress \ # internet domain을 기입. 정식 도메인이 없는 경우 반드시 IP를 입력(192.168.10.90)
#                                              # hosts 파일에 가라로 등록한 domain address을 기입하는 경우 정상동작하지 않음
#    osixia/phpldapadmin:0.7.2
```
* **docker 명령어**
```
docker run --detach --hostname phpldapadmin.pettra.com --publish 6443:443 --name phpldapadmin --restart always --volume /etc/localtime:/etc/localtime:ro --env PHPLDAPADMIN_LDAP_HOSTS=192.168.10.90 osixia/phpldapadmin:0.7.2
```
* **User 추가를 위한 custom user template를 docker에 upload한다.**
```
docker cp ./custom_posixAccount.xml phpldapadmin:./var/www/phpldapadmin/templates/creation/
```

* **phpLDAPadmin 검증**  
: 브라우져로 [phpldapadmin.pettra.com:6443](http://phpldapadmin.pettra.com:6443) (or IPAdress:6443)으로 접속

* **사용자 추가 방법은 아래 링크 참고**  
<http://blog.hkwon.me/use-openldap-part1/>

* **사용자 추가 후, 단순 검색 결과**
```
$ ldapsearch -x -H ldap://ldap.pettra.com -b dc=pettra,dc=com -D "cn=admin,dc=pettra,dc=com" -w P@ssword
# extended LDIF
#
# LDAPv3
# base <dc=pettra,dc=com> with scope subtree
# filter: (objectclass=*)
# requesting: ALL
#

# pettra.com
#dn: dc=pettra,dc=com
#objectClass: top
#objectClass: dcObject
#objectClass: organization
#o: Example Inc.
#dc: pettra

# admin, pettra.com
#dn: cn=admin,dc=pettra,dc=com
#objectClass: simpleSecurityObject
#objectClass: organizationalRole
#cn: admin
#description: LDAP administrator
#userPassword:: e1NTSEF9Ui96U0ppdzJKdHhud0N6RGZxb0pacnREMHBQR3Q5M3k=

# groups, pettra.com
#dn: ou=groups,dc=pettra,dc=com
#ou: groups
#objectClass: organizationalUnit
#objectClass: top

# users, pettra.com
#dn: ou=users,dc=pettra,dc=com
#ou: users
#objectClass: organizationalUnit
#objectClass: top

# admin, groups, pettra.com
#dn: cn=admin,ou=groups,dc=pettra,dc=com
#cn: admin
#gidNumber: 500
#objectClass: posixGroup
#objectClass: top

# dev, groups, pettra.com
#dn: cn=dev,ou=groups,dc=pettra,dc=com
#cn: dev
#gidNumber: 501
#objectClass: posixGroup
#objectClass: top

# Roy Kang, users, pettra.com
#dn: cn=Roy Kang,ou=users,dc=pettra,dc=com
#givenName: Roy
#sn: Kang
#cn: Roy Kang
#uid: roykang
#userPassword:: e01ENX13dW10NlRySFRaaEFrUG56YlBEOWNnPT0=
#uidNumber: 1000
#gidNumber: 501
#homeDirectory: /home/users/roykang
#loginShell: /bin/bash
#mobile: 010-5495-2654
#mail: roykang@dogtra.com
#displayName:: 6rCV7ISx7YOc
#objectClass: inetOrgPerson
#objectClass: posixAccount
#objectClass: top

# search result
#search: 2
#result: 0 Success

# numResponses: 8
# numEntries: 7
```

* **사용자 추가 후 추가한 사용자 검증 방법**  
: 패스워드(-w)는 LDAP에서 입력한 Roy Kang 계정의 password를 입력합니다.  
여기서는 예를 들어, P@ssword를 사용하였습니다.
```
$ ldapsearch -x -H ldap://ldap.pettra.com -b dc=pettra,dc=com -D "cn=Roy Kang,ou=users,dc=pettra,dc=com" -w P@ssword
# extended LDIF
#
# LDAPv3
# base <dc=pettra,dc=com> with scope subtree
# filter: (objectclass=*)
# requesting: ALL
#

# search result
search: 2
result: 32 No such object

 numResponses: 1
```

## 4. GitLab 설치 (docker)
```
# docker run --detach \
#    --hostname gitlab.pettra.com \
#    --publish 443:443 --publish 80:80 --publish 22:22 \
#    --name gitlab \
#    --restart always \
#    --volume /data/srv/gitlab/config:/etc/gitlab
#    --volume /data/srv/gitlab/logs:/var/log/gitlab
#    --volume /data/srv/gitlab/data:/var/opt/gitlab # 여기에 source data에 저장된다.
#    --volume /etc/localtime:/etc/localtime:ro \
#    gitlab/gitlab-ce:latest
```

* **docker 명령어**
```
docker run --detach --hostname gitlab.pettra.com --publish 443:443 --publish 80:80 --publish 22:22 --name gitlab --restart always --volume /data/srv/gitlab/config:/etc/gitlab --volume /data/srv/gitlab/logs:/var/log/gitlab --volume /data/srv/gitlab/data:/var/opt/gitlab --volume /etc/localtime:/etc/localtime:ro gitlab/gitlab-ce:latest
```

* **데이터 백업**  
GitLab의 모든 정보는 server의 /data/srv/gitlab 폴더에 모두 저장되어 있습니다.
따라서, 이를 복사하여 백업해 놨다가 같은 경로에 압축을 해제하면 이전과 동일한 상태로 만들 수 있습니다.
```
$ cd /data/srv/
$ sudo tar cfvz gitlab.tgz gitlab
```
적당한 장소에 백업.
```
$ cd /data/srv/
$ tar xfvz gitlab.tgz # 현재 폴더에 압축을 해제합니다.
```

## 5 Jenkins 설치
여기서는 소스 빌드를 docker에서 진행합니다. Jenkins를 docker로 운영하는 경우, docker 안에 다른 docker(docker for jenkins auto build)를 둬야 하는 복잡성 때문에 Jenkins는 docker가 아닌 서버에 직접 설치하는 방법을 사용합니다.

* **openJDK 1.8 설치**
```
sudo apt-get install -y openjdk-8-jdk
```

* **Jenkins 설치**
```
$ wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
$ sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
$ sudo apt-get update
$ sudo add-apt-repository universe
$ sudo apt-get install jenkins
```
* **Jenkins 설정**  
브라우져로 http://192.168.10.90:8080 (or http://localhost:8080) 

* Jenkins unlock  
: /var/lib/jenkins/secrets/initialAdminPassword 경로의 unlock code를 읽어서 입력합니다.
![](/assets/jenkins_unlock.png)
  

    ```
    $ sudo cat /var/lib/jenkins/secrets/initialAdminPassword
    b08ef74bbb1a4673bc1a59dea2de****
    ```

* Jenkins plugin install
    Install suggested plugins 선택  
    ![](/assets/jenkins_setup_1.png)  

    ![](/assets/jenkins_setup_2.png)  

* Admin User 생성  
    ![](/assets/jenkins_setup_3.png)  

    계정명 | admin
    ----|------
    암호 | P@ssword
    암호확인 | P@ssword
    이름 | admin
    이메일주소 | roykang75@gmail.com
`
* Jenkins URL 설정
    ![](/assets/jenkins_setup_4.png)  

* Jenkins Ready
    ![](/assets/jenkins_setup_5.png)  

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
