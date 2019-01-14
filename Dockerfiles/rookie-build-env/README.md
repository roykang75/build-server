# MAKE Docker image
docker build -t rookie-build-env .

docker run -it --name jenkins-rookie-build-env --restart always --volume /work/src/pf-pro:/work/src/pf-pro rookie-build-env:latest
