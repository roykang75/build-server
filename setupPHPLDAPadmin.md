# phpLDAPadmin

## 2. phpLDAPadmin 설치 (docker)
```
# 참고사이트: https://github.com/osixia/docker-phpLDAPadmin
# docker run --detach \
#    --hostname phpldapadmin.pettra.com \
#    --publish 6443:443 \
#    --name phpldapadmin \
#    --restart always \
#    --volume /etc/localtime:/etc/localtime:ro \
#    --env PHPLDAPADMIN_LDAP_HOSTS=IPAddress \ # openLDAP가 설치된 서버 주소 기입
#                                              # internet domain을 기입. 정식 도메인이 없는 경우 반드시 IP를 입력(192.168.10.90)
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

![](/assets/phpLDAPadmin_1.png)  

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