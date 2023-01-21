#!/usr/bin/env bash
# https://init.wuxs.vip/install-cloudcore-x.sh

if [ $# != 2 ];then
  echo 'use "bash install-cloudcore-x.sh x" to install cloudcore with ports 300x0-300x4. (x is a number between 0 and 9)'
  exit 1
fi

[ ! -d kubeedge ] && git clone https://github.com/kubeedge/kubeedge

[ ! -f kubeedge.values.yaml ] && wget https://init.wuxs.vip/kubeedge.values.yaml -O kubeedge.values.yaml

sed -re "s/300[0-9]([0-4])/300$1\1/g" kubeedge.values.yaml > temp.yaml

helm install cloudcore kubeedge/manifests/charts/cloudcore -f temp.yaml -n kubeedge --create-namespace
