#!/bin/bash

# 获取远程IP参数
remote_ip=$1

# 本地临时目录
local_temp_dir="/tmp"

# 生成随机的临时文件名
filename=$(date +%s%N | sha256sum | base64 | head -c 12 ; echo)

# 复制远程环境的~/.kube/config文件到本地临时目录
scp root@$remote_ip:~/.kube/config $local_temp_dir/$filename

sed -i "s/lb.kubesphere.local/$remote_ip/g" $local_temp_dir/$filename

# 执行kubecm add命令添加新的上下文
kubecm add -f $local_temp_dir/$filename --context-name=$remote_ip -c=true

# 删除临时文件
rm $local_temp_dir/$filename
