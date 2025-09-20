# Ansible 
# Setup
1. Change hostname:
```bash
nano /etc/hostname
```
2. Add user:
```bash
useradd ansibleadmin
```
Set password
```bash
passwd ansibleadmin
```
3. Check users:
```bash
nano /etc/sudoers 
```
Add this line to the end of the file
```bash
ansibleadmin ALL=(ALL) NOPASSWD: ALL
```
4. Enable user to login with password
```bash
nano /etc/ssh/sshd_config 
```
Change %PasswordAuthentication% to yes
```bash
service sshd reload
```