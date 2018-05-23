#bash docker-install.sh
apt-get -y update && apt-get -y install docker.io
#sudo docker run -d --restart always -p 2181:2181 zookeeper

ADRR=(${3//,/ })
logDir=/var/log/storm/
dataDir=/mnt/storm
mountDir=$logDir
bash mount-blob-container.sh $7 $8 $9 $mountDir
mountDir=$mountDir/${10}/nimbus-$1
sudo mkdir -p $mountDir
echo $# 
sudo docker login $4 --username="$5" --password="$6"
GRAPHITE_HOST=${11}

# enabling metrics if graphite host is set
if [[ ! -z $GRAPHITE_HOST ]]; then
sudo docker pull $4/storm-docker:latest && sudo docker run -d --restart always --name=$1  -e NIMBUS1=$1 -e NIMBUS2=$2 -e ZK1=${ADRR[0]} -e ZK2=${ADRR[1]} -e ZK3=${ADRR[2]} -e ZK_PORT=2181 -p 6627:6627 -p 2255:2255 -e GRAPHITE_HOST=${11} -e GRAPHITE_PORT=${12} -e INSTALL_TAG=${10} -h $1 -v $mountDir:/logs -v $dataDir:/data $4/storm-docker storm nimbus
else
sudo docker pull $4/storm-docker:latest && sudo docker run -d --restart always --name=$1  -e NIMBUS1=$1 -e NIMBUS2=$2 -e ZK1=${ADRR[0]} -e ZK2=${ADRR[1]} -e ZK3=${ADRR[2]} -e ZK_PORT=2181 -p 6627:6627 -h $1 -v $mountDir:/logs -v $dataDir:/data $4/storm-docker storm nimbus
fi
sudo docker pull $4/storm-docker:latest && sudo docker run -d --restart always --link $1 -e NIMBUS1=$1 -e NIMBUS2=$2 -e ZK1=${ADRR[0]} -e ZK2=${ADRR[1]} -e ZK3=${ADRR[2]} -e ZK_PORT=2181 -p 8099:8099 -v $mountDir:/logs -v  $dataDir:/data $4/storm-docker storm ui


