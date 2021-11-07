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
5. Install [Docker Desktop](https://hub.docker.com/editions/community/docker-ce-desktop-windows)
6. Install [Google Drive Desktop](https://www.google.com/drive/download/)
7. Clone repo
```
git clone "https://github.com/kailask/setup.git" ~/.setup
```
8. Run install script from powershell with admin rights
```
wsl; ~/.setup/install -p wsl
```

### Setup on Raspberry Pi ([RPiOS Lite](https://downloads.raspberrypi.org/raspios_lite_arm64/images/))

1. Create a [new user](https://www.raspberrypi.com/documentation/computers/configuration.html#changing-your-username) with sudo access
```
sudo adduser kailas;
sudo usermod -aG adm,dialout,cdrom,sudo,audio,video,plugdev,games,users,input,netdev,gpio,i2c,spi kailas
```
2. Make new user the default for Boot / Auto login
```
sudo raspi-config
```
3. Enable SSH access and connect over SSH
```
# Edit /etc/ssh/sshd_config to allow password
sudo systemctl enable ssh; 
sudo systemctl start ssh
```
4. Copy public key to `~/.ssh/authorized_keys`
5. [Set hostname](https://thepihut.com/blogs/raspberry-pi-tutorials/19668676-renaming-your-raspberry-pi-the-hostname)
6. Clone repo
```
git clone "https://github.com/kailask/setup.git" ~/.setup
```
7. Run install script
```
~/.setup/install -p rpi
```