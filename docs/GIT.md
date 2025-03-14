# General commands
## clone repository
```sh
git clone repo_link_or_ssh_address
```
## Adding file named xyz.py 
```bash
git add xyz.py
```
## Adding all files in current directory
```bash
git add . 
```
## Commiting files
```bash
git commit -m "commit message"
```
## pushing changes
```bash
git push
```
## fetching for changes and pulling changes
```bash
git fetch
git pull
```
# branching 
## creating new local branch named XYZ
```sh
git checkout -b XYZ
```
## pushing new local branch to remote 
```sh
git push --set-upstream origin XYZ
```
# "I'm kinda fucked up" helpers:
## what is status of current project
```bash
git status
```
## show last commit
```bash
git show
```
## reset hard to last commited and pushed change
```bash
git reset --hard
```

