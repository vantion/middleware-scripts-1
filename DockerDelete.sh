#!/bin/bash 
#Author: Ted Gadie
#Date  : 3/12/2022
#Description:  REMOVE ALL IMAGES AND EXITED CONTAINERS ON THE SERVER


user=`whoami`
GROUP=`groups $user|awk '{print$4}'`

#User authentication before running the program
if [[ ${GROUP} != docker ]] && [[ ${user} != root ]]
    then 
    echo " Only members of the group Docker are allowed to run this program !"
    exit 2
fi

# Delete all exited docker containers
DeleteContainers () {
    docker rm $(docker ps -a -f status=exited -q)
    echo  "Removal of all exited containers..."
    sleep 1
    echo "All exited Docker containers successfully removed"
  }
# Delete all docker images
DeleteImages () {
    docker rmi $(docker images -a -q)
    echo "Removal of all images completed..."
    sleep 1
    echo "All Docker images successfully removed"
  }
#Function for users typing any other keys then [y/n]
Wrong_Key_typed () {
    count=0
        while [ ${count} -eq 0 ]
            do
                echo -e "\n This action will delete all exited Docker containers Press [y/n] to proceed : \n"
                    read value
                    if [ $value = "y" ] || [ $value = "Y" ] || [ $value = "yes" ] || [ $value = "YES" ] || [ $value = "Yes" ]
                        then
                        DeleteContainers

                        echo -e "\nThis action will delete all Docker images containers Press [y/n] to proceed : \n"

                        read val
                        if [ $val = "y" ] || [ $val = "Y" ] || [ $val = "yes" ] || [ $val = "YES" ] || [ $val = "Yes" ]
                            then
                            DeleteImages
                            exit 0
                        elif
                        [ $val = "n" ] || [ $val = "N" ] || [ $val = "no" ] || [ $val = "NO" ] || [ $val = "No" ]
                            then
                            echo -e "\nDocker image Deleting process successfully interrupted.\n"    
                            exit 0
                        fi
                    elif
                        [ $value = "n" ] || [ $value = "N" ] || [ $value = "no" ] || [ $value = "NO" ] || [ $value = "No" ]
                        then
                        echo -e "\nDeleting process successfully interrupted.\n"
                        exit 0
                    else
                        echo "Invalid key entered, try again !!!"
                    fi
            done
 }


echo " Remove all images and exited containers on the server : "

Wrong_Key_typed
