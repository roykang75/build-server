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
`
![](/assets/phpLDAPadmin_jenkins_user_1.png)  

**2. GitLab과 openLDAP 연동**  
"3. GitLab 설치 (docker)" 을 진행하였으면 GitLab과 openLDAP 서버간 연동은 완료된 것입니다.  

**3. Build-pf-pro**  
"5. build-pf-pro 설치 for Jenkins (docker)" 을 진행하였으면 GitLab/Jenkins와 연동할 기본 준비는 된 것입니다.

**4. GitLab**  
pettra 계정으로 로그인합니다.  
