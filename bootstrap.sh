#!/bin/sh

yum install -y epel-release wget 

cd /etc/yum.repos.d

wget https://download.docker.com/linux/centos/docker-ce.repo

cd -

yum install -y docker-ce
service docker start
docker ps

cd /usr/local/bin
wget https://github.com/docker/compose/releases/download/v2.2.3/docker-compose-linux-x86_64
mv docker-compose-linux-x86_64 docker-compose
chmod +x docker-compose

/usr/local/bin/docker-compose -v
cd /vagrant/docker
if [ -z /u02 ]; then
	mkdir /u02
fi
cp -ar ./storage /u02/
chmod 777 /u02/app/storage/logs/error.log
chmod -R 777 /u02/app/storage/cache
/usr/local/bin/docker-compose up -d
sleep 60

docker ps

ls -la /opt/* /u02/*

curl -v https://localhost --insecure
