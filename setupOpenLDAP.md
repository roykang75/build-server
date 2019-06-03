# openLDAP

## 1. openLDAP 설치 (docker)
```
# openLDAP 설치
# 참고 사이트: https://github.com/osixia/docker-openldap
# docker run --detach \
#    --hostname ldap.pettra.com \
#    --publish 389:389 --publish 689:689 \
#    --name openLDAP \
#    --restart always \
#    --volume /data/srv/slapd/config:/etc/ldap/slapd.d \
#    --volume /etc/localtime:/etc/localtime:ro \
#    --env LDAP_DOMAIN="pettra.com" \
#    --env LDAP_ADMIN_PASSWORD="P@ssword"
#    osixia/openldap:1.2.2
```

* **docker 명령어**
```
docker run --detach --hostname ldap.pettra.com --publish 389:389 --publish 689:689 --name openLDAP --restart always --volume /data/srv/slapd/config:/etc/ldap/slapd.d --volume /etc/localtime:/etc/localtime:ro --env  LDAP_DOMAIN="pettra.com" --env LDAP_ADMIN_PASSWORD="P@ssword" osixia/openldap:1.2.2
```  

* **openLDAP 검증**  

LDAP 검증을 위해, ldapsearch 유틸리티를 사용합니다.  
설치 명령은 다음과 같습니다.  
```
$ sudo apt install ldap-utils
```
간단한 옵션은 다음과 같습니다.  
-w: admin password를 command line에서 입력 받음  
```
$ ldapsearch -x -H ldap://ldap.pettra.com -b dc=pettra,dc=com -D "cn=admin,dc=pettra,dc=com" -w P@ssword
<<검색 결과 출력>>  
```
-W: admin password를 키보드에서 입력 받음  
```
$ ldapsearch -x -W -H ldap://ldap.pettra.com -b dc=pettra,dc=com -D "cn=admin,dc=pettra,dc=com"
Enter LDAP Password: admin password  
<<검색 결과 출력>>  
```

더 자세한 정보는 아래 링크를 참고하세요.  
http://manpages.ubuntu.com/manpages/xenial/man1/ldapsearch.1.html  


여기서는 -w 옵션을 사용하습니다.  
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

````