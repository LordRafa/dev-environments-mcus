#!/usr/bin/env bash

if [ ! -z "$(docker ps -qf name=dev-environments-mcus)" ]; then

  if [ "$ACTION" == "add" ]; then

    docker exec -u 0 dev-environments-mcus mkdir -p $(dirname $DEVNAME)
    docker exec -u 0 dev-environments-mcus mknod $DEVNAME c $MAJOR $MINOR
    docker exec -u 0 dev-environments-mcus chmod -R 777 $DEVNAME

  elif [ "$ACTION" == "remove" ]; then

    docker exec -u 0 dev-environments-mcus rm $DEVNAME
    docker exec -u 0 dev-environments-mcus rmdir -p $(dirname $DEVNAME)

  fi

fi

