#!/bin/bash

echo "###############################################"
echo "### 11:1 Import the tar files of docker images into Docker."

#docker load < ~/k8s/coredns.tar
#docker load < ~/k8s/kube-proxy.tar
#docker load < ~/k8s/etcd.tar
#docker load < ~/k8s/kube-scheduler.tar
#docker load < ~/k8s/kube-apiserver.tar
#docker load < ~/k8s/pause.tar
#docker load < ~/k8s/kube-controller-manager.tar

for i in $k8s_images_path/*.tar; do
    if [ -r "$i" ]; then
        #docker images | grep $i 
        docker load < $i
    fi
done
