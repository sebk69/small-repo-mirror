FROM ubuntu:20.04

RUN echo "deb http://repo/ubuntu/ focal main restricted universe multiverse" > /etc/apt/source.list
RUN echo "deb http://repo/ubuntu/ focal-updates main restricted universe multiverse" >> /etc/apt/source.list
RUN echo "deb http://repo/ubuntu/ focal-security main restricted universe multiverse" >> /etc/apt/source.list
RUN echo "deb http://repo/ubuntu/ focal-backports main restricted universe multiverse" >> /etc/apt/source.list
RUN echo "deb http://repo/ubuntu/ focal partner" >> /etc/apt/source.list

RUN apt-get update