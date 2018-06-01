apt-get -y update && apt-get -y install docker.io

logDir=/var/log/zookeeper/
dataDir=/mnt/zookeeper
sudo docker login $3 --username="$4" --password="$5"
#GRAPHITE_HOST=${11}

# enabling metrics if graphite host is set
sudo docker pull $3/zk-docker:latest && sudo docker run -d --restart always --net=host -e ZK_IPS=$1 -e ZK_ID=$2 -v $logDir:/logs -v $dataDir:/data $3/zk-docker 

