


## Using SCP to copy files

```sh
scp local_file user@remote_host:remote_directory
```


## Running a ollama rocm container

```sh
docker run --privileged -d --device /dev/kfd --device /dev/dri -v ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama:rocm
```

## Running Nvidia GPUs on docker

[This was helpful](https://medium.com/@u.mele.coding/a-beginners-guide-to-nvidia-container-toolkit-on-docker-92b645f92006)

Especially the bit about using the nvidia/cuda images. Otherwise you have to install all the bits yourself. I tried "nvidia/cuda" and it failed.
Once you look at the dockerhub it becomes more clear there's no real latest, you need to target a guest OS.

## Setup OpenWEBUI Speedboost

```sh
docker run -d -v ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama
docker run -d -p 3000:8080 -v open-webui:/app/backend/data -e OLLAMA_BASE_URL=http://0.0.0.0:11434 --name open-webui --restart always ghcr.io/open-webui/open-webui:main
```
