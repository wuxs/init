#!/bin/bash

TOKEN=$1

# 安装依赖库 和Docker 20.10
apt update
apt install socat conntrack unzip -y

curl -fsSL https://get.docker.com -o install-docker.sh && sh install-docker.sh --version 20.10

# 配置Docker的cgroup_driver
cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"]
}
EOF

# 重启Docker
service docker restart

# 查看Docker cgroup_driver
docker info

# 下载yurtadm
wget https://github.com/openyurtio/openyurt/releases/download/v1.3.4/yurtadm-v1.3.4-linux-amd64.zip
unzip yurtadm-v1.3.4-linux-amd64.zip
install linux-amd64/yurtadm /usr/local/bin/


# 添加边缘节点
./yurtadm join 192.168.11.45:6443 --token=$TOKEN --node-type=edge --discovery-token-unsafe-skip-ca-verification --v=5
