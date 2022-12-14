#! /bin/bash
sed -i '/^#\{0,1\}net.ipv4.ip_forward/c\net.ipv4.ip_forward = 1' /etc/sysctl.conf
sudo sysctl -p | grep ip_forward

sed -i '/^hosts/c\hosts:          dns files mdns4_minimal [NOTFOUND=return]' /etc/nsswitch.conf
cat /etc/nsswitch.conf

curl https://get.docker.com | bash

wget https://github.com/kubeedge/kubeedge/releases/download/v1.12.1/keadm-v1.12.1-linux-amd64.tar.gz && tar zxvf keadm-v1.12.1-linux-amd64.tar.gz && chmod +x keadm-v1.12.1-linux-amd64/keadm/keadm && mv keadm-v1.12.1-linux-amd64/keadm/keadm /usr/local/bin && rm -r keadm-v1.12.1-linux-amd64.tar.gz keadm-v1.12.1-linux-amd64
