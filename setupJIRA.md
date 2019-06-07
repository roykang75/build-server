# JIRA

## 9. JIRA 설치 (docker)
```
# openLDAP 설치
# 참고 사이트: https://github.com/osixia/docker-openldap
# docker run --detach \
#    --hostname ldap.pettra.com \
#    --publish 8090:8080 \
#    --name jira \
#    --restart always \
#    --volume /data/srv/jira:/var/atlassian/jira \
#    --volume /etc/localtime:/etc/localtime:ro \
#    --user root
#    cptactionhank/atlassian-jira-software:latest
```

* **docker 명령어**
```
docker run --volume /data/srv/jira:/var/atlassian/jira --volume /etc/localtime:/etc/localtime:ro --name="jira" -d --publish 8090:8080 --restart always -u root cptactionhank/atlassian-jira-software:latest
```  

**Jenkins 설정**  
위의 docker 명령을 실행하면 8090 포트로 JIRA 가 실행됩니다.  
브라우져를 실행하고 설치한 PC의 IPaddress:8090 으로 접속을 합니다.  
접속을 하면 아래와 같이 초기화면이 나타납니다.  
![](/assets/jira_setup_1.png)  

*한글로 보기위해서는 "language"를 선택하고 "한국어"를 선택하면 모든 메뉴를 한국어로 볼 수 있습니다.*  

"사용자를 위해 설정하십시오"를 선택합니다.  
![](/assets/jira_setup_2.png)  

사용자 ID와 Password를 입력하는 화면이 나타납니다.   
JIRA를 구입한 ID 와 Password를 입력합니다.  
(ID: sysadmin@dogtra.com, Password: Pettra@sysadm)
![](/assets/jira_setup_3.png)  


잠시 후, 아래와 같은 화면이 나타납니다.  
Pettra에서는 Jira Software(Server) 를 구입하였습니다.  
따라서, "Jira Software(Server)"를 선택합니다. 
![](/assets/jira_setup_4.png)  

이하 설치화면은 이미 구입한 라이센스로 서버가 실행되고 있어 설치를 할 수 없어 생략합니다.  

**openLDAP와 연동하기**  
adminstrator 권한이 있는 계정으로 로그인합니다.  
![](/assets/jira_setup_5.png)  

*작업을 진행 중에 "관리자 접근"이라는 창에서 Password를 또 입력받는 경우가 있습니다. 이는 검증을 위한 정상적인 절차입니다.*

왼쪽 메뉴에서 "사용자 디렉토리"를 선택하고, [디렉토리 추가]를 선택합니다.  
아래 화면은 이미 설정이 마치고 구동되고 있어서 LDAP 서버 설정이 되어 있습니다. 이를 무시하세요.  
![](/assets/jira_setup_6.png)  

'LDAP"를 선택합니다. [다음]을 선택합니다.  
![](/assets/jira_setup_7.png)  

설정값은 아래 화면을 참고하세요.  
![](/assets/jira_setup_8.png)  

브라우져의 스크롤을 내려 "사용자 스키마 설정" 을 클릭합니다.  
아래와 같이 설정합니다.  
![](/assets/jira_setup_9.png)  

설정이 완료되면 화면 하단의 [저장 및 테스트] 를 선택합니다.  

아래와 같은 화면이 나타나면 정상적으로 openLDAP 서버와 연결된 것입니다.  
![](/assets/jira_setup_10.png)  

