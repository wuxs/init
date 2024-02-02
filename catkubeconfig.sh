IP=`cat /etc/hosts |grep lb.kubesphere.local |awk '{print $1}'`
sed "s/lb.kubesphere.local/$IP/" ~/.kube/config > /tmp/kubeconfig
sed "s/cluster.local/cluster.$IP.local/" /tmp/kubeconfig
