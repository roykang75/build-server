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

명칭 | 설정값
----|------
계정명 | root
암호 | P@ssword
암호확인 | P@ssword
이름 | admin
이메일주소 | roykang@dogtra.com
`

Jenkins URL을 설정합니다.  
![](/assets/jenkins_setup_4.png)  

Jenkins을 사용할 준비가 되었습니다.  
![](/assets/jenkins_setup_5.png)  


**빌드 프로젝트 생성**  
다음과 같이 빌드 프로젝트를 생성합니다.  

Jenkins 왼쪽 메뉴에서 "새로운 Item"을 선택하거나, "새 작업"을 선택합니다.  
![](/assets/jenkins_project_1.png)  

"Enter an item name"에 생성하려는 프로젝트 이름을 입력하고 "Freestyle project"를 선택합니다.  
화면 하단의 [OK] 버튼을 선택합니다.  
![](/assets/jenkins_project_2.png)  

다른 부분은 default 값으로 두고, Build 섹션에서 "Execute shell"을 선택합니다.  
![](/assets/jenkins_project_3.png)  

"Execute shell"의 Command 입력란에 아래 내용을 복사해서 붙여 넣습니다.  

```
#!/bin/bash

echo ""
echo "==============================================="
whoami
echo "==============================================="

docker exec -u 1000 -i lollipop-build-env bash /work/src/pf-pro-common-v0.1.5/run_build.sh
```

![](/assets/jenkins_project_4.png)  

[저장] 버튼을 선택합니다.  

**주의**  
아래 명령에서 /work/src/pf-pro-common-v0.1.5/run_build.sh 의 경로에 주의해야 합니다.  
```
docker exec -u 1000 -i lollipop-build-env bash /work/src/pf-pro-common-v0.1.5/run_build.sh
```

프로젝트가 정상적으로 생성되면 아래와 같은 화면이 나타납니다.  
![](/assets/jenkins_project_5.png)  

프로젝트를 빌드하려면 왼쪽 메뉴의 "Build Now"를 선택합니다.  
![](/assets/jenkins_project_6.png)  



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

