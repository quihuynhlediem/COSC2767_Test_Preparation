#!/bin/bash

# Change available disk space
echo 'tmpfs   /tmp    tmpfs   defaults,size=3G   0   0' >> /etc/fstab

# Remount without rebooting
mount -o remount /tmp

# Install Jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade

# Add required dependencies for the jenkins package
sudo yum install fontconfig java-17-amazon-corretto
sudo yum install jenkins
sudo systemctl daemon-reload

# Start Jenkins
service jenkins start

#View the password
cat /var/lib/jenkins/secrets/initialAdminPassword