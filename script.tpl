#!/bin/bash
#* wait until efs mount is finished
sleep 2m
#* update the instnce
sudo yum update -y
sudo yum install git -y 
#* install docker
sudo yum install -y docker
#* let it be run without sudo
sudo usermod -a -G docker ec2-user
#* start docker engine
sudo service docker start
sudo chkconfig docker on
#* install docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-`uname -s`-`uname -m` | sudo tee /usr/local/bin/docker-compose > /dev/null
#* make it executable
sudo chmod +x /usr/local/bin/docker-compose
#* link docker-compose with bin folder so it can be called globally
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

sudo groupadd -f docker-compose
#* give it permission to work without sudo
sudo usermod -a -G docker-compose ec2-user
#* run docker-compose.yaml
sudo git clone https://github.com/manzajohn/wordpressdocker.git /home/ec2-user/wordpress-docker
sudo docker-compose -f /home/ec2-user/wordpress-docker/docker-compose.yaml up --build -d
