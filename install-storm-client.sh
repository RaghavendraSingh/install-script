#install java
add-apt-repository ppa:openjdk-r/ppa
apt-get update
apt-get install openjdk-8-jdk
update-alternatives --config java
chmod a+x /usr/bin/java
chmod a+x /usr/bin/javac

user=$1
cd /home/$user
wget https://archive.apache.org/dist/storm/apache-storm-1.1.0/apache-storm-1.1.0.tar.gz
tar -zxvf apache-storm-1.1.0.tar.gz
cd apache-storm-1.1.0/bin
binPath="$(pwd)"
echo "export PATH=$PATH:$binPath" >> /home/$user/.bashrc
export PATH=$PATH:$binPath
