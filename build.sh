#!/bin/bash

# Written by: Stan Towianski - Oct 2016

echo ""
echo -n "Jenkins version to install 1) 1.651.3,  2) 2.7.4  3) [2.19.2] : "
read ans

if [ "$ans" = "1" ];
then
JENKINS_VERSION="1.651.3"
elif [ "$ans" = "2" ];
then
JENKINS_VERSION="2.7.4"
elif [ "$ans" = "3" ] || [ "$ans" = "" ];
then
JENKINS_VERSION="2.19.2"
else
JENKINS_VERSION="$ans"
fi


echo ""
echo -n "base docker image to use 1) [centos], 2) revive/scientific-linux : "
read docker_base_image

if [ "$docker_base_image" = "1" ] || [ "$docker_base_image" = "centos" ] || [ "$docker_base_image" = "" ];
then
docker_base_image="centos"
dockerfile="./Dockerfile.centos"
NEW_IMAGE_NAME=jm-centos:1.0
elif [ "$docker_base_image" = "2" ] || [ "$docker_base_image" = "scientific" ];
then
docker_base_image="revive/scientific-linux"
dockerfile="./Dockerfile.scientific"
NEW_IMAGE_NAME=jm-scientific:1.0
else
cp ./Dockerfile.centos ./Dockerfile.other
sed -i -e "s/FROM centos.*/From \\$docker_base_image/g" ./Dockerfile.other
dockerfile="./Dockerfile.other"
NEW_IMAGE_NAME=jm-other
fi


echo ""
echo -n "Run as daemon N, [Y] ? "
read ans

if  [ "$ans" = "N" ] || [ "$ans" = "n" ];
then
daemon_flag=""
else
daemon_flag="-d"
fi


echo ""
echo -n "Start Jenkins when done N, [Y] ? "
read ans

if  [ "$ans" = "N" ] || [ "$ans" = "n" ];
then
start_flag="N"
else
start_flag="Y"
fi


TIMEZONE="America/Detroit"
host_jenkins_home=/encrypt/data/jenkins_home

### do Build ###

echo ""
docker build -t $NEW_IMAGE_NAME --build-arg JENKINS_VERSION=$JENKINS_VERSION --build-arg TIMEZONE=$TIMEZONE -f $dockerfile .

docker images


### Create start script ###

echo "#!/bin/bash" > start-docker-jenkins.sh

echo "# Written by: Stan Towianski - Oct 2016" >> start-docker-jenkins.sh

echo "/usr/bin/docker run $daemon_flag -p 8080:8080 --sysctl net.ipv6.conf.all.disable_ipv6=1 -v $host_jenkins_home:/var/jenkins_home --env JENKINS_OPTS="--prefix=/jenkins" --name jm $NEW_IMAGE_NAME" >> start-docker-jenkins.sh

cat start-docker-jenkins.sh

### Create kill and rmi script ###

echo "#!/bin/bash" > kill-rmi.sh

echo "# Written by: Stan Towianski - Oct 2016" >> kill-rmi.sh

echo "docker images" >> kill-rmi.sh

echo "docker stop jm" >> kill-rmi.sh
echo "docker rm jm" >> kill-rmi.sh
echo "docker rmi $NEW_IMAGE_NAME" >> kill-rmi.sh

echo "docker images" >> kill-rmi.sh

### Start Jenkins ? ###

if  [ "$start_flag" = "Y" ];
then
echo "Will start Jenkins"
./start-docker-jenkins.sh
fi
