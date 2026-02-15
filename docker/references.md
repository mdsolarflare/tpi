# Install Ollama

[Ollama's Docker docs](https://docs.ollama.com/docker)

Always check the docs for when doing fresh installs instead of just spamming this. Nvidia needs a bunch of boilerplate crap. AMD also has it's own snowflake image tag.

# Update Ollama

Is there a verifiable update?

## Nvidia

```sh
docker pull ollama/ollama:latest
docker stop ollama
docker rm ollama
docker run -d --restart unless-stopped --gpus=all -v ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama
```

## AMD

```sh
docker pull ollama/ollama:latest
docker stop ollama
docker rm ollama
docker run -d --restart unless-stopped --device /dev/kfd --device /dev/dri -v ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama:rocm
```

# Running Nvidia GPUs on docker

[This was helpful](https://medium.com/@u.mele.coding/a-beginners-guide-to-nvidia-container-toolkit-on-docker-92b645f92006)

Especially the bit about using the nvidia/cuda images. Otherwise you have to install all the bits yourself. I tried "nvidia/cuda" and it failed.
Once you look at the dockerhub it becomes more clear there's no real latest, you need to target a guest OS.

The Ollama section above also references (https://docs.ollama.com/docker) which is quite helpful and kept up-to-date.

# Moving Files Around

TODO add some of the helpful ways of moving stuff to/from docker containers. etc.

## Using SCP to copy files

```sh
scp local_file user@remote_host:remote_directory
```


# Install/Update open webui - https://docs.openwebui.com/getting-started/quick-start/
## Setup OpenWEBUI Speedboost -- REDOS this?

```sh
# For CUDA
docker rm -f open-webui
docker pull ghcr.io/open-webui/open-webui:cuda
docker run -d --restart unless-stopped -p 3000:8080 --gpus all -v open-webui:/app/backend/data --name open-webui ghcr.io/open-webui/open-webui:cuda
docker network connect mesh open-webui
```

full shutdown restart notes for later:

```sh
# If didn't auto-restart
docker start ollama
# If didn't auto-restart
docker start open-webui
SwarmUI/launchtools/launch-standard-docker.sh &
docker network connect mesh ollama
docker network connect mesh open-webui
docker network connect mesh swarmui
```

Install for jellyfin

```sh
# https://jellyfin.org/docs/general/installation/container
docker pull jellyfin/jellyfin
docker volume create jellyfin-config
docker volume create jellyfin-cache

# source is the host location, destination is the guest location
docker run -d --name jellyfin  --user 1000:1000  --net=host  --volume jellyfin-config:/config --volume jellyfin-cache:/cache --mount type=bind,source=/media-pool,target=/media --restart=unless-stopped jellyfin/jellyfin
# https://jellyfin.org/docs/general/post-install/setup-wizard
```


VLLM docker quickstart 
```sh
docker run -d --runtime nvidia --gpus all --name vllm \
    -v ~/.cache/huggingface:/root/.cache/huggingface \
    --env "HF_TOKEN=$HF_TOKEN" \
    -p 8000:8000 \
    --ipc=host \
    vllm/vllm-openai:latest \
    --model unsloth/gpt-oss-20b
```
