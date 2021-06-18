FROM httpd:2.4.48

# install required packages
RUN apt-get update && apt-get install -y wget procps

# copy scripts
RUN echo "**** Copy scripts"
COPY ./refresh.sh /root/refresh.sh
RUN chmod 755 /root/refresh.sh
COPY ./health.sh /root/health.sh
RUN chmod 755 /root/health.sh
COPY ./entrypoint.sh /root/entrypoint.sh
RUN chmod 755 /root/entrypoint.sh

# remove http index
RUN rm -f /usr/local/apache2/htdocs/index.html

# entrypoint : start update script & apache
ENTRYPOINT /root/entrypoint.sh