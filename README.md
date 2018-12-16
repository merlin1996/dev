# dev
debian development environment with ssh access and use of docker host environment

Installed: docker cli, docker-compose cli, rancher cli, azure cli

Midnight Commander and nano included. Change root password in Dockerfile before building image or after container started. Mount volume at /root

Don't use in production. For development environment only



Example call:

docker run -d -p 2222:22 -v /var/run/docker.sock:/var/run/docker.sock -v /mnt/data/dev01:/root merlin96/dev:latest

ssh root@192.168.1.1 -p 2222



outdated, do not use
