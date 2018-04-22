bash docker-install.sh
bash mount-blob-container.sh $7 $8 $9

ADRR=(${3//,/ })

sudo docker login $4 --username="$5" --password="$6"

sudo mkdir -p /var/log/storm
dockerId="$(sudo docker run -d --restart always -e NIMBUS1=$1 -e NIMBUS2=$2 -e ZK1=${ADRR[0]} -e ZK2=${ADRR[1]} -e ZK3=${ADRR[2]} -e ZK_PORT=2181 -p 6700:6700 -p 6701:6701 -p 6702:6702 -p 6703:6703 -v /var/log/storm:/logs $4/storm-docker storm supervisor)"
echo $dockerId
sudo mkdir -p /fileshare/stormlogs/$dockerId/

sudo crontab -l > mycron
sudo echo "30 00 * * * rsync -av /var/log/storm /fileshare/stormlogs/$dockerId/" >> mycron
sudo crontab mycron
sudo rm mycron
