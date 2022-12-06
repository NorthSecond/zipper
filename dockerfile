# Path: dockerfile
# from jdk:8
# FROM fabric8/java-alpine-openjdk8-jdk:latest
FROM openjdk:8u302-jdk

LABEL maintainer="yangyf yangyf83@aliyun.com"

# move deb file to /tmp
COPY ./datalog/pa-datalog_0.5-1bionic.deb /tmp/pa-datalog_0.5-1bionic.deb

# change apt source and install python2, change pip source
RUN apt-get update && apt-get install -y vim && apt-get -y install python2 && \
 curl -o get-pip.py https://bootstrap.pypa.io/pip/2.7/get-pip.py  && python2 get-pip.py && \
 apt-get install -y git && pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/ \simple && \
 dpkg -i /tmp/pa-datalog_0.5-1bionic.deb || apt-get install -y -f

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone

# add python2.7 to path
ENV PATH /usr/bin/python2.7:$PATH
# set JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
# set BASH_SOURCE
ENV BASH_SOURCE /root/.bashrc
# set LOGICBLOX_HOME
ENV LOGICBLOX_HOME /opt/lb/pa-datalog/logicblox
ENV LC_ALL C.UTF-8
# expose to port 2233
EXPOSE 2233 2233

# mount this directory to the container
VOLUME /tmp
#
#ENTRYPOINT source /opt/lb/pa-datalog/lb-env-bin.sh
