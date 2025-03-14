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
backup_and_copy ".config/sway"
backup_and_copy ".config/swaylock"
backup_and_copy ".config/qt5ct"
backup_and_copy ".config/gtk-3.0"
backup_and_copy ".config/gtk-4.0"
backup_and_copy ".config/htop"
backup_and_copy ".config/nwg-look"
backup_and_copy ".zshrc"
backup_and_copy ".bashrc"

echo "✅ Dotfiles installation complete!"
echo "🛠 Your old configs are backed up at: $BACKUP_DIR"

