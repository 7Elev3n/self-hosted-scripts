# Install Ubuntu 21.04 (use USB, no fancy storage formats when installing)
# Connect to internet using USB tethering (phone)

# First
sudo apt-get update
sudo apt-get upgrade

# to install and start ssh
sudo apt-get install openssh-server
sudo systemctl enable ssh
sudo systemctl start ssh
sudo ufw allow ssh
sudo ufw enable

# to remove shutdown timer
gsettings set org.gnome.SessionManager logout-prompt false

# To disable auto log out
gsettings set org.gnome.desktop.screensaver lock-enabled false

# AFTER INTERNET CONNECTION (LAN etc)
fwupdmgr update

# To set up any blank harddrives, see https://phoenixnap.com/kb/linux-create-partition
# 1. Find attached drives using "lsblk"
# 2. Create BTRFS partition using "sudo parted" (see link)
# 3. Create mount point "mkdir /mnt/hdd"
# 4. Mount using "mount /dev/sda1 /mnt/hdd"
