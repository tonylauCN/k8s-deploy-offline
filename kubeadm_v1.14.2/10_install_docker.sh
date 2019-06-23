#!/bin/bash

echo "###############################################"
echo "### 10:1 Install Docker ce (Docker yum in $docker_ip)" 
echo "### Debug Env: Docker rpm : $docker_ip"

## Stop Docker CE
#systemctl stop docker

## Uninstall Docker CE
sudo yum -y remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine \
                  docker-ce-cli \
                  containerd.io
## Install all packages in the ~/docker directory.
rpm -ivh --replacefiles --replacepkgs $docker_rpm/*.rpm

## Run Docker On CentOS 7 Server:
systemctl enable docker.service
systemctl start docker.service

## Set Docker daemon.json file
mkdir -p /etc/docker
../common/file_back.sh /etc/docker/daemon.json /etc/docker/daemon.json.bak

cat > /etc/docker/daemon.json << EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
  "max-size": "100m"
  },
  "storage-driver": "overlay2",
  "storage-opts": [
    "overlay2.override_kernel_check=true"
  ],
  "registry-mirrors": [
    "https://pee6w651.mirror.aliyuncs.com",
    "https://docker.mirrors.ustc.edu.cn"
  ],
  "insecure-registries": [
    "$docker_ip:5000"
  ]
}
EOF

systemctl restart docker.service

docker version 
