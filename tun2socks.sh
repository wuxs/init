#!/bin/bash


# init tun0
ip tuntap add mode tun dev tun0
ip addr add 198.18.0.1/15 dev tun0
ip link set dev tun0 up


# update route
ip route del default
ip route add default via 198.18.0.1 dev tun0 metric 1
ip route add default via 192.168.10.1 dev eth0 metric 10


# run tun2socks

# use tun0
tun2socks --device tun0 --proxy socks5://host:port -interface eth0

# auto create tun0
#tun2socks --device tun://tun0 --proxy socks5://host:port -interface eth0
