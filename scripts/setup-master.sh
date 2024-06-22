#!/bin/bash
# Usage
# ./setup-worker.sh $token $masterIp $thisNodeName

# probably missed some stuff ill run into later and add here next time

# Post DietPi setup, pre-k3s
sed -i '1s/$/cgroup_memory=1 cgroup_enable=memory/' /boot/cmdline.txt

curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644 --token $1 --node-ip $2

#NAME           STATUS   ROLES                  AGE    VERSION
#dietpi.node1   Ready    control-plane,master   24m    v1.29.5+k3s1
#dietpi.node3   Ready    <none>                 110s   v1.29.5+k3s1
#dietpi.node2   Ready    <none>                 14m    v1.29.5+k3s1
#dietpi.node4   Ready    <none>                 93s    v1.29.5+k3s1
#
#kubectl label nodes dietpi.node1 kubernetes.io/role=worker
#kubectl label nodes dietpi.node2 kubernetes.io/role=worker
#kubectl label nodes dietpi.node3 kubernetes.io/role=worker
#kubectl label nodes dietpi.node4 kubernetes.io/role=worker