#! /bin/bash

sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y ldap-utils # ldapsearch utilities

# TimeZone을 Seoul로 설정
sudo ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
cat /etc/localtime

# openLDAP 설치
# docker run --detach \
#    --hostname ldap.pettra.com \
#    --publish 389:389 --publish 689:689 \
#    --name openLDAP \
#    --restart always \
#    --volume /data/srv/slapd/config:/etc/ldap/slapd.d \
#    --volume /data/srv/slapd/config:/etc/ldap/slapd.d \
#    --volume /etc/localtime:/etc/localtime:ro \
#    --env LDAP_DOMAIN="pettra.com" \
#    --env LDAP_ADMIN_PASSWORD="Pettra@1023"
#    osixia/openldap:1.2.2

docker run --detach --hostname ldap.pettra.com --publish 389:389 --publish 689:689 --name openLDAP --restart always --volume /data/srv/slapd/config:/etc/ldap/slapd.d --volume /data/srv/slapd/config:/etc/ldap/slapd.d --volume /etc/localtime:/etc/localtime:ro --env  LDAP_DOMAIN="pettra.com" --env LDAP_ADMIN_PASSWORD="Pettra@1023" osixia/openldap:1.2.2

# openLDAP 검증
ldapsearch -x -H ldap://ldap.pettra.com -b dc=pettra,dc=com -D "cn=admin,dc=pettra,dc=com" -w Pettra@1023

# 아래와 같은 결과가 출력되어야 한다.
# 여기부터 <============================================================================
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

# search result
#search: 2
#result: 0 Success

# numResponses: 3
# numEntries: 2
# 여기까지 ============================================================================>

# phpldapadmin 설치
# docker run --detach \
#    --hostname phpldapadmin.pettra.com \
#    --publish 6443:443 \
#    --name phpldapadmin \
#    --restart always \
#    --volume /etc/localtime:/etc/localtime:ro \
#    --env PHPLDAPADMIN_LDAP_HOSTS=IPAddress \ # internet domain을 기입. 정식 도메인이 없는 경우 반듯이 IP를 입력(192.168.10.81)
#                                              # hosts 파일에 가라로 등록한 domain address을 기입하는 경우 정상동작하지 않음
#    osixia/phpldapadmin:0.7.2

# phpldapadmin 설치
docker run --detach --hostname phpldapadmin.pettra.com --publish 6443:443 --name phpldapadmin --restart always --volume /etc/localtime:/etc/localtime:ro --env PHPLDAPADMIN_LDAP_HOSTS=192.168.10.90 osixia/phpldapadmin:0.7.2
# User 추가를 위한 custom user template를 docker에 upload한다.
docker cp ./custom_posixAccount.xml phpldapadmin:./var/www/phpldapadmin/templates/creation/

# 브라우져로 phpldapadmin.pettra.com:6443 (or IPAdress:6443)으로 접속

# 사용자 추가 후 추가한 단순 검색 결과
#ldapsearch -x -H ldap://ldap.pettra.com -b dc=pettra,dc=com -D "cn=admin,dc=pettra,dc=com" -w Pettra@1023
# 아래와 같은 결과가 출력되어야 한다.
# 여기부터 <============================================================================
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
# 여기까지 ============================================================================>

# 사용자 추가 후 추가한 사용자 검증 방법
ldapsearch -x -H ldap://ldap.pettra.com -b dc=pettra,dc=com -D "cn=Roy Kang,ou=users,dc=pettra,dc=com" -w kstkmr2010

# 아래와 같은 결과가 출력되어야 한다.
# 여기부터 <============================================================================
# extended LDIF
#
# LDAPv3
# base <dc=pettra,dc=com> with scope subtree
# filter: (objectclass=*)
# requesting: ALL
#

# search result
#search: 2
#result: 32 No such object

# numResponses: 1
# 여기까지 ============================================================================>
