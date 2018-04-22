wget https://packages.microsoft.com/config/ubuntu/14.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get update
sudo apt-get install blobfuse
sudo mkdir -p /mnt/ramdisk
sudo mount -t tmpfs -o size=16g tmpfs /mnt/ramdisk
sudo mkdir -p /mnt/ramdisk/blobfusetmp
touch fuse_connection.cfg
echo "accountName $1" >> fuse_connection.cfg
echo "accountKey $2" >> fuse_connection.cfg
echo "containerName $3" >> fuse_connection.cfg
chmod 700 fuse_connection.cfg
sudo mkdir /fileshare
sudo blobfuse /fileshare --tmp-path=/mnt/ramdisk/blobfusetmp  --config-file=fuse_connection.cfg -o attr_timeout=240 -o entry_timeout=240 -o negative_timeout=120
