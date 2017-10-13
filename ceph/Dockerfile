FROM ceph/daemon:tag-stable-3.0-jewel-ubuntu-16.04

ADD etcceph/* /etc/ceph/
ADD scripts/* /usr/bin/
ADD entrypoint.sh /root/

ENTRYPOINT ["/root/entrypoint.sh"]
