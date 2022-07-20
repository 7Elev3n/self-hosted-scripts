## Deprecated, this was a hack method to get docker on ubuntu 21.10


## Adapted from https://gist.github.com/pablodz/daa8ff298663cc4f88cf2cfc966bbede#file-install_docker_in_ubuntu_21-10-sh

echo Uninstalling old docker versions and updating repos..
echo ..
sudo apt-get remove docker docker-engine docker.io containerd runc
# Refresh latest version
sudo apt-get update


echo Installing pre-reqs apt-transport-https, ca-certificates, curl, gnupg, lsb-release..
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

echo ..
echo Adding docker official GPG key..
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# x86 and amd_64 HERE WE CHANGE
echo \
"deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
hirsute stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Rootless docker install
sudo apt-get install -y uidmap dbus-user-session
echo ..
echo Installing docker..
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

echo ..
echo Giving docker permissions..
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

# Check version
docker --version

# Check if installed
docker run hello-world

# If still fails, reboot OS

# Downloand docker compose stable
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Apply executable to binary
sudo chmod +x /usr/local/bin/docker-compose

# Check version
docker-compose --version
