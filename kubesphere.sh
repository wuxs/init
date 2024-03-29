#! /bin/bash

apt install socat conntrack ebtables ipset -y -qqq 2>/dev/null

export KKZONE=cn

curl -sfL https://get-kk.kubesphere.io | sh -

chmod +x kk

echo "./kk create cluster --with-kubernetes v1.22 --with-kubesphere v3.3.0"
