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

# From - https://github.com/comfyanonymous/ComfyUI/issues/6201 - helpful!
# Install pytorch via AMD instructions - https://rocm.docs.amd.com/projects/radeon/en/latest/docs/install/wsl/install-pytorch.html
sudo apt install pipx
# Install rocm via https://rocm.docs.amd.com/projects/radeon/en/latest/docs/install/wsl/install-radeon.html
sudo amdgpu-install --list-usecase
amdgpu-install -y --usecase=wsl,rocm
rocminfo
# Create env and enable it
conda activate comfyui_py312
# Install pytorch via https://rocm.docs.amd.com/projects/radeon/en/latest/docs/install/wsl/install-pytorch.html#
sudo apt install python3-pip -y
pip3 install --upgrade pip wheel
wget https://repo.radeon.com/rocm/manylinux/rocm-rel-6.4.1/torch-2.6.0%2Brocm6.4.1.git1ded221d-cp312-cp312-linux_x86_64.whl
wget https://repo.radeon.com/rocm/manylinux/rocm-rel-6.4.1/torchvision-0.21.0%2Brocm6.4.1.git4040d51f-cp312-cp312-linux_x86_64.whl
wget https://repo.radeon.com/rocm/manylinux/rocm-rel-6.4.1/pytorch_triton_rocm-3.2.0%2Brocm6.4.1.git6da9e660-cp312-cp312-linux_x86_64.whl
wget https://repo.radeon.com/rocm/manylinux/rocm-rel-6.4.1/torchaudio-2.6.0%2Brocm6.4.1.gitd8831425-cp312-cp312-linux_x86_64.whl
pip3 uninstall torch torchvision pytorch-triton-rocm
pip3 install torch-2.6.0+rocm6.4.1.git1ded221d-cp312-cp312-linux_x86_64.whl torchvision-0.21.0+rocm6.4.1.git4040d51f-cp312-cp312-linux_x86_64.whl torchaudio-2.6.0+rocm6.4.1.gitd8831425-cp312-cp312-linux_x86_64.whl pytorch_triton_rocm-3.2.0+rocm6.4.1.git6da9e660-cp312-cp312-linux_x86_64.whl
location=$(pip show torch | grep Location | awk -F ": " '{print $2}')
cd ${location}/torch/lib/
rm libhsa-runtime64.so*
conda install -c conda-forge gcc=12.1.0

# Various verification tasks, should all pass
python3 -c 'import torch' 2> /dev/null && echo 'Success' || echo 'Failure'
python3 -c 'import torch; print(torch.cuda.is_available())'
python3 -c "import torch; print(f'device name [0]:', torch.cuda.get_device_name(0))"
python3 -m torch.utils.collect_env

# python main.py
