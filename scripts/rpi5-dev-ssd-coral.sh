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

# At the end of the run you will see this
#WARNING: seems you still have not added 'pyenv' to the load path.
#
#Load pyenv automatically by adding
#the following to ~/.bashrc:
#
#export PATH="$HOME/.pyenv/bin:$PATH"
#eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"
#
#The output will be based on your shell. But you should follow the instructions 
#to add pyenv to your path and to initialize pyenv/pyenv-virtualenv auto completion. 
#Once you’ve done this, you need to reload your shell:

# I added the previous export to .profile and .bashrc

# install python 3.9
pyenv install -v 3.9.20

# ls ~/.pyenv/versions/ shows the installation location
# use this command to see which version of python that pyenv is using
# you should see 3.9.20
pyenv versions

# set to use 3.9.20
pyenv global 3.9.20
# you can confirm the submission with pyenv versions

# create a virtual environment
mkdir coral && cd coral
pyenv virtualenv 3.9.20 pycoral-tpu-project
pyenv local pycoral-tpu-project





# Still broken!
sudo apt-get install python3-pycoral












