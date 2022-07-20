#### THIS ASSUMES DOCKER IS INSTALLED.

# Follow https://linuxize.com/post/fdisk-command-in-linux/ to create partition on the harddisk

## Run the following as admin user, NOT dockerboi
sudo mkdir -p /mnt/hdd
sudo chown -R stitch:docker /mnt/hdd
chmod -R 770 /mnt/hdd

# for fstab, add the following line (change uuid as req) or use the GNOME gui to mount a drive.
# Follow https://confluence.jaytaala.com/display/TKB/Mount+drive+in+linux+and+set+auto-mount+at+boot to change fstab

sudo mount -a

# Now ensure that docker group contains dockerboi, which should be able to access /mnt/hdd
# Idea is for dockerboi/docker-group to only be able to access at most data drives, but never system files. That is why we go through many pains to set up rootless docker and another non-root user to run all containers in an isolated harddisk. 

#Helpful commands

sudo umount /mnt/hdd1
getent group docker #to see members of group "docker"


#Correct (most basic) /etc/apt/sources.list
deb http://ossmirror.mycloud.services/os/linux/ubuntu/ impish main multiverse universe restricted
deb http://ossmirror.mycloud.services/os/linux/ubuntu/ impish-security main multiverse universe restricted
deb http://ossmirror.mycloud.services/os/linux/ubuntu/ impish-updates main multiverse universe restricted


