FROM ubuntu:latest
# Install basics for work with docker and rancher
RUN apt-get update && apt-get install -y \
    docker.io \
    mc \
    nano \
    openssh-server \
    curl \
    && apt-get clean
  
# Use UTF-8 and not POSIX for frames in mc
RUN echo "export LANG=\"C.UTF-8\"" >> /root/.bashrc

# ssh stuff
RUN mkdir /var/run/sshd && \
    echo 'root:secretpw' | chpasswd && \
    sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd 
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Install docker compose
RUN curl -L "https://github.com/docker/compose/releases/download/1.9.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

# Install rancher cli
RUN wget -qO- https://github.com/rancher/cli/releases/download/v0.4.1/rancher-linux-amd64-v0.4.1.tar.gz | tar xvz -C /tmp && \
    mv /tmp/rancher-v0.4.1/rancher /usr/local/bin/rancher && \
    chmod +x /usr/local/bin/rancher

VOLUME /var/run/docker.sock /root

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
