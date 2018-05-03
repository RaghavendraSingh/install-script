bash docker-install.sh

#sudo docker run -d --restart always -p 2181:2181 zookeeper

ADRR=(${3//,/ })
logDir=/var/log/storm/
dataDir=/mnt/storm	
sudo docker login $4 --username="$5" --password="$6"
if [ $# ge 7 ]; then
sudo docker run -d --restart always --name=$1  -e NIMBUS1=$1 -e NIMBUS2=$2 -e ZK1=${ADRR[0]} -e ZK2=${ADRR[1]} -e ZK3=${ADRR[2]} -e ZK_PORT=2181 -p 6627:6627 -e GRAPHITE_HOST=${7} -e GRAPHITE_PORT=${8} -h $1 -v $logDir:/logs -v $dataDir:/data $4/storm-docker storm nimbus
else
sudo docker run -d --restart always --link $1 -e NIMBUS1=$1 -e NIMBUS2=$2 -e ZK1=${ADRR[0]} -e ZK2=${ADRR[1]} -e ZK3=${ADRR[2]} -e ZK_PORT=2181 -p 8099:8099 -v $logDir:/logs -v  $dataDir:/data $4/storm-docker storm ui
fi
