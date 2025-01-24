#NAME           STATUS   ROLES                         AGE     VERSION
#dietpi.node4   Ready    worker                        205d    v1.29.5+k3s1
#dietpi.node1   Ready    control-plane,master,worker   205d    v1.29.5+k3s1
#dietpi.node2   Ready    worker                        205d    v1.29.5+k3s1
#dietpi.node3   Ready    worker                        205d    v1.29.5+k3s1
#xaviernx       Ready    worker                        9m52s   v1.31.4+k3s1

# BASH SCRIPTS FTW :^) jk rethink labeling
node_names=$(kubectl get nodes -o custom-columns=NAME:.metadata.name | awk '{print $1}' | tail -n +2)
for node in $node_names; do
  # Replace 'my-command' with your actual command
  echo "kubectl label nodes <resource name from above> kubernetes.io/role=worker"
  kubectl label nodes $node kubernetes.io/role=worker
  # Add additional commands to operate on each node here (optional)
done

kubectl label nodes xaviernx kubernetes.io/role=worker
kubectl label node xaviernx ml-stack=nvidia
kubectl label nodes ubuntu kubernetes.io/role=worker
kubectl label node ubuntu ml-stack=rockchip

# Installing helm per https://helm.sh/docs/intro/install/
# I have helm installed but haven't been using it and don't understand the use case. commenting out for now, same for arkade
# curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
# chmod 700 get_helm.sh
# ./get_helm.sh

# print version to make sure it installed ok?
# helm version



# Install longhorn - https://docs.k3s.io/storage
# https://longhorn.io/docs/1.8.0/deploy/install/install-with-kubectl/
# https://github.com/longhorn/longhorn/releases/tag/v1.8.0
# Required packages that i believe to be missing for longhorn/k3s on dietpi
sudo apt update
sudo apt install -y open-iscsi
sudo systemctl enable --now iscsid
# READ THE DOCS




# my cool kid debugging area - TODO
# kubectl get all -n argocd
# kubectl exec -it <pod-name> -n <namespace> -- /bin/bash
