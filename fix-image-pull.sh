#!/bin/bash

runtime="docker"

if command -v docker &> /dev/null
then
  runtime="docker"
else
  runtime="crictl"
fi

complete_image_name() {
    local image_name="$1"
    
    # 检查镜像名称是否包含用户名
    if [[ $image_name != *"/"* ]]; then
        # 如果镜像名称中不包含斜杠，但包含冒号，添加默认的用户名 "library"
        if [[ $image_name == *":"* ]]; then
            image_name="library/$image_name"
        else
            # 如果镜像名称中不包含斜杠和冒号，添加默认的用户名 "library" 和标签 "latest"
            image_name="library/$image_name:latest"
        fi
    fi
    
    echo "$image_name"
}

# 使用 kubectl 命令获取所有 Pod 的信息，并筛选出状态为 ImagePullBackOff 的 Pod
kubectl get pods --all-namespaces -o=jsonpath='{range .items[*]}{.metadata.namespace}{"\t"}{.metadata.name}{"\t"}{.status.containerStatuses[*].state.waiting.reason}{"\n"}{end}' | grep ImagePullBackOff | while IFS=$'\t' read -r namespace pod reason; do
    # 获取镜像名称列表
    images=$(kubectl get pod $pod -n $namespace -o=jsonpath='{range .spec.containers[*]}{.image}{"\n"}{end}')
    
    # 遍历处理每个镜像
    while IFS= read -r image; do
        echo "Image <$image> ImagePullBackOff, pull image with proxy docker.wuxs.workers.dev"
        image=$(complete_image_name $image)
        image_name=$(echo $image | cut -d':' -f1)
        image_tag=$(echo $image | cut -d':' -f2)
        echo "$runtime pull docker.wuxs.workers.dev/$image_name:$image_tag"
        bash -c "$runtime pull docker.wuxs.workers.dev/$image_name:$image_tag"
        echo "$runtime tag docker.wuxs.workers.dev/$image_name:$image_tag $image"
        bash -c "$runtime tag docker.wuxs.workers.dev/$image_name:$image_tag $image"
    done <<< "$images"
done
