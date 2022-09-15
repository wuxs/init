#! /bin/bash
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sudo sysctl -p | grep ip_forward

echo "hosts:          dns files mdns4_minimal [NOTFOUND=return]" >> /etc/nsswitch.conf
cat /etc/nsswitch.conf

curl https://get.docker.com |bash
