#!/bin/bash

# 该脚本使用ChatGPT生成
runtime="docker"
if command -v docker &> /dev/null
then
  runtime="docker"
else
  runtime="crictl"
  echo "当前环境未安装 Docker 将使用 crictl 拉取镜像"
fi

# 检查参数是否为空
if [ $# -eq 0 ]; then
    echo "Usage: $0 <image>"
    exit 1
fi

# 提取镜像名和标签
image=$1
image_name=$(echo $image | cut -d':' -f1)
image_tag=$(echo $image | cut -d':' -f2)

# 拉取镜像并重新命名
bash -c "$runtime pull docker.wuxs.workers.dev/$image_name:$image_tag"
bash -c "$runtime tag docker.wuxs.workers.dev/$image_name:$image_tag $image"
