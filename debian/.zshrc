# ===================================================================
#  ZSH CONFIGURATION FOR DEBIAN
# ===================================================================

# --- Zsh History Settings ---
setopt APPEND_HISTORY      # Append history instead of overwriting
setopt SHARE_HISTORY       # Share history between all sessions
setopt HIST_IGNORE_DUPS    # Do not save duplicated commands
setopt HIST_IGNORE_SPACE   # Do not save commands starting with a space
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# --- Command Execution Timer ---
# This code calculates how long the last command took to run.
autoload -U add-zsh-hook

_record_start_time() {
  zsh_timer=${EPOCHSECONDS}
}

_set_cmd_duration() {
  if [[ -n $zsh_timer ]]; then
    local duration=$((EPOCHSECONDS - zsh_timer))
    LAST_CMD_DURATION="${duration}"
  fi
}

add-zsh-hook preexec _record_start_time
add-zsh-hook precmd _set_cmd_duration

# ===================================================================
#  ALIASES
# ===================================================================
alias ll='ls -la --color=auto'
alias cls='clear'
# Add any other favorite aliases here

# ===================================================================
#  BANNER (Runs only once on startup)
# ===================================================================
if [[ $- == *i* ]]; then
    clear
    
    # --- Check for dependencies ---
    if ! command -v figlet &> /dev/null; then
        echo "Warning: 'figlet' is not installed. Banner will not display correctly."
        echo "Please run: apt install figlet"
    else
        # --- Define Colors (using tput for compatibility) ---
        local COLOR_BLUE=$(tput setaf 4)
        local COLOR_CYAN=$(tput setaf 6)
        local COLOR_GREEN=$(tput setaf 2)
        local COLOR_MAGENTA=$(tput setaf 5)
        local COLOR_WHITE=$(tput setaf 7)
        local COLOR_RESET=$(tput sgr0)

        # --- Dynamic Width Calculation ---
        local width=$(tput cols)
        
        # --- "Welcome!" Box ---
        local welcome_text=$(figlet -f standard "Welcome!")
        local box_width=$(( $(echo "$welcome_text" | head -n1 | wc -c) + 3 ))
        printf "${COLOR_MAGENTA}┌%0.s─┐${COLOR_RESET}\n" $(seq 1 $box_width)
        echo "$welcome_text" | while IFS= read -r line; do
            printf "${COLOR_MAGENTA}│${COLOR_RESET} %-*s ${COLOR_MAGENTA}│${COLOR_RESET}\n" $box_width "$line"
        done
        printf "${COLOR_MAGENTA}└%0.s─┘${COLOR_RESET}\n\n" $(seq 1 $box_width)

        # --- Info Block ---
        # Note: $TERMUX_VERSION is not available in proot-distro, so we leave it static.
        local zsh_version=$ZSH_VERSION
        local termux_version="1.46.0 (in host)"
        local pkg_count=$(dpkg -l | grep '^ii' | wc -l)

        # Separator line
        printf "${COLOR_CYAN}~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~${COLOR_RESET}\n"

        # Info lines
        printf "  ${COLOR_BLUE}${COLOR_RESET} Zsh Version:        ${COLOR_WHITE}$zsh_version${COLOR_RESET}\n"
        printf "  ${COLOR_MAGENTA}${COLOR_RESET} Termux Version:       ${COLOR_WHITE}$termux_version${COLOR_RESET}\n"
        printf "  ${COLOR_GREEN}󰏓${COLOR_RESET} Installed Packages:   ${COLOR_WHITE}$pkg_count${COLOR_RESET}\n"
        printf "  ${COLOR_GREEN}ALL PROCESSES ARE ONLINE${COLOR_RESET}\n"

        # Separator line
        printf "${COLOR_CYAN}~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~${COLOR_RESET}\n\n"
    fi
fi

# ===================================================================
#  PROMPT
# ===================================================================
# This creates the two-line prompt with info on the right side.

# --- Left side of the prompt ---
# Line 1: Folder icon and current path
# Line 2: Username and prompt symbol
PROMPT='%F{yellow} %~%f
%F{green}%n%f %F{red}%f '

# --- Right side of the prompt (RPROMPT) ---
# Shows Time, OS, and Last Command Duration. Automatically adjusts to the right.
RPROMPT='%F{cyan}⌚ %D{%I:%M %p}%f  %F{magenta}Debian%f  %F{red} ${LAST_CMD_DURATION}s%f'