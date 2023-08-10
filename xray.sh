#!/bin/bash

CONFIG='{
    "inbounds": [
        {
            "port": 32345,
            "protocol": "shadowsocks",
            "settings": {
                "clients": [
                    {
                        "password": "",
                        "method": "aes-256-gcm"
                    }
                ],
                "network": "tcp,udp"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}'

IP=$(curl -s https://api.ipify.org)

PASSWORD=$(openssl rand -base64 12 | tr -d '+/=' | cut -c1-16)

FILE="/usr/local/etc/xray/config.json"

apt update && apt install unzip -y

bash <(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh) install

echo $CONFIG | sed 's/"password": ""/"password": "'$PASSWORD'"/' > $FILE

OUTPUT='{
    "name": "Node",
    "host": "'$IP'",
    "remotePort": 32345,
    "password": "'$PASSWORD'",
    "method": "aes-256-gcm"
}'

service xray restart

echo $OUTPUT
