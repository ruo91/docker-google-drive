#
# Dockerfile - Google Drive
#
# - Build
# docker build --rm -t google:drive .
#
# - Run
# docker run -d --name="google-drive" -h "google-drive" -v /google-drive:/google-drive google:drive
#
# - SSH
# ssh `docker inspect -f '{{ .NetworkSettings.IPAddress }}' google-drive`
#
# Use the base images
FROM ubuntu:15.04
MAINTAINER Yongbok Kim <ruo91@yongbok.net>

# Change the repository
RUN sed -i 's/archive.ubuntu.com/ftp.jaist.ac.jp/g' /etc/apt/sources.list

# The last update and install package for Ocaml Fuse
RUN apt-get update && apt-get install -y software-properties-common python-software-properties supervisor

# Variable
ENV SRC_DIR /opt
WORKDIR $SRC_DIR

# Grive
RUN add-apt-repository ppa:nilarimogard/webupd8  \
 && apt-get update && apt-get install -y grive

# Grive scripts && OAuth JSON
ADD conf/grive.sh /bin/grive.sh
ADD *.json /opt/google-drive.json
RUN chmod a+x /bin/grive.sh

# Supervisor
RUN mkdir -p /var/log/supervisor
ADD conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Daemon
CMD ["/usr/bin/supervisord"]