bash docker-install.sh

IFS=',' read -ra ADDR <<< "$2"

sudo docker run -d --restart always -e NIMBUS_SEEDS=$2 -e ZK1=${ADRR[0]} -e ZK2=${ADRR[1]} -e ZK3=${ADRR[2]} -e ZK_PORT=2181 -p 6700:6700 -p 6701:6701 -p 6702:6702 -p 6703:6703 abhishektripathi138/storm-docker storm supervisor
