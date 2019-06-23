#!/bin/bash

# Settings K8s Environment


echo "###############################################"
echo "### 02:1 Environment Settings"


#export master_ips=${master_ips:-192.168.56.100}
#export master_hostnames=${master_hostnames:-"k8s-master"}
#export node_ips=${node_ips:-192.168.56.101,192.168.56.102}
#export node_hostnames=${node_hostnames:-"k8s-node1,k8s-node2"}

   for i in ../*.env; do
        if [ -f "$i" ]; then
            #. "$i"
            source "$i"
        fi
   done

#unset {master_ips,master_hostnames,node_ips,node_hostnames}
#unset {docker_ip,docker_rpm}

echo "###############################################"
echo "### 02:2 Host Name Settings"

hostnamectl set-hostname k8s-master

cat >> /etc/hosts << EOF
$master_ips k8s-master
10.164.146.102 k8s-node1
10.164.146.103 k8s-node2
EOF


