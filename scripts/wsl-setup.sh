# Note, I did install homebrew... https://docs.brew.sh/Homebrew-on-Linux

# Install ROCM - https://rocm.docs.amd.com/projects/radeon/en/latest/docs/install/wsl/install-radeon.html#
sudo apt update
wget https://repo.radeon.com/amdgpu-install/6.4.1/ubuntu/noble/amdgpu-install_6.4.60401-1_all.deb
sudo apt install ./amdgpu-install_6.4.60401-1_all.deb

amdgpu-install -y --usecase=wsl,rocm --no-dkms

# To verify:
# rocminfo
# ---
# To uninstall:
# sudo amdgpu-uninstall

# Install miniconda - https://www.anaconda.com/docs/getting-started/miniconda/install#linux
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm ~/miniconda3/miniconda.sh

# Note, git was already installed but got an opaque permissions error that was due to an ssh error. Not sure why it was forcing ssh.

# https://docs.comfy.org/installation/manual_install#amd

# create conda env
conda create -n comfyenv
# conda activate comfyenv - i got in a mess and started over because i was using python 3.13.
conda create -n comfyui_py312 python=3.12

# clone repo
git clone git@github.com:comfyanonymous/ComfyUI.git

# install rocm stuff
pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/rocm6.0

# Install pytorch via AMD instructions - https://rocm.docs.amd.com/projects/radeon/en/latest/docs/install/wsl/install-pytorch.html

sudo apt install pipx
sudo apt install python3-pip -y
pip3 install --upgrade pip wheel

wget https://repo.radeon.com/rocm/manylinux/rocm-rel-6.4.1/torch-2.6.0%2Brocm6.4.1.git1ded221d-cp312-cp312-linux_x86_64.whl
wget https://repo.radeon.com/rocm/manylinux/rocm-rel-6.4.1/torchvision-0.21.0%2Brocm6.4.1.git4040d51f-cp312-cp312-linux_x86_64.whl
wget https://repo.radeon.com/rocm/manylinux/rocm-rel-6.4.1/pytorch_triton_rocm-3.2.0%2Brocm6.4.1.git6da9e660-cp312-cp312-linux_x86_64.whl
wget https://repo.radeon.com/rocm/manylinux/rocm-rel-6.4.1/torchaudio-2.6.0%2Brocm6.4.1.gitd8831425-cp312-cp312-linux_x86_64.whl
pip3 uninstall torch torchvision pytorch-triton-rocm
pip3 install torch-2.6.0+rocm6.4.1.git1ded221d-cp312-cp312-linux_x86_64.whl torchvision-0.21.0+rocm6.4.1.git4040d51f-cp312-cp312-linux_x86_64.whl torchaudio-2.6.0+rocm6.4.1.gitd8831425-cp312-cp312-linux_x86_64.whl pytorch_triton_rocm-3.2.0+rocm6.4.1.git6da9e660-cp312-cp312-linux_x86_64.whl
# this shit fucked up proobably also because of the 3.13 issue?

# Install pytorch via the docker instructions at the same link above :/ but got some failures on the demo code :sad:
#sudo apt install docker.io
#sudo docker pull rocm/pytorch:rocm6.4.1_ubuntu24.04_py3.12_pytorch_release_2.6.0
#sudo docker run -it -d \
#--cap-add=SYS_PTRACE  \
#--security-opt seccomp=unconfined \
#--ipc=host \
#--shm-size 8G \
#--device=/dev/dxg -v /usr/lib/wsl/lib/libdxcore.so:/usr/lib/libdxcore.so -v /opt/rocm/lib/libhsa-runtime64.so.1:/opt/rocm/lib/libhsa-runtime64.so.1  \
#  rocm/pytorch:rocm6.4.1_ubuntu24.04_py3.12_pytorch_release_2.6.0

# idk shits fucked
# https://rocm.docs.amd.com/projects/install-on-linux/en/latest/install/quick-start.html
wget https://repo.radeon.com/amdgpu-install/6.4.2/ubuntu/noble/amdgpu-install_6.4.60402-1_all.deb
sudo apt install ./amdgpu-install_6.4.60402-1_all.deb
sudo apt update
sudo apt install python3-setuptools python3-wheel
sudo usermod -a -G render,video $LOGNAME # Add the current user to the render and video groups
sudo apt install rocm

wget https://repo.radeon.com/amdgpu-install/6.4.2/ubuntu/noble/amdgpu-install_6.4.60402-1_all.deb
sudo apt install ./amdgpu-install_6.4.60402-1_all.deb
sudo apt update
sudo apt install "linux-headers-$(uname -r)" "linux-modules-extra-$(uname -r)"
sudo apt install amdgpu-dkms
