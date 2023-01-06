#!/usr/bin/env bash


[ ! -f /etc/kubeedge/config/edgecore.yaml.bak ] && cp /etc/kubeedge/config/edgecore.yaml /etc/kubeedge/config/edgecore.yaml.bak


service edgecore stop

sed -re "s/300[0-9]([0-4])/300$1\1/g" /etc/kubeedge/config/edgecore.yaml > /tmp/edgecore.yaml
cp /tmp/edgecore.yaml  /etc/kubeedge/config/edgecore.yaml
sed -re "s/token.+/token: $2/g"  /etc/kubeedge/config/edgecore.yaml > /tmp/edgecore.yaml
cp /tmp/edgecore.yaml  /etc/kubeedge/config/edgecore.yaml

rm  /var/lib/kubeedge/edgecore.db
rm  /etc/kubeedge/ca/*
rm  /etc/kubeedge/certs/*

service edgecore start
