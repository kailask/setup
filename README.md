# Setup

Repository for assorted software configurations, settings, and scripts.

## Using

### Setup on Windows (WSL - Ubuntu)

1. [Install and enable WSL](https://docs.microsoft.com/en-us/windows/wsl/install-win10)
```
wsl --install -d Ubuntu
```
2. Install [Python](https://www.microsoft.com/en-us/p/python-39/9p7qfqmjrfp7) and [Windows Terminal](https://www.microsoft.com/en-us/p/windows-terminal/9n0dx20hk701)
3. Install [VS Code](https://code.visualstudio.com/download#) (User)
4. Install [FiraCode NF and Caskaydia Cove NF](https://www.nerdfonts.com/font-downloads)
5. Install Docker Desktop
6. Clone repo
```
git clone "https://github.com/kailask/setup.git" ~/.setup
```
7. Run install script from powershell with admin rights
```
wsl; ~/.setup/install -p wsl
```