#!/bin/bash

# 该脚本使用ChatGPT生成

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
docker pull dockerproxy.com/$image_name:$image_tag
docker tag dockerproxy.com/$image_name:$image_tag $image
