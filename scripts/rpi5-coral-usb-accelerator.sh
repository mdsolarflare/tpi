# Setup for coral usb accelerator on rpi5

# Install edge tpu runtime
echo "deb https://packages.cloud.google.com/apt coral-edgetpu-stable main" | sudo tee /etc/apt/sources.list.d/coral-edgetpu.list

curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

sudo apt-get update

sudo apt-get install libedgetpu1-std

# optional max freq (chip gets hot)
#sudo apt-get install libedgetpu1-max












