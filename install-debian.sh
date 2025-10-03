#!/bin/bash

echo " Ricing the Debian shell (Guest)..."

# Install necessary dependencies
echo " Installing dependencies: zsh, figlet..."
apt update && apt install -y zsh figlet

# Copy the Zsh configuration file
cp ./debian/.zshrc ~/.zshrc

# Set Zsh as the default shell
chsh -s zsh

echo "Debian rice complete! Please restart your shell with 'source ~/.zshrc' or by logging in again."