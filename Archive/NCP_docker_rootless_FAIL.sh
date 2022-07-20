# Can be run once system is set up (nothing docker-related installed)
# Run as admin user stitch
# From the top

# Installing rootless docker prereqs
sudo apt install -y uidmap dbus-user-session

# Install rootful docker using convenience script https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script
curl -fsSL https://get.docker.com -o get-docker.sh
sh ./get-docker.sh

# creating rootless user
sudo setcap cap_net_bind_service=ep $(which rootlesskit) # Opens privileged ports. Only tested to work after rootless is installed
sudo adduser dockerboi # Use own pw
sudo loginctl enable-linger dockerboi
sudo usermod -a -G dockerboi stitch # Add stitch to dockerboi group for future access

# ON THE NEW USER dockerboi:
"/usr/bin/dockerd-rootless-setuptool.sh" install
export PATH=/usr/bin:$PATH
export DOCKER_HOST=unix:///run/user/1001/docker.sock


systemctl --user start docker
systemctl --user enable docker

## DO NOT ADD dockerboi to the group "docker"! That group has root privileges. 

## Setting up for Nextcloud! Last few commands to run as stitch:
sudo mkdir /mnt/hdd/nextcloud
sudo chown dockerboi:dockerboi /mnt/hdd/nextcloud

sudo mkdir /mnt/hdd/mariadb
sudo chown dockerboi:dockerboi /mnt/hdd/mariadb

## AS dockerboi, from here on out
# copy paste the dcompose-nc.yml file into some directory
docker-compose -f "/home/dockerboi/dcompose-nc.yml" up

# Exit out after the directories have been created, run below.
echo "memory_limit = -1" >> /mnt/hdd/nextcloud/config/php/php-local.ini
echo "opcache.enable = 1" >> /mnt/hdd/nextcloud/config/php/php-local.ini
echo "opcache.enable_cli = 1" >> /mnt/hdd/nextcloud/config/php/php-local.ini
echo "opcache.interned_strings_buffer = 8" >> /mnt/hdd/nextcloud/config/php/php-local.ini
echo "opcache.max_accelerated_files = 10000" >> /mnt/hdd/nextcloud/config/php/php-local.ini
echo "opcache.memory_consumption = 128" >> /mnt/hdd/nextcloud/config/php/php-local.ini
echo "opcache.save_comments = 1" >> /mnt/hdd/nextcloud/config/php/php-local.ini
echo "opcache.revalidate_freq = 1" >> /mnt/hdd/nextcloud/config/php/php-local.ini



## Current problems
- rootless still doesnt work