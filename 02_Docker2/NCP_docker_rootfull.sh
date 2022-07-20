# Can be run once system is set up (nothing docker-related installed)
# Run as admin user stitch
# From the top

# Installing rootless docker prereqs
sudo apt install -y uidmap dbus-user-session

# Install rootful docker using convenience script https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script
curl -fsSL https://get.docker.com -o get-docker.sh
sh ./get-docker.sh

# creating docker user (rootless but will have access to docker group which basically means sudo)
sudo adduser dockerboi # Use own pw
sudo loginctl enable-linger dockerboi
sudo usermod -a -G dockerboi stitch # Add stitch to dockerboi group for future access

sudo groupadd docker
sudo usermod -aG docker dockerboi

# Create folder in /mnt/hdd/ where dockerboi has rights to edit view etc
sudo mkdir /mnt/hdd/dockerstuff
sudo chown dockerboi:dockerboi /mnt/hdd/dockerstuff





# ON THE NEW USER dockerboi:
newgrp docker # activates changes to groups

# Might need a restart because docker needs to link the Unix socket to 'docker' group. After that, anyone in the group can use rootfull docker.

## Setting up for Nextcloud! 
mkdir /mnt/hdd/dockerstuff/nextcloud
mkdir /mnt/hdd/dockerstuff/mariadb

## AS dockerboi, from here on out
# copy paste the dcompose-nc.yml file into some directory
docker compose -f "/home/dockerboi/dcompose-nc.yml" up

# Exit out after the directories have been created, run below.
echo "memory_limit = -1" >> /mnt/hdd/dockerstuff/nextcloud/config/php/php-local.ini
echo "opcache.enable = 1" >> /mnt/hdd/dockerstuff/nextcloud/config/php/php-local.ini
echo "opcache.enable_cli = 1" >> /mnt/hdd/dockerstuff/nextcloud/config/php/php-local.ini
echo "opcache.interned_strings_buffer = 8" >> /mnt/hdd/dockerstuff/nextcloud/config/php/php-local.ini
echo "opcache.max_accelerated_files = 10000" >> /mnt/hdd/dockerstuff/nextcloud/config/php/php-local.ini
echo "opcache.memory_consumption = 128" >> /mnt/hdd/dockerstuff/nextcloud/config/php/php-local.ini
echo "opcache.save_comments = 1" >> /mnt/hdd/dockerstuff/nextcloud/config/php/php-local.ini
echo "opcache.revalidate_freq = 1" >> /mnt/hdd/dockerstuff/nextcloud/config/php/php-local.ini

echo "pm = dynamic" >> /mnt/hdd/dockerstuff/nextcloud/config/php/www2.conf
echo "pm.max_children = 120" >> /mnt/hdd/dockerstuff/nextcloud/config/php/www2.conf
echo "pm.start_servers = 12" >> /mnt/hdd/dockerstuff/nextcloud/config/php/www2.conf
echo "pm.min_spare_servers = 6" >> /mnt/hdd/dockerstuff/nextcloud/config/php/www2.conf
echo "pm.max_spare_servers = 18" >> /mnt/hdd/dockerstuff/nextcloud/config/php/www2.conf

Follow https://virtualize.link/nextcloud/ to edit nextcloud config

To run nc on cf:
docker compose -f "/home/dockerboi/dcompose-nc.yml" up -d && cloudflared tunnel run


## Current status
Done
- nextcloud
- Qbittorrent
- jellyfin
- prowlarr
- sonarr


Current to do
- mailserver (gmail??)
- Arrs
- Authelia
- Google Photos
- Check if wna use gluetun? apparently has issues with ip leakage
- sonarr and prowlarr do not see each other: likely due to vpn.

- error in qb:
	qbittorrent  | Error occurred at line: 1
	qbittorrent  | Try `ip6tables-restore -h' or 'ip6tables-restore --help' for more information.
	qbittorrent  | [#] resolvconf -d wg0 -f
	qbittorrent  | [#] ip -6 rule delete table 51820
	qbittorrent  | [#] ip -6 rule delete table main suppress_prefixlength 0
	qbittorrent  | [#] ip link delete dev wg0
	qbittorrent  | [ERROR] WireGuard failed to start.
	qbittorrent  | [cont-init.d] 02-setup-wg: exited 1.
	qbittorrent  | [cont-finish.d] executing container finish scripts...
	qbittorrent  | [cont-finish.d] 01-kill-wg: executing...
	qbittorrent  | [cont-finish.d] 01-kill-wg: exited 0.
	qbittorrent  | [cont-finish.d] done.
	qbittorrent  | [s6-finish] waiting for services.
	qbittorrent  | [s6-finish] sending all processes the TERM signal.
	qbittorrent  | [s6-finish] sending all processes the KILL signal and exiting.
