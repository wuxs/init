#!/usr/bin/env bash

NS="$1"
IP=`kubectl get svc -n $NS $NS |grep "ClusterIP" |awk '{print $3}'`

kubectl get secret -n $NS vc-$NS -o jsonpath="{.data.config}" |base64 -d  > $1.config
sed -i "s/localhost:8443/$IP:443/" $1.config

