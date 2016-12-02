#!/bin/bash

sudo service docker status
if [ $? -ne 0 ]; then
  echo "abort, docker service not running."
  exit 1
fi

CONTAINER_NAME=gitlab-runner-robot
IMAGE_NAME=brandontsai/gitlab-ci-runner-robot-framework

build(){
  sudo docker build -t $IMAGE_NAME ./
}

run(){
  sudo docker run -it -d --name $CONTAINER_NAME \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v /srv/gitlab-runner/config:/etc/gitlab-runner \
        $IMAGE_NAME
  sleep 2
  sudo docker ps -a
}

exec(){
  sudo docker exec -it $CONTAINER_NAME /bin/bash
}

rm(){
  sudo docker stop $CONTAINER_NAME
  sudo docker rm $CONTAINER_NAME
}

$1 
