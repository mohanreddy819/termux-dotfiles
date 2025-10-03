#!/data/data/com.termux/files/usr/bin/bash


echo "⚠️ Force removing configs..."
rm -f ~/.zshrc
rm -rf ~/.termux

termux-reload-settings
echo "✅ Done!"