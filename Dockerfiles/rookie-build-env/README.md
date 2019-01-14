# MAKE Docker image
docker build --tag rookie-build-env:0.1 .

docker run -it --name jenkins-rookie-build-env --restart always --volume /data/work/src:/work/src rookie-build-env:0.1
