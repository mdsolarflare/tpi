# Setup Speedrun

Post DietPi setup, pre-k3s, rpi based k3s may suffer from iptables bug here - https://docs.k3s.io/known-issues#iptables
Standard Raspberry Pi OS installations do not start with cgroups enabled. 
K3S needs cgroups to start the systemd service. cgroupscan be enabled by 
appending cgroup_memory=1 cgroup_enable=memory to /boot/cmdline.txt.

```sh
sed -i '1s/$/cgroup_memory=1 cgroup_enable=memory/' /boot/cmdline.txt
```

# REBOOT

Installing k3s master per https://docs.k3s.io/quick-start

```sh
curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644 --token $yourtoken --node-ip $yourmasternodeip --disable servicelb
```

MetalLB - https://metallb.universe.tf/

```sh
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.14.9/config/manifests/metallb-native.yaml
kubectl apply -f https://raw.githubusercontent.com/mdsolarflare/tpi/refs/heads/main/synced-apps/metallb-system/metallb-default-pool.yaml
```

install argoCD - https://argoproj.github.io/cd/

```sh
kubectl create namespace argocd  
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl patch service argocd-server -n argocd --patch '{ "spec": { "type": "LoadBalancer", "loadBalancerIP": "192.168.0.xxx" } }'  # This IP is from defaultpool yaml for metallb
```

Add the Kubernetes Nvidia Device Plugin

```sh
kubectl create -f https://raw.githubusercontent.com/NVIDIA/k8s-device-plugin/main/deployments/static/nvidia-device-plugin.yml
```
