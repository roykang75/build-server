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