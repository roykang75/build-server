# 이미지 릴리즈

## 7. 이미지 릴리즈 프로세스
이미지 릴리즈 프로세스는 다음과 같습니다.  

(1) manifest.git에 새로 추가할 버전의 xml 추가  
(2) gitlab.com 에 TAG 추가  
(3) 추가한 버전의 xml을 이용하여 소스 받기  
(4) 이미지 빌드  


**manifest.git에 새로 추가할 버전의 xml 추가**  
릴리즈 버전용 xml 을 추가하기 위해 manifest.git을 clone합니다.  
아래와 같이 기존에 릴리즈한 xml 파일이 있는 것을 볼 수 있습니다.  
```
$ git clone git@gitlab.com:pettra/android/platform/manifest.git -b master-pf
$ cd manifest
$ ll
합계 568
drwxrwxr-x 3 roy roy  4096  6월  4 12:03 ./
drwxrwxr-x 5 roy roy  4096  6월  4 12:03 ../
drwxrwxr-x 8 roy roy  4096  6월  4 12:03 .git/
-rw-rw-r-- 1 roy roy  1561  6월  4 12:03 README.md
-rw-rw-r-- 1 roy roy 52254  6월  4 12:03 default-fa.xml
-rw-rw-r-- 1 roy roy 37086  6월  4 12:03 default.xml
-rw-rw-r-- 1 roy roy 57374  6월  4 12:03 pf-pro-common-v0.0.1.xml
-rw-rw-r-- 1 roy roy 57374  6월  4 12:03 pf-pro-common-v0.0.2.xml
-rw-rw-r-- 1 roy roy 57374  6월  4 12:03 pf-pro-common-v0.1.0.xml
-rw-rw-r-- 1 roy roy 57533  6월  4 12:03 pf-pro-common-v0.1.1.xml
-rw-rw-r-- 1 roy roy 57361  6월  4 12:03 pf-pro-common-v0.1.2.xml
-rw-rw-r-- 1 roy roy 37112  6월  4 12:03 pf-pro-common-v0.1.3.xml
-rw-rw-r-- 1 roy roy 37112  6월  4 12:03 pf-pro-common-v0.1.4.xml
-rw-rw-r-- 1 roy roy 37234  6월  4 12:03 pf-pro-common-v0.1.5.xml
-rw-rw-r-- 1 roy roy 37234  6월  4 12:03 pf-pro-common-v0.1.6.xml
```

만약 0.1.7 버전의 릴리즈 준비를 한다고 하면 다음과 같이 진행하면 됩니다.  
먼저 0.1.6 버전의 xml 파일을 0.1.7 버전용으로 복사합니다.  

```
$ cp pf-pro-common-v0.1.6.xml pf-pro-common-v0.1.7.xml
```

pf-pro-common-v0.1.7.xml 파일을 편집합니다.  

```
$ vim pf-pro-common-v0.1.7.xml
```

실제 주목해야 하는 부분은 아래 내용입니다.  

```
......................

  <!-- No Tag -->

  <project path="frameworks/base" name="platform/frameworks/base" groups="pdk" remote="pettra_aosp" revision="refs/tags/pf-pro-common-v0.1.6" />

  <!-- GPS for Pettra -->
  <project path="hardware/ublox/gps" name="platform/hardware/ublox/gps" groups="ublox_gps" remote="pettra_aosp" revision="refs/tags/pf-pro-common-v0.1.6" />
  <!-- Devices for Pettra -->
  <project path="hardware/dogtra" name="platform/hardware/dogtra" groups="dogtra" remote="pettra_aosp" revision="refs/tags/pf-pro-common-v0.1.6" />

  <!-- Bootloader and kernel for Pettra -->
  <project path="linux/bootloader/u-boot-2014.07" name="platform/nexell_linux/u-boot" groups="device" remote="pettra_aosp" revision="refs/tags/pf-pro-common-v0.1.6" />
  <project path="linux/kernel/kernel-3.4.39" name="platform/nexell_linux/linux" groups="device" remote="pettra_aosp" revision="refs/tags/pf-pro-common-v0.1.6" />

  <project path="device/nexell/tools" name="device/nexell/tools" groups="device" remote="pettra_aosp" revision="refs/tags/pf-pro-common-v0.1.6" >
          <linkfile src="ReadMe" dest="ReadMe" />
  </project>

  <project path="device/nexell/s5p6818_rookie" name="device/nexell/s5p6818_rookie" groups="device" remote="pettra_aosp" revision="refs/tags/pf-pro-common-v0.1.6" />

```

위 내용 중 한개의 git 정보를 분석해 보겠습니다.  
```
<project path="frameworks/base" name="platform/frameworks/base" groups="pdk" remote="pettra_aosp" revision="refs/tags/pf-pro-common-v0.1.6" />
```

명칭 | 설명
----|------
path | local PC에 저장되는 위치
name | remote PC(gitlab.com) 에 저장되는 위치
group | 그룹
remote | remote repo 위치. 소스를 push 할 때 사용
revision | 해당 git의 버전 정보

위 내용 중 버전 정보에 해당하는 revision="refs/tags/pf-pro-common-v0.1.6" 를 revision="refs/tags/pf-pro-common-v0.1.7" 로 변경합니다.  

모두 변경이 끝나면 저장합니다.  


**gitlab.com 에 TAG 추가**  
버전 정보(revision) 를 변경한 git에 TAG를 설정하는 작업을 진행합니다.  

아래의 git을 기준으로 설명을 진행하겠습니다.  
```
<project path="frameworks/base" name="platform/frameworks/base" groups="pdk" remote="pettra_aosp" revision="refs/tags/pf-pro-common-v0.1.6" />
```

http://www.gitlab.com 에 접속합니다.  
"Project"를 클릭하고, "Your projects"를 선택합니다.  
![](/assets/gitlab_tag_1.png)  

위의 name 속성을 보면 "platform/frameworks/base" 입니다. 이는 위에서 설명하였듯이 remote PC(git server or gitlab)의 저장 위치를 의미합니다.
그룹에서 위치를 찾아봅니다. 이 프로젝트 git tree의 최상단은 "pettra/android" 입니다. 그 이하에서 "platform/frameworks/base"를 찾습니다. 
최상단의 정보는 pf-pro-common-v0.1.7.xml 의 상단에서 확인할 수 있습니다.  
```
<remote name="pettra_aosp"
        fetch="ssh://git@gitlab.com/pettra/android" />
```

![](/assets/gitlab_tag_2.png)  

위의 이미지에 보면 "frameworks/opt"만 보이고 "frameworks/base"는 보이지 않습니다.  
이런 경우에는 "frameworks" 를 클릭하면 내부의 정보가 나타납니다.  "frameworks"를 클릭합니다.  
![](/assets/gitlab_tag_3.png)  

이미지를 보면 "base"가 보이는 것을 확인할 수 있습니다.  
"base"를 클릭합니다.  

다음은 "frameworks/base"의 git 정보입니다.  
![](/assets/gitlab_tag_4.png)  

TAG를 태깅하기 위해서는 TAG 설정화면으로 이동해야 합니다. 아래 이미지의 빨간색 표시대로 선택을 합니다.  
![](/assets/gitlab_tag_5.png)  

아래 이미지를 보면 "frameworks/base"에 태깅된 TAG들을 볼 수 있습니다. 
![](/assets/gitlab_tag_6.png)  

새로운 TAG를 태깅하기 위해서는 [New tag] 버튼을 클릭합니다.  
![](/assets/gitlab_tag_7.png)  

아래 화면은 태깅을 하기 위한 화면입니다. Tag name에는 "pf-pro-common-v0.1.7"을 입력합니다. Create from은 "master-pf"를 선택합니다.  
해당 git의 branch가 많은 경우 Create from의 리스트 박스를 누르면 생성된 branch를 확인할 수 있습니다.  
Message에는 남기고 싶은 comment를 남기면 됩니다.  
![](/assets/gitlab_tag_8.png)  

입력이 완료되었으면 [Create tag] 버튼을 클릭합니다.  

아래와 같이 태깅이 된것을 확인할 수 있습니다.  

[ 이미지 ]

**추가한 버전의 xml을 이용하여 소스 받기**  
수정한 git 들에 모두 태깅이 완료되면 v0.1.7에 대한 소스를 받아야 합니다.  
PF-Pro의 master-pf 브랜치의 특정 버전의 소스를 받을 때는 다음과 같은 명령을 사용합니다.  
아래 예는 v0.1.7 버전 소스를 받는 예입니다.  
```
$ repo init -u ssh://git@gitlab.com/pettra/android/platform/manifest.git -b master-pf -m pf-pro-common-v0.1.7.xml
$ repo sync -j 8
$ repo start master-pf --all
```

위의 명령을 보면 "-m pf-pro-common-v0.1.7.xml" 부분을 제외하고는 current 소스를 받는 명령과 동일합니다.  
만약 각 git의 history가 필요하지 않는 경우에는 아래와 같은 명령을 사용합니다. 보통 빌드를 위하여 소스를 받는 경우 사용하는 방법입니다.  
```
$ repo init -u ssh://git@gitlab.com/pettra/android/platform/manifest.git -b master-pf -m pf-pro-common-v0.1.7.xml --depth=1
$ repo sync -j 8 --no-tags
$ repo start master-pf --all
```

**이미지 빌드**  
이미지의 빌드 방법은 아래와 같습니다.  
```
# 소스를 받은 위치로 이동한 후, 아래 명령을 실행합니다.
$ ./device/nexell/tools/build.sh -b s5p6818_rookie
```
