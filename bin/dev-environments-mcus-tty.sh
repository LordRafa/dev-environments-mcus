#!/usr/bin/env bash  
                                                           
echo "Usb event: $1 $2 $3 $4" >> /tmp/docker_tty.log        
if [ ! -z "$(docker ps -qf name=dev-environments-mcus)" ]                                     
then                                                                            
if [ "$1" == "added" ]                                                          
    then                                                                        
        docker exec -u 0 dev-environments-mcus mknod $2 c $3 $4                               
        docker exec -u 0 dev-environments-mcus chmod -R 777 $2                                
        echo "Adding $2 to docker" >> /tmp/docker_tty.log                
    else                                                                        
        docker exec -u 0 dev-environments-mcus rm $2                                          
        echo "Removing $2 from docker" >> /tmp/docker_tty.log            
    fi                                                                          
fi

