#!/bin/bash
# Usage
# DietPi Debian - https://dietpi.com/#download
# Debian        - https://www.debian.org/intro/why_debian

# Install docker - https://docs.docker.com/engine/install/debian/
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Restart the Docker service and add your user to the docker group, so that you don't need to use the command with sudo .
sudo systemctl restart docker
sudo usermod -aG docker $USER
newgrp docker

docker run hello-world

# Install pihole - https://docs.pi-hole.net/docker/
# See compose file neighbor
# Run docker compose up -d to build and start Pi-hole (on older systems, the syntax here may be docker-compose up -d)
#wget https://raw.githubusercontent.com/mdsolarflare/tpi/refs/heads/main/scripts/jellyfin/jellyfin-compose.yml
# Don't forget to update your password :^) in the file
#docker compose -f jellyfin-compose.yml up -d

# https://jellyfin.org/docs/general/installation/container
docker pull jellyfin/jellyfin
docker volume create jellyfin-config
docker volume create jellyfin-cache

# source is the host location, destination is the guest location
docker run -d --name jellyfin  --user 1000:1000  --net=host  --volume jellyfin-config:/config --volume jellyfin-cache:/cache --mount type=bind,source=/media-pool,target=/media --restart=unless-stopped jellyfin/jellyfin
# https://jellyfin.org/docs/general/post-install/setup-wizard
