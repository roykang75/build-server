# Docker for android 5.1 build environment

**MAKE Docker image**  
```
docker build --tag rookie-build-env:0.1 .
```

**Docker Run**  
```
docker run -it --name rookie-build-env --restart always --volume /home/roy:/home/roy --volume /etc/passwd:/etc/passwd --volume /data/work/src:/work/src --volume /etc/localtime:/etc/localtime:ro rookie-build-env:0.1
```

**Build account**  
docker image에서 생성한 계정과 Machine의 ubuntu의 계정의 UID/GID가 동일하도록 한다.  
```
$ sudo cat /etc/passwd
...
roy:x:1000:1000:roy,,,:/home/roy:/bin/bash
...
```
**Build android using docker rookie-build-env:0.1**  
roy 계정의 UID가 1000 일때, 아래와 같이 명령을 내리면 roy 계정으로 로그인하여 build.sh를 실행한다.
```
docker exec -u 1000 -it rookie-build-env bash /work/src/pf-pro-r/run_build.sh
````

**run_build.sh**
```
#!/bin/bash

cd /work/src/pf-pro
if [ -d .repo ]; then
	repo forall -c 'pwd; git clean -xdf; git reset HEAD --hard'
else
	echo "There is no repo"
	exit -1;
fi

echo "rm -rf out"
rm -rf out

#repo init -u ssh://git@gitlab.rbtree.com/pettra/android/platform/manifest.git -b master-pf -b --depth=1
repo init -u ssh://git@gitlab.com/pettra/android/platform/manifest.git -b master-pf --depth=1

repo sync -c -j20 --no-tags

device/nexell/tools/build.sh -b s5p6818_rookie
```
