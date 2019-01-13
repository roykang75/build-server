# Integrate your server with GitLab.com


**GitLab.com에서의 설정**  

(1) GitLab.com에 로그인하세요.  
(2) 오른쪽 상단에서 아바타를 클릭하고 Setting을 클릭하세요.  
(3) 왼쪽 메뉴에서 Applications를 선택합니다.  
(4) 아래와 같은 형태로 정보를 입력합니다.

![](/assets/Integrate_your_server_with_GitLab_com_1.png)  

Name : 자기가 보기 편한 이름을 정합니다. 큰 의미는 없습니다.  
Redirect URI : GitLab.com에서 integration 작업을 할 때 호출할 URL을 표기합니다.  

your-gitlab.example.com는 반듯이 외부에서 접근이 가능해야 합니다.  
사설 IP 또는 외부에서 접근이 가능하지 않는 주소를 입력하면 기능이 정상적으로 동작하지 않습니다. 

(5) Save를 클릭합니다. 아래와 같이 Application ID와 Secret가 생성된 것을 확인할 수 있습니다.  

![](/assets/Integrate_your_server_with_GitLab_com_2.png)  


**자신의 GitLab Server에서의 설정**  

GitLab configuration file을 편집합니다.  
```
$ sudo vim /etc/gitlab/gitlab.rb
```
OmniAuth Settings로 이동하여, 아래 내용을 추가합니다.  
name: gitlab을 표기해 주세요.
app_id: 위의 _GitLab.com에서의 설정_ 에서 Save를 하였을 때 생성된 ID 입니다.  
app_secret: 위의 _GitLab.com에서의 설정_ 에서 Save를 하였을 때 생성된 Secret 입니다.  
args: 아래와 같이 입력해 주세요.

```
 gitlab_rails['omniauth_providers'] = [
   {
     "name" => "gitlab",
     "app_id" => "46d5a912d28f01c13599e11d6c3206870cd5ab962427841ad87739271aa363f7",
     "app_secret" => "53d4dabba8d1fe2ec8ab17afa6008a1e2a565e81dd755bcd3c6dd1624161aa13",
     "args" => { "access_type" => "offline", "approval_prompt" => "", "scope" => "api" }
   }
 ]

```

저장한 후, GitLab 서버를 재구동합니다.  
```
$ sudo gitlab-ctl reconfigure  
# sudo gitlab-ctl restart  
```

**My GitLab Server에서 intgration 실행하기**  
나의 GitLab서버에 재접속합니다.  
아래와 같은 GitLab.com 아이콘이 생긴 것을 확인할 수 있습니다.  
![](/assets/Integrate_your_server_with_GitLab_com_3.png)  

LDAP로 본인 계정으로 로그인합니다. Create Project를 클릭합니다.  
![](/assets/Integrate_your_server_with_GitLab_com_4.png)  

Import project 탭을 클릭한 후, GitLab.com을 선택합니다.  
![](/assets/Integrate_your_server_with_GitLab_com_5.png)  

아래와 같은 GitLab.com에 본인이 가진 Project list를 볼 수 있습니다. Import 하려는 프로젝트의 status에서 Import를 클릭하면 My GitLab Server에 소스가 import 됩니다.  
![](/assets/Integrate_your_server_with_GitLab_com_6.png)  