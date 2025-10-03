#!/data/data/com.termux/files/usr/bin/bash

echo "📦 Installing Termux rice..."

# Copy zshrc
cp zshrc ~/.zshrc

# Copy Termux configs
mkdir -p ~/.termux
cp -r termux/* ~/.termux/

# Reload Termux settings
termux-reload-settings

echo "✅ Installation complete! Restart Termux to see changes."
