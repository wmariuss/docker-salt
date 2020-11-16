FROM centos:7.6.1810

ENV SALT_VERSION=3002.1

ADD start.sh /bin/start.sh

RUN rpm --import https://repo.saltstack.com/py3/redhat/7/x86_64/archive/$SALT_VERSION/SALTSTACK-GPG-KEY.pub \
    && echo -e "[saltstack-repo]\nname=SaltStack repo for RHEL/CentOS\$releasever\nbaseurl=https://repo.saltstack.com/py3/redhat/\$releasever/\$basearch/archive/$SALT_VERSION\nenabled=1\ngpgcheck=1\ngpgkey=https://repo.saltstack.com/py3/redhat/\$releasever/\$basearch/archive/$SALT_VERSION/SALTSTACK-GPG-KEY.pub\n" > /etc/yum.repos.d/saltstack.repo \
    && yum install -y salt-minion epel-release sudo policycoreutils selinux-policy-targeted yum-plugin-ovl \
    && mkdir -p /etc/salt/minion.d \
    && echo -e "master: master" > /etc/salt/minion.d/masters.conf \
    && sed -i -e 's/#hash_type.*/hash_type: sha256/' /etc/salt/minion \
    # Fix getty consume 100% cpu
    && systemctl disable getty@tty1.service \
    # Fix systemd
    && yum install -y initscripts \
    && chkconfig salt-minion on \
    # Cleanup
    && rm -rf /var/lib/yum/* \
    && yum clean all

ENTRYPOINT ["/bin/start.sh"]
