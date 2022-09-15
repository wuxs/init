#! /bin/bash

curl https://get.docker.com |bash

apt install socat conntrack ebtables ipset

export KKZONE=cn

curl -sfL https://get-kk.kubesphere.io | VERSION=v2.2.1 sh -

chmod +x kk

echo "./kk create cluster --with-kubernetes v1.22.10 --with-kubesphere v3.3.0"
