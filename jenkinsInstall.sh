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
    yum install java-1.8.0-openjdk-devel wget -y
    if [ $? -ne 0 ]
	       then
		          echo -e "\n System error installing packages \n"
			     exit 3
    fi

    sleep 2
    wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo 
    sleep 2
    sed -i 's/gpgcheck=1/gpgcheck=0/g' /etc/yum.repos.d/jenkins.repo

    sleep 2

    yum install jenkins -y

    sleep 1
        # Activation of the jenkins Daemon service
	systemctl start jenkins
	systemctl enable jenkins
	systemctl status jenkins | grep active |awk -F ":" '{print$2$3$4$5}'

	    # Opening port 8080
	    sleep 1 
	    firewall-cmd --permanent --zone=public --add-port=8080/tcp
	    firewall-cmd --reload

	        # Open the browser and test the ip address 
		echo -e "\n The Jenkins Installation was successful, follow the link below... \n"
		sleep 1
		ipaddr=`hostname -I |awk '{print$2}'`
		echo -e  "\n http://$ipaddr:8080 \n" 

		# Unlock Jenkins on the browser :

		echo "Please copy the password below to unlock Jenkins on the browser:"
		Password=`cat /var/lib/jenkins/secrets/initialAdminPassword`
		echo -e "\n$Password\n"
