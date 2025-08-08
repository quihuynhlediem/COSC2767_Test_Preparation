## Linux Command Line Cheat Sheet

## Basic Commands

**Check current date and time**
```bash
date                    # Display current date and time
date +"%Y-%m-%d"        # Display date in YYYY-MM-DD format
date +"%H:%M:%S"        # Display current time
```

**Get current user information**
```bash
whoami                  # Display current username
id                      # Display user ID and group information
users                   # Display currently logged in users
```

**Display text to screen**
```bash
echo "Hello World"      # Print text to terminal
echo $HOME              # Print environment variable
echo -n "text"          # Print without newline
```

**Check current working directory**
```bash
pwd                     # Print working directory (current location)
```

**Work with archive files**
```bash
tar -tf archive.tar     # List contents of tar file
tar -czf archive.tar.gz files/  # Create compressed archive
tar -xzf archive.tar.gz # Extract compressed archive
tar -xf archive.tar     # Extract uncompressed archive
```

## File and Directory Operations

**List files and directories**
```bash
ls          # Basic listing
ls -l       # Detailed listing
ls -la      # Include hidden files
ls -lh      # Human readable file sizes
```

**Change directory**
```bash
cd /path/to/directory    # Change to specific path
cd ..                    # Go up one directory
cd ~                     # Go to home directory
cd -                     # Go to previous directory
```

**Create directories**
```bash
mkdir dirname           # Create single directory
mkdir -p path/to/dir    # Create nested directories
```

**Create files**
```bash
touch filename          # Create empty file or update timestamp
echo "content" > file   # Create file with content (overwrites)
echo "content" >> file  # Append content to file
```

**Copy files and directories**
```bash
cp source dest          # Copy file
cp -r source dest       # Copy directory recursively
cp -i source dest       # Interactive copy (ask before overwrite)
```

**Move/rename files**
```bash
mv oldname newname      # Rename file/directory
mv file /path/to/dest   # Move file to destination
```

**Remove files and directories**
```bash
rm filename             # Remove file
rm -i filename          # Interactive removal
rm -r dirname           # Remove directory recursively
rm -rf dirname          # Force remove directory (be careful!)
rmdir dirname           # Remove empty directory
```

## File Content Operations

**View file contents**
```bash
cat filename            # Display entire file
less filename           # View file page by page
more filename           # View file page by page (basic)
head filename           # Show first 10 lines
head -n 20 filename     # Show first 20 lines
tail filename           # Show last 10 lines
tail -f filename        # Follow file changes in real-time
```

**Search in files**
```bash
grep "pattern" file     # Search for pattern in file
grep -r "pattern" dir   # Search recursively in directory
grep -i "pattern" file  # Case-insensitive search
grep -n "pattern" file  # Show line numbers
```

**Find files**
```bash
find /path -name "filename"     # Find by name
find /path -type f -name "*.txt" # Find text files
find /path -size +1M            # Find files larger than 1MB
find /path -mtime -7            # Find files modified in last 7 days
```

## System Information

**System processes**
```bash
ps                      # Show running processes
ps aux                  # Show all processes with details
top                     # Real-time process monitor
htop                    # Enhanced process monitor (if installed)
kill PID                # Kill process by ID
killall processname     # Kill processes by name
```

**System resources**
```bash
df -h                   # Show disk usage
du -h                   # Show directory sizes
du -sh *                # Show size of each item in current directory
free -h                 # Show memory usage (Linux)
vm_stat                 # Show memory usage (macOS)
uptime                  # Show system uptime and load
```

**Network**
```bash
ping hostname           # Test network connectivity
curl URL                # Download from URL
wget URL                # Download file (if installed)
netstat -an             # Show network connections
```

## File Permissions

**View permissions**
```bash
ls -l                   # See permissions in long format
```

**Change permissions**
```bash
chmod 755 file          # Set specific permissions
chmod +x file           # Make file executable
chmod -w file           # Remove write permission
chown user:group file   # Change file ownership
```

## Text Processing

**Sort and count**
```bash
sort filename           # Sort lines in file
uniq filename           # Remove duplicate lines
wc filename             # Count lines, words, characters
wc -l filename          # Count lines only
```

**Text manipulation**
```bash
cut -d',' -f1 file      # Extract first column (comma-separated)
awk '{print $1}' file   # Print first column
sed 's/old/new/g' file  # Replace text
```

## Archives and Compression

**Create archives**
```bash
tar -czf archive.tar.gz files/    # Create compressed archive
tar -cf archive.tar files/       # Create uncompressed archive
zip archive.zip files/           # Create zip archive
```

**Extract archives**
```bash
tar -xzf archive.tar.gz          # Extract compressed tar
tar -xf archive.tar              # Extract uncompressed tar
unzip archive.zip                # Extract zip file
```

## Environment and Variables

**Environment variables**
```bash
env                     # Show all environment variables
echo $PATH              # Show PATH variable
export VAR=value        # Set environment variable
which command           # Show path to command
history                 # Show command history
```

## macOS Specific Commands

**System information**
```bash
system_profiler SPHardwareDataType  # Hardware info
sw_vers                             # macOS version
diskutil list                       # List disks
```

**Services**
```bash
brew install package    # Install packages (if Homebrew installed)
launchctl list          # List running services
open filename           # Open file with default app
open .                  # Open current directory in Finder
```

## Useful Shortcuts

- `Ctrl+C` - Cancel current command
- `Ctrl+D` - End of file/Exit shell
- `Ctrl+L` - Clear screen
- `Ctrl+R` - Search command history
- `Tab` - Auto-complete
- `!!` - Repeat last command
- `!n` - Repeat command number n from history

## Download Online Resources
**Specific file**
```bash
curl https://www.gutenberg.org/files/100/100-0.txt > shakespeare.txt
```

**Specific file**
```bash
curl -L -O https://github.com/TomHuynhSG/public_datasets/blob/master/small_cat_dog_dataset.zip?raw=true
```