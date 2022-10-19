#! /bin/bash
sed -i '/^#\{0,1\}net.ipv4.ip_forward/c\net.ipv4.ip_forward = 1' /etc/sysctl.conf
sudo sysctl -p | grep ip_forward

sed -i '/^hosts/c\hosts:          dns files mdns4_minimal [NOTFOUND=return]' /etc/nsswitch.conf
cat /etc/nsswitch.conf

curl https://get.docker.com | bash
