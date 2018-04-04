sudo docker run -d --restart always -p 2181:2181 zookeeper

sudo docker run -d --restart always --name=$1  -e NIMBUS_SEEDS=$1 -e ZK1=$2 -e ZK_PORT=2181 -p 6627:6627 abhishektripathi138/storm-docker storm nimbus

sudo docker run -d --restart always --link abhishektripathi138/storm-docker -e NIMBUS_SEEDS=$1 -e ZK1=$2 -e ZK_PORT=2181 -p 8099:8099 abhishektripathi138/storm-docker storm ui
