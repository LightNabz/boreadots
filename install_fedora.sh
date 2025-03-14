#!/bin/bash

# get the directory where the script is located
dotfiles_dir="$(cd -- "$(dirname -- "${bash_source[0]}")" &>/dev/null && pwd)"
backup_dir="$home/.dotfiles_backup_$(date +%y%m%d_%h%m%s)"

echo "📂 creating backup directory: $backup_dir"
mkdir -p "$backup_dir"

# function to backup and copy dotfiles
backup_and_copy() {
    local src="$dotfiles_dir/$1"
    local dest="$home/$1"

    if [ -e "$dest" ]; then
        echo "🔄 backing up existing $dest to $backup_dir"
        mv "$dest" "$backup_dir/"
    fi

    echo "📥 installing $1..."
    cp -r "$src" "$dest"
}

# ensure .config directory exists
mkdir -p "$home/.config"

# install all config files
backup_and_copy ".config/hypr"
backup_and_copy ".config/kitty"
backup_and_copy ".config/nvim"
backup_and_copy ".config/waybar"
backup_and_copy ".config/rofi"
backup_and_copy ".config/wlogout"
backup_and_copy ".config/qt5ct"
backup_and_copy ".config/gtk-3.0"
backup_and_copy ".config/gtk-4.0"
backup_and_copy ".config/htop"
backup_and_copy ".config/nwg-look"
backup_and_copy ".zshrc"
backup_and_copy ".bashrc"

echo "✅ dotfiles installation complete!"
echo "🛠 your old configs are backed up at: $backup_dir"

# ask if user wants to install required packages
read -rp "❓ do you want to install the required packages? (y/n): " install_packages

if [[ "$install_packages" =~ ^[yy]$ ]]; then
    echo "📦 installing required packages..."
    sudo dnf install -y hyprland kitty neovim waybar wlogout hyprlock qt5ct gtk3 gtk4 htop nwg-look zsh bash || echo "⚠️ some packages may not have been installed!"

    # install rofi-wayland from copr
    echo "📦 enabling copr repository for rofi-wayland..."
    sudo dnf copr enable -y aflyhorse/rofi-wayland
    sudo dnf install -y rofi-wayland || echo "⚠️ failed to install rofi-wayland!"
else
    echo "⏩ skipping package installation!"
fi

echo "🚀 all done! enjoy your new setup~"

