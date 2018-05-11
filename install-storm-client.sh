#install java
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u171-b11/512cd62ec5174c3487ac17c61aaa89e8/jdk-8u171-linux-x64.tar.gz"
tar -xvf jdk-8*
mkdir /usr/lib/jvm
mv ./jdk1.8* /usr/lib/jvm/jdk1.8.0
update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk1.8.0/bin/java" 1
update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/jdk1.8.0/bin/javac" 1
update-alternatives --install "/usr/bin/javaws" "javaws" "/usr/lib/jvm/jdk1.8.0/bin/javaws" 1
chmod a+x /usr/bin/java
chmod a+x /usr/bin/javac
chmod a+x /usr/bin/javaws


wget https://archive.apache.org/dist/storm/apache-storm-1.1.0/apache-storm-1.1.0.tar.gz
tar -zxvf apache-storm-1.1.0.tar.gz
cd apache-storm-1.1.0/bin
binPath="$(pwd)"
echo "export PATH=$PATH:$binPath" >> ~/.bashrc
export PATH=$PATH:$binPath
