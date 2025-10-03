# Only run in interactive shell
if [[ $- == *i* ]]; then
    clear

    DATE_MSG=$(date +"%A, %d %B %Y")
    CUSTOM_MSG="Welcome back.🌿"

    # Top border
    echo -e "\033[38;5;214m-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\033[0m"

    # "mohan" in ASCII art inside box
    figlet -f small "mohan" | lolcat | sed 's/^/│  /'

    # Spacer
    echo -e "│\033[0m"

    # Date + message inside box
    echo -e "│  $DATE_MSG"   | lolcat
    echo -e "│  $CUSTOM_MSG" | lolcat

    # Bottom border
    echo -e "\033[38;5;214m╰-=-=-=-=-=-=-=-=-=-=-=-=-Termux-=-=-=-=-=-=-=-=-=-=-=-=-╯\033[0m"

    echo ""
fi

# Aliases
alias ll='ls -la --color=auto'
alias cls='clear'
