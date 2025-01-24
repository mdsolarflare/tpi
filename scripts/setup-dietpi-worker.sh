#!/bin/bash
# Usage
# ./setup-worker.sh $token $masterIp

# Post DietPi setup, pre-k3s
sed -i '1s/$/cgroup_memory=1 cgroup_enable=memory/' /boot/cmdline.txt

# Installing k3s worker per https://docs.k3s.io/quick-start
curl -sfL https://get.k3s.io | K3S_URL="https://$2:6443" K3S_TOKEN=$1 sh -
