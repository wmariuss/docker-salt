FROM ubuntu:bionic-20200921

ENV SALT_VERSION=3002.1
ENV DEBIAN_FRONTEND=noninteractive

ADD start.sh /bin/start.sh

RUN apt-get update \
    && apt-get install -y vim-nox curl gnupg2 \
    && curl -L https://repo.saltstack.com/py3/ubuntu/18.04/amd64/archive/${SALT_VERSION}/SALTSTACK-GPG-KEY.pub | apt-key add - \
    && echo "deb http://repo.saltstack.com/py3/ubuntu/18.04/amd64/archive/${SALT_VERSION} bionic main" > /etc/apt/sources.list.d/saltstack.list \
    && apt-get update \
    && apt-get install -y libdbus-1-3 libnih-dbus1 sudo software-properties-common python-pip kmod iputils-ping apt-transport-https debian-archive-keyring systemd \
    && apt-get install -y salt-minion \
    && apt-get install -y salt-master \
    && mkdir -p /etc/salt/minion.d \
    && echo "master: master" > /etc/salt/minion.d/masters.conf \
    && sed -i -e 's/#hash_type.*/hash_type: sha256/' /etc/salt/minion \
    # Remove libexpat1-dev
    && apt-get -y purge libexpat1-dev \
    # salt-api configuration
    && sed -i -e 's/#default_include.*/default_include: master.d\/\*.conf/' /etc/salt/master \
    && sed -i -e 's/#user.*/user: root/' /etc/salt/master \
    && sed -i -e 's/#hash_type.*/hash_type: sha256/' /etc/salt/master \
    # Fix getty consume 100% CPU
    && systemctl disable getty@tty1.service \
    # Fix systemd
    && systemctl enable salt-master \
    && systemctl enable salt-minion \
    # Fix missing resolvconf
    && cd /tmp \
    && apt-get download resolvconf \
    && dpkg --unpack resolvconf_*_all.deb \
    && rm /var/lib/dpkg/info/resolvconf.postinst \
    && dpkg --configure resolvconf \
    && apt-get install -yf \
    && apt-mark hold resolvconf \
    # Cleanup
    && rm -rf /var/lib/apt/lists/* \
    && apt-get -y autoremove \
    && apt-get clean

EXPOSE 4505 4506

ENTRYPOINT ["/bin/start.sh"]
