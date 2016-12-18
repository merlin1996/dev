# dev
ubuntu development environment with ssh access and use of docker host environment

Midnight Commander and nano included. Change root password in Dockerfile before building image. Mount volume at /srv

Don't use in production. For development environment only



Example call:

docker run -d -p 2222:22 -v /var/run/docker.sock:/var/run/docker.sock -v /srv:/srv merlin96/dev:latest

ssh root@192.168.1.1 -p 2222
