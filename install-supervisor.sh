bash docker-install.sh
privateIp="$(hostname -i)"
logDir=/var/log/storm/
dataDir=/mnt/storm	
mountDir=/fileshare
bash mount-blob-container.sh $7 $8 $9 $mountDir
mountDir=$mountDir/$1/$privateIp
sudo mkdir -p $mountDir
ADRR=(${3//,/ })
sudo docker login $4 --username="$5" --password="$6"
sudo docker pull $4/storm-docker:latest
if [ $# -ge 10 ]; then
dockerId="$(sudo docker run -d --restart always -e NIMBUS1=$1 -e NIMBUS2=$2 -e ZK1=${ADRR[0]} -e ZK2=${ADRR[1]} -e ZK3=${ADRR[2]} -e ZK_PORT=2181 -e GRAPHITE_HOST=${10} -e GRAPHITE_PORT=${11} -p 6700:6700 -p 6701:6701 -p 6702:6702 -p 6703:6703 -v $logDir:/logs -v  $dataDir:/data -h $privateIp $4/storm-docker storm supervisor)"
else
dockerId="$(sudo docker run -d --restart always -e NIMBUS1=$1 -e NIMBUS2=$2 -e ZK1=${ADRR[0]} -e ZK2=${ADRR[1]} -e ZK3=${ADRR[2]} -e ZK_PORT=2181 -p 6700:6700 -p 6701:6701 -p 6702:6702 -p 6703:6703 -v $logDir:/logs -v  $dataDir:/data -h $privateIp $4/storm-docker storm supervisor)"
fi
sudo crontab -l > mycron
sudo echo "05 * * * * rsync -av /var/log/storm $mountDir" >> mycron
sudo crontab mycron
sudo rm mycron
