#!/bin/bash
   
   
NoShedulePatchJson='{"spec":{"template":{"spec":{"affinity":{"nodeAffinity":{"requiredDuringSchedulingIgnoredDuringExecution":{"nodeSelectorTerms":[{"matchExpressions":[{"key":"node-role.kubernetes.io/edge","operator":"DoesNotExist"}]}]}}}}}}}'
   
ns="kube-system"


DaemonSets=("nodelocaldns" "kube-proxy" "calico-node")

length=${#DaemonSets[@]}
   
for((i=0;i<length;i++));  
do
         ds=${DaemonSets[$i]}
        echo "Patching resources:DaemonSet/${ds}" in ns:"$ns",
        kubectl -n $ns patch DaemonSet/${ds} --type merge --patch "$NoShedulePatchJson"
        sleep 1
done
