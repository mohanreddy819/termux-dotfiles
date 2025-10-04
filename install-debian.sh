#!/bin/bash

echo " Ricing the Debian shell..."

# Install necessary dependencies
echo " Installing dependencies: zsh, figlet..."
apt update && apt install -y zsh figlet lolcat git curl 

# Copy the Zsh configuration file
cp ./debian/.zshrc ~/.zshrc

# Zsh as the default shell
chsh -s zsh

echo "Debian rice complete!"