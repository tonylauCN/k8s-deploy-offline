#!/bin/bash


# Init K8s master
echo "###############################################"
echo "### Install K8s Master"

export k8s_root=/root/k8s-deploy-offline


./kubeadm_v1.14.2/01_pre_check.sh
source ./kubeadm_v1.14.2/02_pre_env_settings.sh
./kubeadm_v1.14.2/03_pre_os_settings.sh
./kubeadm_v1.14.2/04_pre_print_and_confirm.sh
./kubeadm_v1.14.2/10_install_docker.sh
./kubeadm_v1.14.2/11_load_docker_images.sh
./kubeadm_v1.14.2/12_install_k8s.sh
./kubeadm_v1.14.2/13_init_k8s_master.sh

