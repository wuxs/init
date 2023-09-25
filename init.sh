#!/bin/bash

echo "install inputrc..."
curl https://init.wuxs.vip/inputrc --output ~/.inputrc -s

echo "Please log in again to make inputrc take effect."
echo ""

read -p "是否安装Kubernetes？(y/n，默认为n): " answer

if [[ "$answer" == "y" ]]; then
    echo "执行Kubernetes安装操作..."
    curl https://init.wuxs.vip/kubesphere.sh -s | bash
else
    echo "不安装Kubernetes."
fi

