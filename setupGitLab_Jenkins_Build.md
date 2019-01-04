# GitLab - Jenkins - Build docker간 연동

**1. openLDAP**  
인증을 위한 계정을 생성합니다.  
계정 정보는 다음과 같이 생성합니다.  

계정명(uid) | pettra
----|------
암호 | P@ssword
암호확인 | P@ssword
이름(cn) | pettra autobuild 
이메일주소 | roykang75@gmail.com
![](/assets/phpLDAPadmin_jenkins_user_1.png)  

**2. GitLab과 openLDAP 연동**  
"3. GitLab 설치 (docker)" 을 진행하였으면 GitLab과 openLDAP 서버간 연동은 완료된 것입니다.  

**3. Build-pf-pro**  
"5. build-pf-pro 설치 for Jenkins (docker)" 을 진행하였으면 GitLab/Jenkins와 연동할 기본 준비는 된 것입니다.

**4. GitLab**  
pettra 계정으로 로그인합니다. 브라우져 상단 오른쪽 아이콘을 클릭하고, Setting 메뉴를 클릭합니다.  
![](/assets/gitlab_jenkins_build_1.png)  

왼쪽 메뉴에서 "SSH Keys"를 클릭합니다.  
![](/assets/gitlab_jenkins_build_2.png)  

Build-pf-pro docker의 pettra 계정의 public ssh key를 복사합니다.  
```
$ cat /home/pettra/.ssh/id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDC4xvlMyJ5rQgq/VyYvzHBdB818Eh4FDHqPM77mQBAD2OYJoT3RFJg5uwuy0DZtuIsJpICtU85iSP7lFULtOVFCGpVmz4pA2II1i2u8VLUrdhPo9CzZhGzEVelXsYPORjJUxgpkTZwpE7PfTauoiSHrfgmD7kApxzU0/+RLBc8A9SK1yKI41Mi5c1M0+1MCmPji2B8moXnaCQFp25Cs0LtcPw8biirWvyxyFfti+hP7P06Ws6ukQaG+JqZHijmqrNJvTYSvRgGL6inuqKV+BFqM1lASl09AS3d1PHC5yfiunOQ+dnmPMOba7p8xZ2kYbvQAbfyQVWmB5mc/WGijL4d
```

복사한 pettra 계정의 public ssh key를 Key 입력 박스에 붙이기합니다. Add key 버튼을 클릭하여 저장합니다.  
![](/assets/gitlab_jenkins_build_3.png)  

GitLab Personal Access Token을 발급받기 위해 Access Tokens 메뉴로 이동합니다.  
![](/assets/gitlab_jenkins_build_4.png)  

Personal Access Tokens에서 Name을 jenkins로 expires at을 2030-12-31 로 설정합니다. Scope는 3개 모두 선택을 한 후, Create personal access token 버튼을 클릭합니다.    
![](/assets/gitlab_jenkins_build_5.png)  

Acitve Personal Access Tokens에 생성된 token을 확인할 수 있습니다.  
![](/assets/gitlab_jenkins_build_6.png)  

Jenkins 사이트에 접속하여 admin 계정으로 로그인합니다.  
