FROM ubuntu:20.04

RUN echo "deb http://192.168.1.10:7000/ubuntu/ focal main restricted universe multiverse" > /etc/apt/sources.list
RUN echo "deb http://192.168.1.10:7000/ubuntu/ focal-updates main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://192.168.1.10:7000/ubuntu/ focal-security main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://192.168.1.10:7000/ubuntu/ focal-backports main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://192.168.1.10:7000/ubuntu/ focal partner" >> /etc/apt/source.list

RUN apt-get update && apt-get install -y vim && sleep 20