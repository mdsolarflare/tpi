## Linux

- Install Docker Engine for Linux: https://docs.docker.com/engine/install/
    - You don't need Docker Desktop, just the Engine
- Follow the Docker Linux post-install steps to ensure you can operate Docker from a user account instead of root: https://docs.docker.com/engine/install/linux-postinstall/
    - (Optional) if you want to further refine your security, you can configure Docker rootless mode: https://docs.docker.com/engine/security/rootless/
        - Rootless has known unresolved issues in base Docker currently. I do not recommend using it until these are patched.
        - If you must, you'll need to maintain modified copies of the docker scripts that remove the `--user` inputs (ie rootless docker currently requires you run as root inside the container. This is obviously not good, thus the advice to not use rootless for now. See https://github.com/mamba-org/micromamba-docker/issues/407#issuecomment-2088523507 for info.)
- Install and enable NVIDIA Container toolkit: https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html
- Install `git`
- Download Swarm via git: `git clone https://github.com/mcmonkeyprojects/SwarmUI`
- cd `SwarmUI`
- Run `./launchtools/launch-standard-docker.sh` or `./launchtools/launch-open-docker.sh`. Do not give it any CLI args.
- Open a browser to http://localhost:7801
