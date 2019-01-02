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

* **config.rb 설정**  
GitLab docker에 접속합니다. GitLab의 configuration 파일을 열고, 아래 내용을 추가합니다.  

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

* **GitLab 환경설정 파일**
```
sudo vim /etc/gitlab/gitlab.rb
```

* **GitLab 명령어**  
- 환경 파일 재로딩  
```
$ sudo gitlab-ctl reconfigure  
```
- start all gitlab components  
```
$ sudo gitlab-ctl start  
```
- stop all gitlab components  
```
$ sudo gitlab-ctl stop  
```
- restart all gitlab components  
```
$ sudo gitlab-ctl restart  
```

* **GitLab Repository**
```
./var/opt/gitlab/git-data/repositories/@account@
```