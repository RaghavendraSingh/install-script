#bash docker-install.sh
apt-get -y update && apt-get -y install docker.io
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

#cores=$(nproc --all)
cores=$(($(nproc --all)*2))
worker_ports=""
echo $cores
for i in `seq 0 $cores`
do
if [ $i -lt 10 ]; then
worker_ports=$worker_ports' -p 670'$i':670'$i
else
worker_ports=$worker_ports' -p 67'$i':67'$i
fi
done


if [[ ! -z $GRAPHITE_HOST ]]; then
dockerId="$(sudo docker run -d --restart always -e NIMBUS1=$1 -e NIMBUS2=$2 -e ZK1=${ADRR[0]} -e ZK2=${ADRR[1]} -e ZK3=${ADRR[2]} -e ZK_PORT=2181 -e GRAPHITE_HOST=${11} -e GRAPHITE_PORT=${12} -e SUPERVISOR_IP=$privateIp -e INSTALL_TAG=${10} $worker_ports -p 2256:2256 -v $mountDir:/logs -v  $dataDir:/data -h $privateIp $4/storm-docker storm supervisor)"
else
dockerId="$(sudo docker run -d --restart always -e NIMBUS1=$1 -e NIMBUS2=$2 -e ZK1=${ADRR[0]} -e ZK2=${ADRR[1]} -e ZK3=${ADRR[2]} -e ZK_PORT=2181 -p $worker_ports -v $mountDir:/logs -v  $dataDir:/data -h $privateIp $4/storm-docker storm supervisor)"
fi
