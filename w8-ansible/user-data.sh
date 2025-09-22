#!/bin/bash
# Set hostname
echo "ansible-slave" > /etc/hostname
hostnamectl set-hostname ansible-slave

# Update packages and install dependencies
yum install -y docker

# Start Docker service and enable it on boot
systemctl start docker
systemctl enable docker

# Add a user for Ansible
useradd ansibleadmin
echo "ansibleadmin:password" | chpasswd
usermod -aG docker ansibleadmin

# Allow passwordless sudo for ansibleadmin
echo "ansibleadmin ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set up SSH for ansibleadmin
mkdir -p /home/ansibleadmin/.ssh
# Please copy and and paste public key of Ansible master
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCkP+hdwXAohpdcDGBfcBmzVhCDc8B2mZaFCj0HMS4Z6rXCN5SwqW5ZISRIWq71K3pkt7mHxEKbxh77RVQHaUNF1FnHs8gc2J+nC/bcX3W3RNq/8xL4Uw17TGeVlFEi8pFVkcUf5j+VyoYlqmNZX5XnqPfQdheyuSGBru0FPAbUlR3x6N/3/V/oGThvvlNqBWFKGxby5gwNoxJpMsBfPiDpQsas/tq8xK4dxDT+bq1IKIgD9Gp079BGIGcAB5+85nLfnuro43PfI/OV8ddNOhRwjVfLL55cA4nwe6sGjedmN2KTEquYJ8PMqF6YRG+02yvlxM05RXBQORq0uBMVjH2xd8/nMTFG/kiWlnW7HsUSiuVMdiEqWcs/HuI3LrWo9ZWLiVg06ygflM7eUz41xUiSaZu/irGs+SN84SsK62vbTVyIfWxbWRNWtX2u00vPyS2LlcQqiwdHnvjfepTlzofyYUpngMRULM2SoknZLcuBoQjDWGAMgcOD6qdBrHHUDgs= ansibleadmin@ansible-server" > /home/ansibleadmin/.ssh/authorized_keys
chown -R ansibleadmin:ansibleadmin /home/ansibleadmin/.ssh
chmod 600 /home/ansibleadmin/.ssh/authorized_keys

# Enable password authentication for SSH
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl restart sshd