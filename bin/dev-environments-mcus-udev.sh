#!/usr/bin/env bash

echo "Usb event: $ACTION $DEVNAME $MAJOR $MINOR" >> /tmp/docker_tty.log

if [ ! -z "$(docker ps -qf name=dev-environments-mcus)" ]; then

  if [ "$ACTION" == "add" ]; then

    docker exec -u 0 dev-environments-mcus mknod $DEVNAME c $MAJOR $MINOR
    docker exec -u 0 dev-environments-mcus chmod -R 777 $DEVNAME
    echo "Adding $DEVNAME to docker" >> /tmp/docker_tty.log

  elif [ "$ACTION" == "remove" ]; then

    docker exec -u 0 dev-environments-mcus rm $DEVNAME
    echo "Removing $DEVNAME from docker" >> /tmp/docker_tty.log

  fi

fi
