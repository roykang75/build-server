# MAKE Docker image
```
docker build --tag rookie-build-env:0.1 .
```

**Docker run***
```
docker run -it --name rookie-build-env --restart always --volume /home/roy:/home/roy --volume /etc/passwd:/etc/passwd --volume /data/work/src:/work/src --volume /etc/localtime:/etc/localtime:ro rookie-build-env:0.1
```

```
$ sudo cat /etc/passwd
...
roy:x:1000:1000:roy,,,:/home/roy:/bin/bash
...
```

아래 처럼하면 docker 접속을 roy로 할 수 있음.

docker exec -u 1000 -it rookie-build-env bash /work/src/pf-pro-r/build.sh

# build.sh
```
work/src/pf-pro-r$ cat build.sh
#!/bin/bash
cd /work/src/pf-pro-r
bash device/nexell/tools/build.sh -b s5p6818_rookie
```
