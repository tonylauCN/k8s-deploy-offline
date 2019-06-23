#!/bin/bash


# Install K8s rpm
echo "###############################################"
echo "### 12:1 Install K8s rpm"
echo "### Using K8s RPM path: $k8s_rpm_path"

rpm -ivh --replacefiles --replacepkgs $k8s_rpm_path/*.rpm

echo "### 12:2 Set for kuberctl."
echo "### Enable bash completion for kubectl."
source <(kubectl completion bash)
kubectl completion bash > /etc/bash_completion.d/kubectl
systemctl enable --now kubelet


