# Clear screen on startup
clear

# Custom banner
if [[ $- == *i* ]]; then
    clear
    figlet "Mohan"
    toilet "Welcome!"
fi

# Prompt (username@host:path)
PROMPT='%F{cyan}%n%f@%F{magenta}%m%f:%F{yellow}%~%f %# '

# Aliases
alias ll='ls -la --color=auto'
alias cls='clear'
alias update='pkg update && pkg upgrade -y'

# Extra tools (optional if installed)
# source ~/.oh-my-zsh/oh-my-zsh.sh
