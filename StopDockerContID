#!/bin/bash
#Author: Ted Gadie
#Date: 3/13/2022
#Description: [STOP ALL RUNNING DOCKER CONTAINERS]

## This Program will output the list of
## currently running containers
## and individually stopped them.  

user=`whoami`
GROUP=`groups $user|awk '{print$4}'`

#User authentication before running the program
if [[ ${GROUP} != docker ]] && [[ ${user} != root ]]
    then 
    echo " Only members of the group Docker are allowed to run this program !"
    exit 2
fi

#Redirect Docker Containers ID to a file in the /tmp directory
docker ps -q > /tmp/ContID

#Loop through the list of Container IDs and stop them
for id in $(cat /tmp/ContID);
do 
   ID=`docker stop $id`
   echo " $ID container stopped."
done

echo -e "\nAll running Containers were successfully stopped.\n"
 

