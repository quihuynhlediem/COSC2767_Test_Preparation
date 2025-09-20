# Users - Groups - Access
1. File for storing user registry:
```bash
cat /etc/passwd 
```
2. File for storing user registry:
```bash
cat /etc/group 
```
3. Add new user
```bash
useradd <user> 
```
```bash
useradd dockeradmin 
```
4. Change password for new user
```bash
passwd dockeradmin 
```
5. Check group user belongs to
```bash
id <user> 
```
```bash
id dockeradmin 
```
6. Add an user to a group
```bash
usermod -aG <group> <user> 
```
```bash
usermod -aG docker dockeradmin
```
7. Allow login via password
```bash
nano /etc/ssh/sshd_config 
```
Then change PasswordAuthentication to "yes"
```bash
service sshd reload
```