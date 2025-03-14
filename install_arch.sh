#!/bin/bash

# Get the directory where the script is located
DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

echo "📂 Creating backup directory: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

# Function to backup and copy dotfiles
backup_and_copy() {
    local src="$DOTFILES_DIR/$1"
    local dest="$HOME/$1"

    if [ -e "$dest" ]; then
        echo "🔄 Backing up existing $dest to $BACKUP_DIR"
        mv "$dest" "$BACKUP_DIR/"
    fi

    echo "📥 Installing $1..."
    cp -r "$src" "$dest"
}

# Ensure .config directory exists
mkdir -p "$HOME/.config"

# Install all config files
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

echo "✅ Dotfiles installation complete!"
echo "🛠 Your old configs are backed up at: $BACKUP_DIR"

# Ask if user wants to install required packages
read -rp "❓ Do you want to install the required packages? (y/n): " INSTALL_PACKAGES

if [[ "$INSTALL_PACKAGES" =~ ^[Yy]$ ]]; then
    echo "📦 Installing required packages..."
    sudo pacman -S --needed hyprland kitty neovim waybar wlogout hyprlock qt5ct gtk3 gtk4 htop nwg-look zsh bash || echo "⚠️ Some packages may not have been installed!"

    # Install rofi-wayland from AUR
    if command -v yay &>/dev/null; then
        echo "📦 Installing rofi-wayland from AUR..."
        yay -S --needed rofi-wayland || echo "⚠️ Failed to install rofi-wayland!"
    else
        echo "⚠️ yay is not installed. Install yay manually and run 'yay -S rofi-wayland'"
    fi
else
    echo "⏩ Skipping package installation!"
fi

echo "🚀 All done! Enjoy your new setup~"
