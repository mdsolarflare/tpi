#!/bin/bash
# Usage
# ./setup-worker.sh $token $masterIp $thisNodeName

# probably missed some stuff ill run into later and add here next time

# Post DietPi setup, pre-k3s, rpi based k3s may suffer from iptables bug here - https://docs.k3s.io/known-issues#iptables
# Standard Raspberry Pi OS installations do not start with cgroups enabled. 
# K3S needs cgroups to start the systemd service. cgroupscan be enabled by 
# appending cgroup_memory=1 cgroup_enable=memory to /boot/cmdline.txt.
sed -i '1s/$/cgroup_memory=1 cgroup_enable=memory/' /boot/cmdline.txt

# Installing k3s master per https://docs.k3s.io/quick-start
curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644 --token $1 --node-ip $2 --disable servicelb

# MetalLB - https://metallb.universe.tf/
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.14.9/config/manifests/metallb-native.yaml
kubectl apply -f https://raw.githubusercontent.com/mdsolarflare/tpi/refs/heads/main/synced-apps/metallb-system/metallb-default-pool.yaml
