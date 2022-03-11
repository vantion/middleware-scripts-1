#!/bin/bash
#Author: Ted Gadie
#Date: 3/11/2022
#Description: Installation of Jenkins on a CentOS 7 server 

user=`whoami`
if [ $user != root ]
   then
   echo -e "\n You need root access to run this installation.\n"
   exit 2
fi

echo -e  "\n Jenkins installation in process...\n "
sleep 1

  # Installations 
yum install java-1.8.0-openjdk-devel wget jenkins -y
if [ $? -ne 0 ]
   then
   echo -e "\n System error installing dependencies \n"
   exit 3
fi

sleep 2
wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo       
sudo sed -i 's/gpgcheck=1/gpgcheck=0/g' /etc/yum.repos.d/jenkins.repo

sleep 2
systemctl start jenkins
systemctl enable jenkins

  # Status of the jenkins Daemon
systemctl status jenkins | grep active |awk -F ":" '{print$2$3$4$5}'

  # Open port 8080
sleep 1
sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp
sudo firewall-cmd --reload

  # Open the browser and test the ip address

echo -e "\n The Jenkins Installation was successful, follow the link below... \n"
sleep 1
ipaddr=`hostname -I |awk '{print$2}'`
echo -e  "\n http://$ipaddr:8080 \n"
