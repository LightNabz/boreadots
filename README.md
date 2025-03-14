# Dotfiles Installation Guide

## Introduction
Welcome to my dotfiles repository! This setup contains my personalized configurations for various applications and tools. You can use it to replicate my environment or as a base for your own.

## Features
- Preconfigured settings for:
  - **Hyprland** (hypr)
  - **Kitty** (kitty)
  - **Neovim** (nvim)
  - **Waybar** (waybar)
  - **Rofi** (rofi, installed via `yay` as `rofi-wayland`)
  - **Sway** (sway, swaylock)
  - **Qt5ct & GTK** (qt5ct, gtk-3.0, gtk-4.0)
  - **HTOP** (htop)
  - **Nwg-look** (nwg-look)
  - **Shell configs** (zshrc, bashrc)
- Automatic backup of existing dotfiles before installation
- Simple and flexible installation script
- Automatic package installation after dotfiles are copied

## Installation

### 1. Clone the Repository
You can clone this repository anywhere, but a common location is `~/.dotfiles`:
```sh
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### 2. Run the Installation Script
Make the script executable and run it:
```sh
chmod +x install_dotfiles.sh
./install_dotfiles.sh
```
This will:
- Backup your existing configurations
- Copy my dotfiles to the appropriate locations
- Install required packages automatically

### 3. Required Packages
After copying dotfiles, the script will ask if you want to install the necessary packages. If you're using Arch Linux, it will install:
```sh
sudo pacman -S hyprland kitty neovim waybar sway swaylock qt5ct htop nwg-look
yay -S rofi-wayland
```
If you don't have `yay`, you can install it manually first:
```sh
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
```

## Custom Installation Path
If you cloned the repository to a different location, don’t worry! The script will automatically detect where it is and install from there.

## Uninstall / Restore Backup
If you ever want to revert to your previous settings, your old configurations are stored in a timestamped backup folder:
```sh
ls ~/.dotfiles_backup_*
```
You can manually restore files from there.

## Contributing
Feel free to fork this repository, submit pull requests, or suggest improvements!

## License
This project is open-source and free to use. Enjoy customizing your setup!


