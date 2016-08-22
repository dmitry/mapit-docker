FROM debian:jessie
MAINTAINER Matthew Landauer <matthew@oaf.org.au>

RUN apt-get update

# Set the locale so that postgres is setup with the correct locale
#RUN apt-get install -y language-pack-en
#RUN apt-get update && apt-get install -y locales && locale-gen en_US.UTF-8
RUN apt-get update && apt-get install -y locales && localedef -i en_US -f UTF-8 en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# We install postgres now so that it can be running when the install script is used
RUN apt-get install -y postgresql-9.4 postgresql-server-dev-9.4

ADD https://github.com/mysociety/commonlib/raw/master/bin/install-site.sh /install-site.sh
RUN service postgresql restart; chmod +x /install-site.sh && /bin/bash /install-site.sh --default mapit mapit localhost
RUN rm /install-site.sh

# Install Supervisor to manage multiple processes running in the docker container
RUN apt-get install -y supervisor
RUN mkdir -p /var/run/postgresql /var/run/nginx /var/run/mapit /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Turn debug off so we don't run out of memory during imports
RUN sed 's/DEBUG: True/DEBUG: False/' /var/www/mapit/mapit/conf/general.yml > /var/www/mapit/mapit/conf/general2.yml; mv /var/www/mapit/mapit/conf/general2.yml /var/www/mapit/mapit/conf/general.yml

# unzip and ogr2ogr are handy for dealing with boundary data. So, installing now.
RUN apt-get install -y unzip gdal-bin

# Cleanup. This is only really truly going to be useful if we flatten this image so that we
# remove intermediate images
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80
CMD ["/usr/bin/supervisord"]
