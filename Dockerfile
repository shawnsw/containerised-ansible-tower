FROM ubuntu:xenial

LABEL maintainer="shawn.wang@redhat.com"

WORKDIR /tmp/tower-installer

# update and install packages
RUN apt-get update -y \
    && apt-get install software-properties-common curl vim locales sudo apt-transport-https ca-certificates -y

# install ansible
RUN apt-add-repository ppa:ansible/ansible-2.7 \
    && apt-get update -y \
    && apt-get install ansible -y

# Set the locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# define tower version and PG_DATA
ENV TOWER_VERSION 3.4.1-1
ENV PG_DATA /var/lib/postgresql/9.6/main

# download tower installer
RUN curl -sSL http://releases.ansible.com/ansible-tower/setup/ansible-tower-setup-${TOWER_VERSION}.tar.gz -o ansible-tower-setup-${TOWER_VERSION}.tar.gz \
    && tar xvf ansible-tower-setup-${TOWER_VERSION}.tar.gz \
    && rm -f ansible-tower-setup-${TOWER_VERSION}.tar.gz

# change working dir
WORKDIR /tmp/tower-installer/ansible-tower-setup-${TOWER_VERSION}

# create var folder
RUN mkdir /var/log/tower

# copy inventory
ADD inventory inventory

# install tower
RUN ./setup.sh

# add entrypoint script
ADD entrypoint.sh /entrypoint.sh

EXPOSE 80 443

# configure entrypoint
ENTRYPOINT [ "/bin/bash", "-c" ]
CMD [ "/entrypoint.sh" ]