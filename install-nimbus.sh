bash docker-install.sh

#sudo docker run -d --restart always -p 2181:2181 zookeeper

ADRR=(${3//,/ })

sudo docker login $4 --username="$5" --password="$6"

sudo docker run -d --restart always --name=$1  -e NIMBUS1=$1 -e NIMBUS2=$2 -e ZK1=${ADRR[0]} -e ZK2=${ADRR[1]} -e ZK3=${ADRR[2]} -e ZK_PORT=2181 -p 6627:6627 -h $1 $4/storm-docker storm nimbus

sudo docker run -d --restart always --link $1 -e NIMBUS1=$1 -e NIMBUS2=$2 -e ZK1=${ADRR[0]} -e ZK2=${ADRR[1]} -e ZK3=${ADRR[2]} -e ZK_PORT=2181 -p 8099:8099 $4/storm-docker storm ui
