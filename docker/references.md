


## Using SCP to copy files

```sh
scp local_file user@remote_host:remote_directory
```


# Install ollama

https://ollama.com/blog/ollama-is-now-available-as-an-official-docker-image

```sh
# Update by pulling ollama/ollama, nvidia doesn't have a special tag like rocm

# Running in default yolo mode
docker run -d -v ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama

# Running in AMD ROCm framework
docker run --privileged -d --device /dev/kfd --device /dev/dri -v ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama:rocm

# Running in Nvidia CUDA framework
docker run -d --gpus=all -v ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama
```

## Running Nvidia GPUs on docker

[This was helpful](https://medium.com/@u.mele.coding/a-beginners-guide-to-nvidia-container-toolkit-on-docker-92b645f92006)

Especially the bit about using the nvidia/cuda images. Otherwise you have to install all the bits yourself. I tried "nvidia/cuda" and it failed.
Once you look at the dockerhub it becomes more clear there's no real latest, you need to target a guest OS.



# Install open webui - https://docs.openwebui.com/getting-started/quick-start/
## Setup OpenWEBUI Speedboost -- REDOS this?

```sh
# For CUDA
docker run -d -p 3000:8080 --gpus all -v open-webui:/app/backend/data --name open-webui ghcr.io/open-webui/open-webui:cuda
docker run --rm --volume /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower --run-once open-webui



docker network create openwebui-ollama-bridge
docker run -d -p 3000:8080 -v open-webui:/app/backend/data -e OLLAMA_BASE_URL=http://ollama:11434 --network openwebui-ollama-bridge --name open-webui --restart always ghcr.io/open-webui/open-webui:main
```
