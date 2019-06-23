#!/bin/bash


# Init K8s master
echo "###############################################"
echo "### 13:1 Init K8s Master"
echo "### Using K8s Master addr: $master_ips"
echo "### Using Api-Server addr: $k8s_apiserver_addr"

kubeadm init --apiserver-advertise-address=$k8s_apiserver_addr \
--apiserver-cert-extra-sans=$k8s_apiserver_addr \
--pod-network-cidr=$pod_network \
--kubernetes-version v1.14.2 \
--image-repository $docker_ip:5000 \
--cert-dir /etc/kubernetes/pki \
--apiserver-bind-port $k8s_apiserver_port \
--token-ttl 24h0m0s
