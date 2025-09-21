# Ansible 
## Setup
1. On Ansible_Server EC2 Instance:

Add ansibleadmin user
```bash
useradd ansibleadmin
passwd ansibleadmin
nano /etc/sudoers # ansibleadmin ALL=(ALL) NOPASSWD: ALL
nano /etc/ssh/sshd_config # passwordAuthentication yes
service sshd reload 
```

Generate SSH key
```bash
# Your identification has been saved in /home/ansibleadmin/.ssh/id_rsa
# Your public key has been saved in /home/ansibleadmin/.ssh/id_rsa.pub
ssh-keygen
```

Install Ansible
```bash
yum install -y ansible
```
2. On Docker_Server EC2 Instance

Add ansibleadmin
```bash
useradd ansibleadmin
passwd ansibleadmin
sudo usermod -aG docker ansibleadmin # Add to docker group
nano /etc/sudoers  # ansibleadmin ALL=(ALL) NOPASSWD: ALL
nano /etc/ssh/sshd_config # passwordAuthentication yes
service sshd reload
```

## Non-password access - SSH Access
1. On Docker server - Check IP address
```bash
ifconfig # Something like 172.31.18.139
```
2. On Ansible server - Add IP to Ansible host
```bash
ansible-config dump | grep DEFAULT_HOST_LIST # Check host location
nano /etc/ansible/hosts # Add ip to this file
```
3. On Ansible server - Form SSH connection
```bash
ansible-config dump | grep DEFAULT_HOST_LIST # Check host location
sudo su - ansibleadmin
cat .ssh/id_rsa.pub #View public key
ssh-copy-id [the-ip-address-of-docker-server] # 172.31.18.139
```
4. On Docker server - Test SSH connection
```bash
sudo su - ansibleadmin
cat .ssh/authorized_keys #View public key from Ansible server
```
5. On Ansible server - Try some command
```bash
ssh <docker_server_ip> # Login via SSH
ansible all -m ping
ansible all -m command -a uptime
```

## Integrate Ansible with Jenkins
### Setup Docker
1. Add ansible-server to ssh-server
2. Install docker on Ansible server
```bash
sudo yum install docker -y
sudo usermod -aG docker ansibleadmin 
sudo service docker start
```

### Create Dockerfile for building images
```bash
nano Dockerfile
```
```bash
!Dockerfile
FROM tomcat:latest
RUN cp -R /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps
COPY ./*.war /usr/local/tomcat/webapps
```
Then: Build docker images and run docker container

### Add ansible IP to ansible host
```bash
ansible-config dump | grep DEFAULT_HOST_LIST # Check host location
sudo nano /etc/ansible/hosts
ssh-copy-id [the-ip-address-of-ansible-server] 
```

### Ansible Playbook
```bash
nano buildAndPush.yml
ansible-playbook buildAndPush.yml
```

### Push images to Docker Hub
```bash
docker login #quihuynh passwords3cret
docker push <image_name>
```