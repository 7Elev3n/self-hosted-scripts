# Requires
# 	Docker, docker-compose to be installed
#   docker user is dockerboi, and it is the current user. DO NOT USE the "admin" user!
# 	dockerboi has rwx access to /mnt/hdd which is where all data will be stored from containers, and no access to any system directories.

# As dockerboi, run the following
mkdir /mnt/hdd1/ncdata


docker run -u `stat -c "%u:%g" /mnt/hdd1` -d -p 4443:4443 -p 443:443 -p 80:80 -v /mnt/hdd1/ncdata:/data --restart unless-stopped --name ncp ownyourbits/nextcloudpi 192.168.10.103 

docker run -u 1001:998 -d -p 4443:4443 -p 443:443 -p 80:80 -v /mnt/hdd1/ncdata:/data --restart unless-stopped --name nc1 ownyourbits/nextcloudpi 192.168.10.103 

docker run -d -p 4443:4443 -p 443:443 -p 80:80 -v /mnt/hdd1/nc1:/data --restart unless-stopped --name nc1 ownyourbits/nextcloudpi 192.168.10.103

ncp
/7nAZqPhBT/PJAQzxbtwD1DdMfxS+v4o7DudFUvJRw4

nc
+j9ufptYyVuFuux22/o8Fq4eVv3+I7R+R4t3yAwL8A8