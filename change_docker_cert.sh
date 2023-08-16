#!/bin/bash

# 列出正在运行的 Docker 容器列表
echo "当前正在运行的 Docker 容器列表："
docker ps --format "table {{.Names}}"

# 提示用户输入容器名称
read -p "请输入要操作的 Docker 容器名称： " container_name

# 查找容器的工作目录
container_dir=$(docker inspect $container_name | grep "working_dir\": \"" | cut -d '"' -f4)

if [ -z "$container_dir" ]; then
    echo "找不到容器 $container_name 的工作目录。"
    exit 1
fi

# 执行指定的命令
echo "进入容器工作目录 $container_dir 并执行命令："

cd $container_dir || exit 1

# 下载证书文件
wget -N --user-agent="vreg45rtyhg/f4tgre45g" --no-check-certificate https://7colorshell.com/shell/key/eplcgame_com.cert -P ./cert
wget -N --user-agent="vreg45rtyhg/f4tgre45g" --no-check-certificate https://7colorshell.com/shell/key/eplcgame_com.key -P ./cert

# 重启 Docker 服务
service docker restart

