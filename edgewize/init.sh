#!/bin/bash

mkdir edgewize
cd edgewize
wget https://init.wuxs.vip/edgewize/vcluster.kse.yaml
wget https://init.wuxs.vip/edgewize/edgewize-installer-job.yaml


echo "1. 创建kse命名空间:"
echo "kubectl create ns kse"
echo "2. 安装 vcluster 到 kse 命名空间"
echo "kubectl apply -f vcluster.kse.yaml"
echo "3. 配置 edgewize-insatller-job.yaml"
echo "vim edgewize-insatller-job.yaml"
echo "4. 启动 edgewize installer"
echo "kubectl apply -f edgewize-installer-job.yaml -n kse"
echo "5. 查看安装日志"
echo "kubectl logs -n kse -f -l app=edgewize-installer"
