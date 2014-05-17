FROM     ubuntu:latest
MAINTAINER Stefan Wolf "wolfs@fs.tum.de"

RUN apt-get install -y software-properties-common
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN apt-get install -y oracle-java7-installer

RUN apt-get install -y openssh-server
RUN adduser --quiet jenkins
RUN echo "jenkins:jenkins" | chpasswd
RUN mkdir /var/run/sshd 
RUN echo 'root:jenkins' | chpasswd
RUN apt-get clean
RUN rm -rf /var/cache/oracle-jdk7-installer

EXPOSE 3333
CMD    /usr/sbin/sshd -D -p 3333
