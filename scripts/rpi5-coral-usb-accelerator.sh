# Setup for coral usb accelerator on rpi5

# Install edge tpu runtime
echo "deb https://packages.cloud.google.com/apt coral-edgetpu-stable main" | sudo tee /etc/apt/sources.list.d/coral-edgetpu.list

curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

sudo apt-get update

sudo apt-get install libedgetpu1-std

# optional max freq (chip gets hot)
#sudo apt-get install libedgetpu1-max

# Install pycoral - via sudo apt-get install python3-pycoral
# failed for python 3.11 not supported, pycoral only supports 3.6-3.9
# Note: PyCoral currently supports Python 3.6 through 3.9. 
# If your default version is something else, we suggest you 
# install Python 3.9 with pyenv. (https://realpython.com/intro-to-pyenv/)

# install dependencies for pyenv
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python3-openssl # had python-openssl but that's python 2?

# install pyenv via pyenv-installer project (https://github.com/pyenv/pyenv-installer)
curl https://pyenv.run | bash








