#!/bin/bash

#  cd /mnt/c/Users/qingqing.b.liu/Development/git/k8s-deploy-offline/kubeadm_v1.14.2
#  vi /etc/security/limits.conf
set -e
echo "###############################################"
echo "### 03:1 Set OS Limits"
sed -i '/^\* soft nofile/'d /etc/security/limits.conf
sed -i '/^\* hard nofile/'d /etc/security/limits.conf
sed -i '/^fs\.file-max/'d /etc/sysctl.conf
sed -i '/^fs\.inode-max/'d /etc/sysctl.conf
cat >> /etc/security/limits.conf << EOF
* soft nofile 8192
* hard nofile 20480
EOF

# CentOS7 max-file defult:794168 & user default:1024
cat >> /etc/sysctl.conf <<EOF
fs.file-max=200000
EOF

sysctl -p

# Disable SELinux
echo "###############################################"
echo "### 03:2 Disable SELinux"
# Set SELinux in permissive mode (effectively disabling it)
setenforce 0
# Back file
$k8s_root/common/file_back.sh /etc/selinux/config /etc/selinux/config.bak

#cp -p /etc/selinux/config /etc/selinux/config.bak
#sed -i -e 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

# Turn off Swap
echo "###############################################"
echo "### 03:3 Turn off Swap"
swapoff -a

$k8s_root/common/file_back.sh /etc/fstab /etc/fstab.bak

cp -p /etc/fstab /etc/fstab.bak
sed -i "s/\/dev\/mapper\/rhel-swap/\#\/dev\/mapper\/rhel-swap/g" /etc/fstab
sed -i "s/\/dev\/mapper\/centos-swap/\#\/dev\/mapper\/centos-swap/g" /etc/fstab
mount -a
free -m
cat /proc/swaps

# Setup iptables (routing)
echo "###############################################"
echo "### 03:4 Setup iptables (routing)"
cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
## Reload Kernel parameter configuration files.
modprobe br_netfilter
sysctl --system

# Setup Linux firewall
# Allow Kubernetes (K8s) service ports in Linux firewall.
echo "###############################################"
echo "### 03:5 Setup Linux firewall : Master" 
firewall-cmd --permanent --add-port={6443,2379,2380,10250,10251,10252}/tcp
firewall-cmd --reload
# systemctl stop firewalld




