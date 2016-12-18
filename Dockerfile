FROM ubuntu:latest
RUN apt-get update && apt-get install -y \
  docker.io \
  mc \
  nano \
  openssh-server
  
# Use UTF-8 and not POSIX for frames in mc
RUN echo "export LANG=\"C.UTF-8\"" >> /root/.bashrc

# ssh stuff
RUN mkdir /var/run/sshd
RUN echo 'root:secretpw' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

VOLUME /var/run/docker.sock /srv

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
