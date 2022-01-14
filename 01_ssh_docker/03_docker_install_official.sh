sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io


# Rootless docker daemon guide below from: https://docs.docker.com/engine/security/rootless/
sudo apt install uidmap
sudo apt-get install -y dbus-user-session

sudo systemctl disable --now docker.service docker.socket

sudo adduser dockerboi #use own password

sudo loginctl enable-linger dockerboi 

    # ON THE NEW USER dockerboi:
    "/usr/bin/dockerd-rootless-setuptool.sh" install
    systemctl --user start docker
    systemctl --user enable docker

    echo 'export PATH=/home/cloud_user/bin:$PATH' >> /home/dockerboi/.bashrc
    echo 'export DOCKER_HOST=unix:///run/user/1001/docker.sock' >> /home/dockerboi/.bashrc

# On original (root) user
docker run hello-world

