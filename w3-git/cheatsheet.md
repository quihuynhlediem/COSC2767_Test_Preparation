# Week 3 Cheat Sheet
## Set up project on local
1. Create folder and enter it:
```bash
mkdir project_folder
cd project_folder
```
2. Init Git project
```bash
git init
```
3. Check branches
```bash
git branch -a
```
4. Check current status
```bash
git status
```
5. View past commits on a branch
```bash
git log # Long version
```
```bash
git log --graph --decorate --oneline # Short version
```

## Connect with remote repository
0. Set default remote url:
```bash
git remote set-url origin git@github.com:quihuynhlediem/<project_name>.git
```
1. Add origin:
```bash
git remote add origin git@github.com:quihuynhlediem/<project_name>.git
```
2. List origin
```bash
git remote -v
```
3. Remove origin
```bash
git remote remove origin
```