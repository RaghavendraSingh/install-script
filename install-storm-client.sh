wget https://archive.apache.org/dist/storm/apache-storm-1.1.0/apache-storm-1.1.0.tar.gz
tar -zxvf apache-storm-1.1.0.tar.gz
cd apache-storm-1.1.0/bin
binPath="$(pwd)"
echo "export PATH=$PATH:$binPath" >> ~/.bashrc
export PATH=$PATH:$binPath
