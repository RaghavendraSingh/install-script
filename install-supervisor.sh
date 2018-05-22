bash docker-install.sh
privateIp="$(hostname -i)"
logDir=/var/log/storm/
dataDir=/mnt/storm
mountDir=$logDir
bash mount-blob-container.sh $7 $8 $9 $mountDir
mountDir=$mountDir/${10}/supervisor-$privateIp
sudo mkdir -p $mountDir
ADRR=(${3//,/ })
sudo docker login $4 --username="$5" --password="$6"
sudo docker pull $4/storm-docker:latest
GRAPHITE_HOST=$11
if [[ ! -z $GRAPHITE_HOST ]]; then
dockerId="$(sudo docker run -d --restart always -e NIMBUS1=$1 -e NIMBUS2=$2 -e ZK1=${ADRR[0]} -e ZK2=${ADRR[1]} -e ZK3=${ADRR[2]} -e ZK_PORT=2181 -e GRAPHITE_HOST=${11} -e GRAPHITE_PORT=${12} -e SUPERVISOR_IP=$privateIp -e INSTALL_TAG=${10} -p 6700:6700 -p 6701:6701 -p 6702:6702 -p 6703:6703 -p 6704:6704 -p 6705:6705 -p 6706:6706 -p 6707:6707 -p 6708:6708 -p 6709:6709 -p 6710:6710 -p 2256:2256 -v $mountDir:/logs -v  $dataDir:/data -h $privateIp $4/storm-docker storm supervisor)"
else
dockerId="$(sudo docker run -d --restart always -e NIMBUS1=$1 -e NIMBUS2=$2 -e ZK1=${ADRR[0]} -e ZK2=${ADRR[1]} -e ZK3=${ADRR[2]} -e ZK_PORT=2181 -p 6700:6700 -p 6701:6701 -p 6702:6702 -p 6703:6703 -p 6704:6704 -p 6705:6705 -p 6706:6706 -p 6707:6707 -p 6708:6708 -p 6709:6709 -p 6710:6710 -v $mountDir:/logs -v  $dataDir:/data -h $privateIp $4/storm-docker storm supervisor)"
fi
