#!/bin/bash

# Assign the mac to a IP on the dhcp server
sudo apt update
sudo apt upgrade -y

# Install docker - https://docs.docker.com/engine/install/ubuntu/
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo docker run hello-world

# Restart the Docker service and add your user to the docker group, so that you don't need to use the command with sudo .
sudo systemctl restart docker
sudo usermod -aG docker $USER
newgrp docker

# Install open webui - https://docs.openwebui.com/getting-started/quick-start/
docker run -d -p 3000:8080 -v open-webui:/app/backend/data --name open-webui ghcr.io/open-webui/open-webui:main

# Install ollama - https://ollama.com/blog/ollama-is-now-available-as-an-official-docker-image
docker run -d -v ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama
