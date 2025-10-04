#!/bin/bash

echo "Setting up the Termux app theme and shell (Host)..."

# Create the .termux directory if it doesn't exist
mkdir -p ~/.termux

# Copy the font and colors
cp ./termux/font.ttf ~/.termux/font.ttf
cp ./termux/colors.properties ~/.termux/colors.properties

# Reload Termux settings to apply theme changes
echo "Setting Zsh as the default shell for Termux..."
chsh -s zsh

echo "Termux host configured. Please restart Termux to log into Debian automatically."

proot-distro login debian # direect login to debian
termux-reload-settings

# --- THIS IS THE KEY ---
# Set Zsh as the default shell for the Termux user
