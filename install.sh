#!/bin/bash

echo "Setting up the Termux app theme and shell (Host)..."

# creating the directory
mkdir -p ~/.termux

# Copy the content
cp ./termux/font.ttf ~/.termux/font.ttf
cp ./termux/colors.properties ~/.termux/colors.properties
cp ./termux/termux.properties ~/.termux/termux.properties

# making it default
echo "Setting Zsh as the default shell for Termux..."
cp ./.zshrc ~/.zshrc
chsh -s zsh

echo "Termux host configured. Please restart Termux to log into Debian automatically."

# reload settings
termux-reload-settings
