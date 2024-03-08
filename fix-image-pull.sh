#!/bin/bash

runtime="docker"

if command -v docker &> /dev/null
then
  runtime="docker"
else
  runtime="crictl"
fi

# 使用 kubectl 命令获取所有 Pod 的信息，并筛选出状态为 ImagePullBackOff 的 Pod
kubectl get pods --all-namespaces -o=jsonpath='{range .items[*]}{.metadata.namespace}{"\t"}{.metadata.name}{"\t"}{.status.containerStatuses[*].state.waiting.reason}{"\n"}{end}' | grep ImagePullBackOff | while IFS=$'\t' read -r namespace pod reason; do
    # 获取镜像名称列表
    images=$(kubectl get pod $pod -n $namespace -o=jsonpath='{range .spec.containers[*]}{.image}{"\n"}{end}')
    
    # 遍历处理每个镜像
    while IFS= read -r image; do
        echo "Image <$image> ImagePullBackOff, pull image with proxy docker.wuxs.workers.dev"
        image_name=$(echo $image | cut -d':' -f1)
        image_tag=$(echo $image | cut -d':' -f2)
        echo "$runtime pull docker.wuxs.workers.dev/$image_name:$image_tag"
        bash -c "$runtime pull docker.wuxs.workers.dev/$image_name:$image_tag"
        echo "$runtime tag docker.wuxs.workers.dev/$image_name:$image_tag $image"
        bash -c "$runtime tag docker.wuxs.workers.dev/$image_name:$image_tag $image"
    done <<< "$images"
done
