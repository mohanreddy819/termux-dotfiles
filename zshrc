# Only run in interactive shell
if [[ $- == *i* ]]; then
    clear

    # Optional: simple ASCII banner without lolcat
    figlet -f small "h4ck3r"

    # Optional: decorative box using colors (ANSI only)
    echo -e "\033[33m-================= ≫ ──── ≪•◦ ❈ ◦•≫ ──── ≪=================-\033[0m"
    echo -e "\033[33m│                                                          │\033[0m"
    echo -e "\033[33m│                                                          │\033[0m"
    echo -e "\033[33m╰─━━━━━━━━━━━━━━━━━━━━━━━━Termux-os━━━━━━━━━━━━━━━━━━━━━━─╯\033[0m"

    # Prompt will come below
fi

# Zsh theme + plugins
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="h4Ck3r"
plugins=(git)

source $HOME/.oh-my-zsh/oh-my-zsh.sh
source $HOME/.oh-my-zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Aliases
alias ll='ls -la --color=auto'
alias cls='clear'
