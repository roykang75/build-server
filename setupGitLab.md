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