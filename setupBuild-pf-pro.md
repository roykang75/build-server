# build-pf-pro

## 5. build-pf-pro 설치

작업할 서버에서 아래 git을 clone 합니다.
```
git clone https://github.com/roykang75/build-dockerfiles.git
```

pettra-server-build-env 폴더로 이동합니다.  
아래 명령을 이용하여 pettra server build 이미지를 생성합니다.  
```
docker build --tag lollipop-build-env:0.1 .
```

**docker 명령어**  
서버의 /data/work 위치에 실제 소스를 받고 빌드할 계획입니다. docker에서 같은 소스를 공유하기 위해서 -v 옵션을 사용하여 docker의 /work 폴더와 연결합니다.  
```
$ docker run -it --name lollipop-build-env --restart always --volume /home/pettra:/home/pettra --volume /etc/passwd:/etc/passwd --volume /data/work:/work --volume /etc/localtime:/etc/localtime:ro lollipop-build-env:0.1
```

**SSH Key 생성**

ssh key를 생성합니다.  
```
$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/pettra/.ssh/id_rsa): 
Created directory '/home/pettra/.ssh'.
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/pettra/.ssh/id_rsa.
Your public key has been saved in /home/pettra/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:Vu5uFu2Op7/Y6TwqOjBklavD9PGyJ52G11yKaMlzlMU pettra@9782b558a2ad
The key's randomart image is:
+---[RSA 2048]----+
|       .         |
|      o          |
|     . . ..      |
|    + o  oE      |
|   = o oSo..     |
|    * o.+.. o    |
|     = O =.=     |
|      @ X.*=+.   |
|     ..X +*BOo   |
+----[SHA256]-----+
```

다음과 같이 개인키(id_rsa), 공개키(id_rsa.pub) 파일이 생성됩니다.  
```
$ ll ~/.ssh/id_rsa*
-rw------- 1 pettra pettra 1743 Sep  4 14:28 /home/pettra/.ssh/id_rsa
-rw-r--r-- 1 pettra pettra  390 Sep  4 14:28 /home/pettra/.ssh/id_rsa.pub
```

pettra 계정의 git config 정보를 입력합니다.  
```
$ git config --global user.name "pettra"
$ git config --global user.email "roykang75@gmail.com"
```

**GitLab에 SSH Key 등록**  
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

**모든 것이 올바르게 설정되었는지 테스트**  
SSH 키가 올바르게 추가되었는지 테스트하려면 터미널에서 다음 명령을 실행 gitlab.com하십시오 (GitLab의 인스턴스 도메인으로 대체 ).

```
$ ssh -T git@gitlab.com
```
처음 SSH를 통해 GitLab에 연결하면 연결할 GitLab 호스트의 진위 여부를 확인하라는 메시지가 나타납니다. 예를 들어, GitLab.com에 연결할 때 yes신뢰할 수있는 호스트 목록에 GitLab.com을 추가하세요.
```
The authenticity of host 'gitlab.com (35.231.145.151)' can't be established.
ECDSA key fingerprint is SHA256:HbW3g8zUjNSksFbqTiUWPWg2Bq1x8xdGUrliXFzSnUw.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'gitlab.com' (ECDSA) to the list of known hosts.
```

알려진 호스트 목록에 추가되면 GitLab 호스트의 진위 여부를 다시 확인하라는 메시지가 표시되지 않습니다. 한 번 더 위의 명령을 실행하면 다음과 같은 메시지가 출력됩니다.
```
$ ssh -T git@gitlab.com
Welcome to GitLab, @username!
```
