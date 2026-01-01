# Swarm UI

### Clone! swarmui

```
git clone https://github.com/mcmonkeyprojects/SwarmUI
```

Depending on ARM vs X86_64, I have needed these two diffs before

```diff
--- a/launchtools/docker-standard-inner.sh
+++ b/launchtools/docker-standard-inner.sh
@@ -8,7 +8,7 @@ cd /SwarmUI
 if [[ "$1" == "fixch" ]]
 then
     echo "Fixing perms, owning to UID $2"
-    chown -R $2:$2 /SwarmUI/dlbackend /SwarmUI/Data /SwarmUI/src /SwarmUI/Output
+    chown -R $2:$2 /SwarmUI/dlbackend /SwarmUI/Data /SwarmUI/src /SwarmUI/Output /SwarmUI/Models
     chown $2:$2 /SwarmUI
     # Scrap any database files rather than reperm (to reduce conflicts, they regen anyway)
     rm /SwarmUI/Models/**/model_metadata.ldb 2> /dev/null
diff --git a/launchtools/launch-standard-docker.sh b/launchtools/launch-standard-docker.sh
index 4267b994..9a0c3b3e 100755
--- a/launchtools/launch-standard-docker.sh
+++ b/launchtools/launch-standard-docker.sh
@@ -30,7 +30,7 @@ docker run -it \
     -v "$PWD/Models:/SwarmUI/Models" \
     -v "$PWD/Output:/SwarmUI/Output" \
     -v "$PWD/src/BuiltinExtensions/ComfyUIBackend/CustomWorkflows:/SwarmUI/src/BuiltinExtensions/ComfyUIBackend/CustomWorkflows" \
-    --gpus=all -p 7801:7801 swarmui $POSTARG
+    --runtime=nvidia --gpus=all -p 7801:7801 swarmui $POSTARG
 
 if [ $? == 42 ]; then
     exec "$SCRIPT_DIR/launch-standard-docker.sh" $@
(END)
```

## For Original Docs

See https://github.com/mcmonkeyprojects/SwarmUI/blob/master/docs/Docker.md

## To launch

Run `./launchtools/launch-standard-docker.sh`

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
