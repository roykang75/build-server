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

(1) 브라우져로 [phpldapadmin.pettra.com:6443](http://phpldapadmin.pettra.com:6443) (or IPAdress:6443)으로 접속합니다. [고급] 버튼을 클릭한 후, _192.168.10.90(안전하지 않음)(으)로 이동_ 를 클릭합니다.
![](/assets/phpLDAPadmin_1.png)  

(2) [login]을 클릭합니다.
![](/assets/phpLDAPadmin_2.png)  

(3) Login DN과 admin 패스워드를 입력합니다.  
login DN: cn=admin, dc=pettra, dc=com (openLDAP docker에서 인자로 사용한 LDAP_DOMAIN="pettra.com" 을 입력합니다.)  
Password: openLDAP의 admin password  
![](/assets/phpLDAPadmin_3.png)  

(4) admin으로 login을 하면 아래와 같은 화면을 볼 수 있습니다.  
![](/assets/phpLDAPadmin_4.png)  

(5) 사용자를 추가하기 위한 작업을 진행합니다.  
**조직구분(Organizational Units), 그룹(Groups), 사용자(Users) 등록하기**  
디렉토리의 구조는 관리자가 원하는데로 사용할 수 있습니다. 조직이나 그룹 없이도 사용자를 등록할 수도 있고 활용할 수 있습니다. 본 문서는 가장 일반적인 구조인 조직구분(OU), 그룹(Group), 사용자(User) 단위로 디렉토리 구조를 생성하는 것으로 진행합니다.

**Organizational Units 생성**  
Organizational Units은 도메인 바로 아래 최상위 레벨의 논리적인 단위로 오브젝트들의 성격 별로 논리적인 단위로 묶을 있고 OU간에 관계도 설정할 수 있습니다. 예를 들어 그룹, 유저, 프린터, 어플리케이션 등으로 오브젝트 성격 별로 나누어 관리합니다.  
  
Create new entry here 를 선택하고 Generic: Organizational Units을 선택합니다.  
![](/assets/phpLDAPadmin_ou_1.png)  

이름 입력란에 "groups" 를 입력하고 Create Object를 클릭합니다.  
![](/assets/phpLDAPadmin_ou_2.png)  

Commit버튼을 클릭합니다.  
![](/assets/phpLDAPadmin_ou_3.png)  

왼쪽 트리에 "ou=groups"가 추가된 것을 볼 수 있습니다.  
![](/assets/phpLDAPadmin_ou_4.png)  

똑같은 방법으로 "users" OU를 생성한다.  

**Group 생성**
그룹은 관리자 그룹과 개발자 그룹 2개 그룹으로 나누어 설정합니다. 왼쪽 트리에서 ou=groups 를 선택합니다. Create a child entry를 클릭합니다.  
![](/assets/phpLDAPadmin_grp_1.png)  

Generic: Posix Group으로 선택합니다.  
![](/assets/phpLDAPadmin_grp_2.png)  

Group이름은 "admin" 으로 채워넣고 Creae Object 버튼을 클릭합니다.  
![](/assets/phpLDAPadmin_grp_3.png)  

Commit버튼을 클릭합니다.  
![](/assets/phpLDAPadmin_grp_4.png)  

왼쪽 트리에 "cn=admin"가 추가된 것을 볼 수 있습니다.  
![](/assets/phpLDAPadmin_grp_5.png)  

같은 방식으로 dev 그룹도 생성한다.  
![](/assets/phpLDAPadmin_grp_6.png)  

**User 생성**  
왼쪽 트리메뉴에서 ou=users 엔트리를 클릭하고 Create a child entry를 클릭합니다.  
![](/assets/phpLDAPadmin_user_1.png)  

Custom user template으로 생성한 Pettra: User Account 템플릿을 클릭합니다.  
![](/assets/phpLDAPadmin_user_2.png)  

Account 정보를 입력한 후, Create Object를 클릭합니다. GID Numebr에서 dev 그룹을 선택합니다.  
_(cn 이름이 실제 트리에 보일 이름입니다.)_  
![](/assets/phpLDAPadmin_user_3.png)  

Commit버튼을 클릭합니다.  
![](/assets/phpLDAPadmin_user_4.png)  

왼쪽 트리에 "cn=Roy Kang"가 추가된 것을 볼 수 있습니다.  
![](/assets/phpLDAPadmin_user_5.png)  

**유저를 그룹에 할당하기**  
등록된 유저들을 그룹에 할당하기 위해서는 해당 그룹의 속성을 먼저 추가해야 합니다. 방금 전 추가한 "cn=Roy Kang"을 dev 그룹에 추가해 보도록 하겠습니다. 트리에서 cn=dev을 클릭하고 Add new attribute를 클릭합니다.  
![](/assets/phpLDAPadmin_grp_user_1.png)  

Add Attribute에서 memberUid를 선택합니다.  
![](/assets/phpLDAPadmin_grp_user_2.png)  

계정(uid)을 입력한 후, Update Object 를 클릭합니다. (반드시 uid를 입력해야 합니다.)    
![](/assets/phpLDAPadmin_grp_user_3.png)  

Commit버튼을 클릭합니다.  
![](/assets/phpLDAPadmin_grp_user_4.png)  

아래와 같이 그룹에 계정이 추가된 것을 확인할 수 있습니다.  
![](/assets/phpLDAPadmin_grp_user_5.png)  

* **사용자 추가 방법은 아래 링크 참고**  
<http://blog.hkwon.me/use-openldap-part1/>  
스크린샷으로 따로 업데이트 예정

* **사용자 추가 후, 단순 검색 결과**  
ldapsearch 사용방법은 _openLDAP 설치_를 참조하세요.

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