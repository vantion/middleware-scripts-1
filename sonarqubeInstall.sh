#!/bin/bash
#Description: Installation of Sonarqube on CentOS7
#Author: Ted Gadie
#Date: 3/5/2022


echo "Sonarqube installation on Centos 7 in progress ..."
sleep 3
sudo yum update -y
sudo yum install java-11-openjdk-devel java-11-openjdk wget unzip net-tools -y
cd /opt 
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.3.0.51899.zip
sudo unzip /opt/sonarqube-9.3.0.51899.zip
sudo chown -R vagrant:vagrant /opt/sonarqube-9.3.0.51899
cd /opt/sonarqube-9.3.0.51899/bin/linux-x86-64
./sonar.sh start
echo
echo "Installation was successful !"
echo "system starting Sonarqube now..."
sleep 1
echo "System in the process of retrieving current ip address..."
sleep 2
echo "Follow the link below to access the application on the browser : "
ipaddr=`hostname -I |awk '{print$2}'`
echo -e  "\n http://$ipaddr:8080 \n"


#NB: Some servers have firewall enabled. So if you are not able to connect 
#from the browser, then you might want to open the port 9000 with this command:

#Delete the pound sign at the beginning of both commmand below
#Proceed by running the program again
 
#sudo firewall-cmd --permanent --add-port=9000/tcp
#sudo firewall-cmd --reload
