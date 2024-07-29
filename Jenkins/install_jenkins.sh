#!/bin/bash
# Update the package list and install required packages
sudo apt-get update -y
sudo apt-get upgrade -y

# Add the Jenkins Debian repository and key
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

# Update the package list to include Jenkins packages
sudo apt-get update -y

# Install Jenkins and Java
sudo apt-get install jenkins openjdk-11-jdk -y

# Start and enable Jenkins service
sudo systemctl start jenkins
sudo systemctl enable jenkins
