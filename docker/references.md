


# Using SCP to copy files

```sh
scp local_file user@remote_host:remote_directory
```


# Running a ollama rocm container

```sh
docker run --privileged -d --device /dev/kfd --device /dev/dri -v ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama:rocm
```
