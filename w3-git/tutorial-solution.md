# Week 3 Tutorial
## Set up SSH
## On EC2 at ~
1. Generate SSH
```bash
ssh-keygen -t rsa -b 4096 -C "s4023710@rmit.edu.vn"
```
2. Enter 3 times for 3 prompts
3. Start the ssh-agent in the background
```bash
eval "$(ssh-agent -s)"
```
4. Add Your SSH private key to the ssh-agent
```bash
ssh-add ~/.ssh/id_rsa
```
5. Copy the SSH key to add to GitHub account
```bash
cat ~/.ssh/id_rsa.pub
```
6. Add the SSH Key to Your GitHub Account
- Go to your GitHub account settings.
- Navigate to the “SSH and GPG keys” section.
- Click on “New SSH Key,” give it a descriptive title, and paste the copied public key.
Save the key.
7. Test the SSH
```bash
ssh -T git@github.com
```

8. Go to the project folder
```bash
git remote add origin git@github.com:quihuynhlediem/<project_name>.git
```
```bash
git remote set-url origin git@github.com:quihuynhlediem/<project_name>.git
```

## Resolve conflicts
1. Merge main
```bash
git merge main
```
2. Enter the conflict file
```bash
nano conflict_file.txt
```
3. Resolve conflicts
4. Push as normal
```bash
git add .
git commit -m "resolve conflicts"
git push
```