# GitLab

## 3. GitLab 설치 (docker)
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

* **openLDAP 서버와 연동**  

초기 설정은 기본적으로 ldap 기능은 disable된 상태입니다. ldap 연결 활성화를 위해 설정 파일을 수정합니다. GitLab docker에 접속합니다. GitLab의 configuration 파일을 열고, 아래 내용을 추가합니다.  (앞서 설치한 ldap 정보를 추가합니다.)

```
# vim /etc/gitlab/gitlab.rb
.....
### LDAP Settings
###! Docs: https://docs.gitlab.com/omnibus/settings/ldap.html
###! **Be careful not to break the indentation in the ldap_servers block. It is
###!   in yaml format and the spaces must be retained. Using tabs will not work.**

gitlab_rails['ldap_enabled'] = true
gitlab_rails['ldap_servers'] = YAML.load <<-'EOS'
 main: # 'main' is the GitLab 'provider ID' of this LDAP server
     label: 'LDAP'
     host: '192.168.10.90'
     port: 389
     uid: 'uid'
     #uid: 'sAMAccountName'
     bind_dn: 'CN=admin,DC=pettra,DC=com'
     password: 'P@ssword'
     encryption: 'plain' # "start_tls" or "simple_tls" or "plain"
     verify_certificates: false
     active_directory: false
     allow_username_or_email_login: true
     lowercase_usernames: false
     block_auto_created_users: false
     base: 'OU=users,DC=pettra,DC=com'
     user_filter: ''
EOS
.....
```
설정 값은 위와 같이 넣어주면 됩니다.. 설정이 완료되면 gitlab을 재구성하고 재시작합니다. 설정 파일은 실시간으로 반영은 안되고 reconfigure를 해줘야 반영이 됩니다.
```
# gitlab-ctl reconfigure  
# gitlab-ctl restart  
```

**GitLab 접속**  
브라우져를 통해 GitLab에 접속합니다.  
![](/assets/gitlab_openLDAP_1.png)  

LDAP 로그인 탭이 보이고 이제 LDAP에 등록된 유저로 로그인이 가능합니다. 하지만 먼저 신규 가입 기능 제거 등의 어드민 설정을 위해서 Standard 모드로 root 유저로 로그인 합니다.  
Username : root  
Password : 5iveL!fe(초기패스워드)  <== 확인 필요  
초기 패스워드는 위와 같고 로그인 후 새로운 패스워드를 입력합니다.  
![](/assets/gitlab_openLDAP_2.png)  

로그인 후에 오른쪽 상단에 스패너 아이콘을 클릭합니다.  
![](/assets/gitlab_openLDAP_3.png)  

왼쪽 Settings 메뉴를 클릭합니다.  
![](/assets/gitlab_openLDAP_4.png)  

Sign-in Restrictions에서 Sign-up enabled를 LDAP에 등록된 유저로만 사용하기 위해서 체크 해제합니다. Save버튼으로 저장합니다.  
![](/assets/gitlab_openLDAP_5.png)  


* **GitLab 환경설정 파일**
```
sudo vim /etc/gitlab/gitlab.rb
```

* **GitLab 명령어**  

**환경 파일 재로딩**  
```
$ sudo gitlab-ctl reconfigure  
```
**Start all GitLab Components**  
```
$ sudo gitlab-ctl start  
```
**Stop all GitLab Components**  
```
$ sudo gitlab-ctl stop  
```
**Restart all GitLab Components**  
```
$ sudo gitlab-ctl restart  
```

* **GitLab Repository**  
```
./var/opt/gitlab/git-data/repositories/@account@
```