#!/bin/bash


#!/bin/bash

set -e

echo "###############################################"
echo "Please ensure your OS is CentOS7 64 bits"
echo "Please ensure your machine has full network connection and internet access"
echo "Please ensure run this script with root user"

# Check hostname, Mac addr and product_uuid
echo "###############################################"
echo "Please check hostname as below:"
uname -a

echo "###############################################"
echo "Please check Mac addr and product_uuid as below:"
ip link
sudo cat /sys/class/dmi/id/product_uuid

