#! /bin/bash

apt update -y -qqq 2>/dev/null

apt install socat conntrack ebtables ipset -y -qqq 2>/dev/null

export KKZONE=cn

curl -sfL https://get-kk.kubesphere.io | sh -

chmod +x kk

./kk create cluster --with-kubernetes v1.22.10 --with-local-storage -y


# 获取部署文件
docker run --rm  -v /root/files:/root/files harbor.wuxs.vip/kubesphere/edgewize-files:v0.5.0 cp /files/* /root/files/

cd /root/files

# 安装 kse 的 vcluster
kubectl create ns  kse
helm install kse vcluster-0.14.2.tgz -n kse -f vcluster.values.yaml 

# 导出 kse vcluster 中的 kubeconfig 
NAMESPACE=kse bash getvclusterkubeconfig.sh

# 指定 kubeconfig
# export KUBECONFIG=`pwd`/kse.vcluster.config
# unset KUBECONFIG
# --kubeconfig kse.vcluster.config

# 安装 kse
kubectl apply -f kubesphere-installer.yaml --kubeconfig kse.vcluster.config
kubectl apply -f cluster-configuration.yaml --kubeconfig kse.vcluster.config

# 查看 ks-installer 日志
kubectl logs -n kubesphere-system $(kubectl get pod -n kubesphere-system -l 'app in (ks-install, ks-installer)' -o jsonpath='{.items[0].metadata.name}') -f

# 安装 edgewize 
kubectl create ns edgewize-system --kubeconfig kse.vcluster.config
helm install edgewize edgewize-v0.4.2.tgz -f edgewize.values.yaml -n edgewize-system --kubeconfig kse.vcluster.config


# 模拟三个命名空间，创建对应权限，并获取 kubeconfig
kubectl create ns test1
kubectl apply -f admin.yaml -n test1
NAMESPACE=test1 bash getadminkubeconfig.sh

kubectl create ns test2
kubectl apply -f admin.yaml -n test2
NAMESPACE=test2 bash getadminkubeconfig.sh

kubectl create ns test3
kubectl apply -f admin.yaml -n test3
NAMESPACE=test3 bash getadminkubeconfig.sh


# 将三个命名空间的 kubeconfig 写入 edgewize-namespaces-config 中
kubectl create configmap edgewize-namespaces-config -n edgewize-system --from-file=test1=test1.admin.config --from-file=test2=test2.admin.config --from-file=test3=test3.admin.config --dry-run -o yaml |kubectl apply --kubeconfig kse.vcluster.config  -f -

