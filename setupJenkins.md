# Jenkins

## 4. Jenkins 설치
여기서는 소스 빌드를 docker에서 진행합니다. Jenkins를 docker로 운영하는 경우, docker 안에 다른 docker(docker for jenkins auto build)를 둬야 하는 복잡성 때문에 Jenkins는 docker가 아닌 서버에 직접 설치하는 방법을 사용합니다. 또한, Jenkins는 OpenJDK 1.8을 사용하고 PathFinder Pro는 OpenJDK 1.7을 사용(Android 5.1)하여 같은 공간에서 빌드가 안됩니다.  

**openJDK 1.8 설치**
```
sudo apt-get install -y openjdk-8-jdk
```

**Jenkins 설치**
```
$ wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
$ sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
$ sudo apt-get update
$ sudo add-apt-repository universe
$ sudo apt-get install jenkins
```

**Jenkins 설정**  
브라우져로 http://192.168.10.90:8080 (or http://localhost:8080)  

Jenkins를 unlock합니다.  
: /var/lib/jenkins/secrets/initialAdminPassword 경로의 unlock code를 읽어서 입력합니다.  
![](/assets/jenkins_unlock.png)

```
$ sudo cat /var/lib/jenkins/secrets/initialAdminPassword
b08ef74bbb1a4673bc1a59dea2de****
```

Install suggested plugins 선택합니다.  
![](/assets/jenkins_setup_1.png)  

![](/assets/jenkins_setup_2.png)  

Admin User를 생성합니다.  
![](/assets/jenkins_setup_3.png)  

계정명 | admin
----|------
암호 | P@ssword
암호확인 | P@ssword
이름 | admin
이메일주소 | roykang75@gmail.com
`

Jenkins URL을 설정합니다.  
![](/assets/jenkins_setup_4.png)  

Jenkins을 사용할 준비가 되었습니다.  
![](/assets/jenkins_setup_5.png)  

**Jenkins와 GitLab 연동 준비**  

GitLab 연동을 위한 plugin 설치해야 합니다. Jenkins에 admin 권한으로 로그인합니다. 왼쪽 메뉴에서 "Jenkins 관리"를 클릭합니다.  
![](/assets/jenkins_gitlab_1.png)  

"플러그인 관리" 메뉴를 클릭합니다.  
![](/assets/jenkins_gitlab_2.png)  

아래 플러그인을 설치합니다.  
```
- Gitlab Authentication plugin
- Gitlab Hook Plugin
- GitLab Logo Plugin
- Gitlab Merge Request Builder
- GitLab Plugin
- Violation Comments to GitLab Plugin
- LDAP Plugin
```

