# sshd
#
# VERSION               0.0.1

FROM     ubuntu:latest
MAINTAINER Stefan Wolf "stefan.wolf@tngtech.com"

# RUN apt-get install -y software-properties-common
# RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
# RUN add-apt-repository -y ppa:webupd8team/java
# RUN apt-get update
# RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
# RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
# RUN apt-get install -y oracle-java7-installer

RUN apt-get update
RUN apt-get install -y wget
WORKDIR /opt
# RUN wget -nv --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u55-b13/jdk-7u55-linux-x64.tar.gz -O - | tar -zxf-
ADD jdk-7u55-linux-x64.tar.gz /opt
RUN chown -R root:root /opt/jdk1.7.0_55
RUN ln -s /opt/jdk1.7.0_55/ /opt/java

# make sure the package repository is up to date

RUN apt-get install -y openssh-server
RUN adduser --quiet jenkins
RUN echo "jenkins:jenkins" | chpasswd
RUN mkdir /var/run/sshd 
RUN echo 'root:jenkins' |chpasswd
RUN apt-get clean

EXPOSE 3333
CMD    /usr/sbin/sshd -D -p 3333
