#!/bin/bash
#Description : Docker Installation on Centos 7 and Ubuntu18.04 sytems 
#Author: Ted Gadie
#Date: 3/5/2022
#Instructions : Create a User account before running the script. 
#               At the end of the installation the script will prompt you for a user account. 
#               That user account will be given access to all Docker commands.
# How to create a user account ?
# useradd username
# passwd username   

BIT=`getconf LONG_BIT`
user=`whoami`

if [ $user != root ]
    then
    echo -e "\n You need root access to run this installation.\n"
    exit 2
fi

#run a test to check for the OS of the system
OS=`cat /etc/os-release | grep ^ID= | awk -F '=' '{print$2}'`
echo -e "Your Linux Operation system flavor is : $OS \n"

if
   [ $OS = "\"centos"\" ]
   then
   echo -e "\n Docker Installation on the " $OS " server in progress...\n"
   sleep 1
   #Docker installation on Centos 7 launched...
   yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engin ec
   sleep 1
   yum install yum-utils -y
   yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo -y
   sleep 2 
   sudo yum install docker-ce docker-ce-cli contained.io -y
   sleep 2
   #Start and enable  the daemon 
   systemctl start  docker
   systemctl enable docker
   systemctl status docker | grep active |awk -F ":" '{print$2$3$4$5}'
   sleep 3
   #Spit out the version of Docker
   DockVersion=`docker --version | awk -F "," '{print$1}'`
   echo -e  "\n $DockVersion is successfully installed... \n"
   #End of Docker installation

   #add a specific account to run docker commands
    echo -e "\n Enter a user account to allow user to run docker commands \n"
    read user
    usermod -aG docker $user
    echo -e "\n The user was successfully added to the Docker group \n" && groups $user
elif
   [ $OS = ubuntu ]
   then
   if  [ $BIT -eq 64 ] #Run bitness check only if system is Ubuntu.
       then
       echo -e "\n The system is  64 bits \n"
       echo -e "\n Docker Installation on the " $OS " server in progress...\n"
       sleep 1
       #Docker installation on Ubuntu launched...
       apt-get remove docker docker-engine docker.io containerd runc -y
       sleep 1
       apt-get update
       apt-get install ca-certificates curl gnupg lsb-release -y 
       sleep 2
       curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
       sleep 1
       echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/kyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
       sleep 1
#________________________________________________________________
    #The commented out command below throwing error messages so docker.io is my alternative here. 
    apt install docker.io -y
    # apt-get upgdatevim
    # apt-get install docker-ce docker-ce-cli containerdvim.io
#________________________________________________________________
       sleep 1
       #Start and enable  the daemon 
       systemctl start  docker
       systemctl enable docker
       systemctl status docker | grep active |awk -F ":" '{print$2$3$4$5}'
       sleep 3 
       #Spit out the version of Docker
       DockVersion=`docker --version | awk -F "," '{print$1}'`
       echo -e  "\n $DockVersion is successfully installed... \n"
       #End of Docker installation

       #add a specific account to run docker commands
       echo -e "\n Enter a user account to allow user to run docker commands \n"
       read user
       usermod -aG docker $user
       echo -e "\n The user was successfully added to the Docker group \n" && groups $user
   else
       echo -e "\n system is 32 bits \n"
       echo -e "\n To install docker, you need the 64-bits version of the Ubuntu 18.04 OS or any recent Ubuntu version.\n"
       exit 2
   fi
else
   sleep 1
   echo -e "\n Docker cannot be installed, System is not running  a Centos or Ubuntu operation system, ask your administrator for help. \n"
fi
