FROM httpd:2.4.48

# install required packages
RUN apt-get update && apt-get install -y wget

# copy scripts
RUN echo "**** Copy scripts"
COPY ./refresh.sh /root/refresh.sh
RUN chmod 755 /root/refresh.sh
COPY ./entrypoint.sh /root/entrypoint.sh
RUN chmod 755 /root/entrypoint.sh

# first repo update
RUN echo "**** Mirror focal"
RUN cd /root && wget --recursive --level=100 --no-verbose --no-parent http://archive.ubuntu.com/ubuntu/dists/focal/ || echo "done"
RUN mv /root/archive.ubuntu.com/ubuntu /usr/local/apache2/ubuntu

# entrypoint : start update script & apache
ENTRYPOINT /root/entrypoint.sh