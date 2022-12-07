# Path: dockerfile
# FROM fabric8/java-alpine-openjdk8-jdk:latest
# FROM openjdk:8u302-jdk

FROM ubuntu:16.04

LABEL maintainer="yangyf yangyf83@aliyun.com"

# move deb file to /tmp
COPY ./datalog/pa-datalog_0.5-1xenial.deb /tmp/pa-datalog_0.5-1xenial.deb

# 构建 jdk 8 环境
# change apt source and install python2, change pip source
# RUN sed -i "s@http://.*archive.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list && sed -i "s@http://.*security.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list && 

RUN apt-get update && apt-get install -y python-pip openjdk-8-jdk vim curl git &&  \
    apt-get install -y libtcmalloc-minimal4 libgoogle-perftools4 protobuf-compiler libprotobuf-dev \
    libprotobuf-java libboost-date-time1.58.0 libboost-filesystem1.58.0 libboost-iostreams1.58.0 \
    libboost-program-options1.58.0 libboost-date-time1.58.0 libboost-system1.58.0 libboost-thread1.58.0 \
    libcppunit-1.13-0v5 realpath libboost-regex1.58.0
# && pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/ \simple 

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone && \
    dpkg -i /tmp/pa-datalog_0.5-1xenial.deb || apt-get install -y -f

RUN echo "source /opt/lb/pa-datalog/lb-env-bin.sh" >> ~/.bashrc
# RUN source /opt/lb/pa-datalog/lb-env-bin.sh

# add python2.7 to path
#ENV PATH /usr/bin/python2.7:$PATH
# set JAVA_HOME
#ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
## set BASH_SOURCE
#ENV BASH_SOURCE /root/.bashrc
## set LOGICBLOX_HOME
#ENV LOGICBLOX_HOME /opt/lb/pa-datalog/logicblox

#ENV LC_ALL C.UTF-8
# expose to port 2233
#EXPOSE 2233 2233

# mount this directory to the container
VOLUME /tmp

#ENTRYPOINT source /opt/lb/pa-datalog/lb-env-bin.sh
#ENTRYPOINT cd /home/project zipper
