# Only run in interactive shell
if [[ $- == *i* ]]; then
    clear

    DATE_MSG=$(date +"%A, %d %B %Y")
    CUSTOM_MSG="Welcome back.🌿"

# Define width of the box
BOX_WIDTH=70
DATE_MSG=$(date +"%A, %d %B %Y")
CUSTOM_MSG="Welcome back to your Gruvbox Termux 🌿"

# Top border
printf "\033[38;5;214m╭%0.s─" $(seq 1 $BOX_WIDTH); printf "╮\033[0m\n"

# "mohan" ASCII art inside box (with padding + borders)
figlet -f small "mohan" | while IFS= read -r line; do
    printf "\033[38;5;142m│ %-*s │\033[0m\n" $BOX_WIDTH "$line" | lolcat
done

# Spacer
printf "\033[38;5;142m│ %-*s │\033[0m\n" $BOX_WIDTH " " | lolcat

# Date + message inside box
printf "\033[38;5;142m│ %-*s │\033[0m\n" $BOX_WIDTH "$DATE_MSG"   | lolcat
printf "\033[38;5;142m│ %-*s │\033[0m\n" $BOX_WIDTH "$CUSTOM_MSG" | lolcat

# Bottom border
printf "\033[38;5;214m╰%0.s─" $(seq 1 $BOX_WIDTH); printf "╯\033[0m\n\n"


    echo ""
fi

# Aliases
alias ll='ls -la --color=auto'
alias cls='clear'

# ============================
# Custom Zsh Prompt
# ============================

# Colors
RED="%F{1}"
GREEN="%F{2}"
YELLOW="%F{3}"
BLUE="%F{4}"
MAGENTA="%F{5}"
CYAN="%F{6}"
RESET="%f"

# Git branch function
git_branch() {
  branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  [ -n "$branch" ] && echo "  $branch"
}

# Custom prompt
PROMPT="${MAGENTA}[${CYAN}%n${GREEN}@termux${MAGENTA}]${RESET} ${YELLOW}%~${RESET}\$(git_branch)\n${BLUE}>>> ${RESET}"
