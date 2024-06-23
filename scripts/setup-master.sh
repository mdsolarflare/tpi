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

# Installing helm per https://helm.sh/docs/intro/install/
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

# print version to make sure it installed ok?
helm version

# Arkade? - https://github.com/alexellis/arkade#getting-arkade
# Note: you can also run without `sudo` and move the binary yourself
#curl -sLS https://get.arkade.dev | sudo sh
#
#arkade --help
#ark --help  # a handy alias

# MetalLB - https://metallb.universe.tf/
# Add MetalLB repository to Helm
# TODO I think just install this way next time, if not the old method is here
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.14.5/config/manifests/metallb-native.yaml
#helm repo add metallb https://metallb.github.io/metallb

# Check the added repository
#helm search repo metallb
#"metallb" has been added to your repositories
#NAME            CHART VERSION   APP VERSION     DESCRIPTION
#metallb/metallb 0.14.5          v0.14.5         A network load-balancer implementation for Kube...

# I found that helm does not know what to do if this isn't set
#export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
# error looks like ->
#$ helm upgrade --install metallb metallb/metallb --create-namespace --namespace metallb-system --wait
#  Error: Kubernetes cluster unreachable: Get "http://localhost:8080/version": dial tcp [::1]:8080: connect: connection refused
#helm upgrade --install metallb metallb/metallb --create-namespace --namespace metallb-system --wait
# success looks like ->
#Release "metallb" does not exist. Installing it now.
#NAME: metallb
#LAST DEPLOYED: Sun Jun 23 07:49:05 2024
#NAMESPACE: metallb-system
#STATUS: deployed
#REVISION: 1
#TEST SUITE: None
#NOTES:
#MetalLB is now running in the cluster.

# apply the configuration manifest, you need to change the IPs
cat << 'EOF' | kubectl apply -f -
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: default-pool
  namespace: metallb-system
spec:
  addresses:
  - 192.168.0.120-192.168.0.130
---
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: default
  namespace: metallb-system
spec:
  ipAddressPools:
  - default-pool
EOF

# create namespace for argoCD
kubectl create namespace argocd  
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
