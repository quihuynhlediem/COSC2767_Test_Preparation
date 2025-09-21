#!/bin/bash

# Add new user - ansibleadmin
useradd ansibleadmin

HASH=$(openssl passwd -6 'password')
usermod --password "$HASH" testuser

# Give access and remove password required for sudo
echo "ansibleadmin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Allow access via password
sed -i -E 's/^\s*#?\s*PasswordAuthentication\s+.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Generate SSH key
# Your identification has been saved in /home/ansibleadmin/.ssh/id_rsa
# Your public key has been saved in /home/ansibleadmin/.ssh/id_rsa.pub
ssh-keygen

# Install ansible
yum install -y ansible