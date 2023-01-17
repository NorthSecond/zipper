# Path: dockerfile
# Brief: This is a Dockerfile for building a container with the latest version of the OpenJDK 8 JDK.
# To build this image, please read the run-with-docker.md file in the root of this repository.

FROM ubuntu:16.04

LABEL maintainer="yfyang yangyf83@aliyun.com"

# move deb file to /tmp
COPY ./datalog/pa-datalog_0.5-1xenial.deb /tmp/pa-datalog_0.5-1xenial.deb

# if need change apt source
# RUN sed -i "s@http://.*archive.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list && sed -i "s@http://.*security.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list && 

# install the packages
RUN apt-get update && apt-get install -y python-pip openjdk-8-jdk vim curl git libtcmalloc-minimal4 \
    libgoogle-perftools4 protobuf-compiler libprotobuf-dev libprotobuf-java libboost-date-time1.58.0  \
    libboost-filesystem1.58.0 libboost-iostreams1.58.0 libboost-program-options1.58.0 libboost-date-time1.58.0  \
    libboost-system1.58.0 libboost-thread1.58.0 libcppunit-1.13-0v5 realpath libboost-regex1.58.0 bc 
    # && pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/ \simple 

# from the deb install pa-datalog
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone && \
    dpkg -i /tmp/pa-datalog_0.5-1xenial.deb || apt-get install -y -f

# write the shell script to bashrc
RUN echo "source /opt/lb/pa-datalog/lb-env-bin.sh" >> ~/.bashrc

# expose to port 2333, used for IDEs to connect to the container
#EXPOSE 2333 2333

# mount this directory to the container
# when you run the container, you can use -v to mount the directory
VOLUME /home/project

#ENTRYPOINT source /opt/lb/pa-datalog/lb-env-bin.sh
#ENTRYPOINT cd /home/project zipper
