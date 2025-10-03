#!/data/data/com.termux/files/usr/bin/bash

if [ "$1" == "--force" ]; then
    echo "⚠️ Force removing configs..."
    rm -f ~/.zshrc
    rm -rf ~/.termux
else
    echo "🧹 Backing up and removing configs..."
    [ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.backup.$(date +%s)
    [ -d ~/.termux ] && mv ~/.termux ~/.termux.backup.$(date +%s)
fi

termux-reload-settings
echo "✅ Done!"