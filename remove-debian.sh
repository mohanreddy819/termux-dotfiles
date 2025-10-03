#!/bin/bash

echo "Removing Debian rice configs..."

# Remove the Zsh configuration file from the Debian home directory
rm -f ~/.zshrc

# Change the default shell back to bash
chsh -s bash

echo "Debian shell reset to default."
echo "Please log out and back in to see the changes."