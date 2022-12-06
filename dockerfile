# Path: dockerfile
# from jdk:8
# FROM fabric8/java-alpine-openjdk8-jdk:latest
FROM openjdk:8u302-jdk

LABEL maintainer="yangyf yangyf83@aliyun.com"

# change apt source and install python2, change pip source
RUN apt-get update && apt-get -y install python2 && curl -o get-pip.py https://bootstrap.pypa.io/pip/2.7/get-pip.py && python2 get-pip.py && apt-get install -y git && pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone

# add python2.7 to path
ENV PATH /usr/bin/python2.7:$PATH
# set JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

# expose to port 2233
EXPOSE 2233 2233

# mount this directory to the container
VOLUME /tmp
