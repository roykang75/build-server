# Confluence

## 10. Confluence 설치 (docker)
```
# openLDAP 설치
# 참고 사이트: https://github.com/osixia/docker-openldap
# docker run --detach \
#    --hostname confluence.pettra.com \
#    --publish 8091:8090 \
#    --name confluence \
#    --restart always \
#    --volume /data/srv/confluence:/var/atlassian/application-data/confluence \
#    --volume /etc/localtime:/etc/localtime:ro \
#    atlassian/confluence-server
```

* **docker 명령어**
```
docker run -v /data/srv/confluence:/var/atlassian/application-data/confluence --volume /etc/localtime:/etc/localtime:ro --restart always --name="confluence" -d -p 8091:8090  atlassian/confluence-server
```  