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

# BASH SCRIPTS FTW :^)
node_names=$(kubectl get nodes -o custom-columns=NAME:.metadata.name | awk '{print $1}' | tail -n +2)
for node in $node_names; do
  # Replace 'my-command' with your actual command
  echo "kubectl label nodes <resource name from above> kubernetes.io/role=worker"
  kubectl label nodes $node kubernetes.io/role=worker
  # Add additional commands to operate on each node here (optional)
done

# Installing helm per https://helm.sh/docs/intro/install/
# I have helm installed but haven't been using it and don't understand the use case. commenting out for now, same for arkade
# curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
# chmod 700 get_helm.sh
# ./get_helm.sh

# print version to make sure it installed ok?
# helm version

# Arkade? - https://github.com/alexellis/arkade#getting-arkade
# Note: you can also run without `sudo` and move the binary yourself
#curl -sLS https://get.arkade.dev | sudo sh
#
#arkade --help
#ark --help  # a handy alias

# MetalLB - https://metallb.universe.tf/
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.14.5/config/manifests/metallb-native.yaml
# to delete 
# kubectl get clusterroles,clusterrolebindings -n metallb-system
# then delete the specific ones keeping the pods up
# kubectl delete deployments,services,pods -n metallb-system --all

# apply the configuration manifest, you need to change the IPs
kubectl apply -f ./k3s-yamls/metallb-default-pool.yaml

# install argoCD - https://argoproj.github.io/cd/
kubectl create namespace argocd  
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
# This IP is from defaultpool yaml for metallb - TODO parameterize!
kubectl patch service argocd-server -n argocd --patch '{ "spec": { "type": "LoadBalancer", "loadBalancerIP": "192.168.0.122" } }' 

#Install longhorn - https://docs.k3s.io/storage
kubectl apply -f https://raw.githubusercontent.com/longhorn/longhorn/v1.6.0/deploy/longhorn.yaml
# Required packages that i believe to be missing for longhorn/k3s on dietpi
sudo apt update
sudo apt install -y open-iscsi
sudo systemctl enable --now iscsid





# my cool kid debugging area - TODO
# kubectl get pods,deployments,services -A
#
# 1. I think need to clean up the clusters as there is stuff like traefik that's unused. or i should figure out how to use it correctly. lol.
