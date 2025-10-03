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

# --- Aliases ---
alias ll='ls -la --color=auto'
alias cls='clear'
# Add any other favorite aliases here

# ===================================================================
#  PROMPT SETUP (DEFINITIONS)
# ===================================================================
# This section defines all the functions and variables the prompt will need.

# --- Zsh Modules and Options ---
autoload -U add-zsh-hook
autoload -U colors && colors
setopt PROMPT_SUBST # FIX: This is needed for variables like ${LAST_CMD_DURATION} to work in RPROMPT

# --- Command Execution Timer ---
LAST_CMD_DURATION=0 # Initialize the variable
_record_start_time() {
  zsh_timer=${EPOCHSECONDS}
}
_set_cmd_duration() {
  if [[ -n $zsh_timer ]]; then
    local duration=$((EPOCHSECONDS - zsh_timer))
    LAST_CMD_DURATION="${duration}"
  else
    LAST_CMD_DURATION=0
  fi
}
add-zsh-hook preexec _record_start_time
add-zsh-hook precmd _set_cmd_duration

# --- Gruvbox Color Definitions ---
GRUV_BG0="%K{0}"      # dark gray
GRUV_BG_BLUE="%K{12}" # blue
GRUV_BG_GREEN="%K{10}"# green
GRUV_BG_RED="%K{9}"   # red
GRUV_FG_LIGHT="%F{15}"# light
GRUV_FG_GRAY="%F{8}"  # gray
GRUV_FG_DARK="%F{0}"  # black
RESET_COLORS="%f%k"

# --- Git Status Function ---
# FIX: Restored this missing function needed by the Gruvbox prompt
git_prompt_info() {
  local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [[ -n "$branch" ]]; then
    if [[ -n $(git status --porcelain) ]]; then
      # Dirty repo: red background
      echo "%{$GRUV_BG_RED%G%F{0}%}  $branch %{$RESET_COLORS%G%F{9}%}$ARROW_RIGHT"
    else
      # Clean repo: green background
      echo "%{$GRUV_BG_GREEN%G%F{0}%}  $branch %{$RESET_COLORS%G%F{10}%}$ARROW_RIGHT"
    fi
  fi
}

# --- Symbols ---
# FIX: Removed stray text that was causing a syntax error
ARROW_RIGHT=""

# ===================================================================
#  PROMPT THEME (ACTIVATION)
# ===================================================================
# Now we build the prompt using the variables and functions defined above.

# --- Gruvbox Powerline Prompt (ACTIVE) ---
PROMPT="%{$GRUV_BG0%G%F{15}%} %n@debian %{$RESET_COLORS%G%F{0}%}$ARROW_RIGHT%{$GRUV_BG_BLUE%G%F{0}%} %~ %{$RESET_COLORS%G%F{12}%}$ARROW_RIGHT\$(git_prompt_info)%{$RESET_COLORS%} "
PROMPT+="\n%{$GRUV_FG_GRAY%}❯%{$RESET_COLORS%} "

# --- Custom Right-Side Prompt (ACTIVE) ---
# This will show up on the right side of the first line of the prompt.
RPROMPT='%F{cyan}⌚ %D{%I:%M %p}%f  %F{magenta}Debian%f  %F{red} ${LAST_CMD_DURATION}s%f'

# --- Alternative Simple Prompt (INACTIVE) ---
# FIX: Commented out this conflicting prompt. You can uncomment it if you want to switch styles.
# PROMPT='%F{yellow} %~%f
# %F{green}%n%f %F{red}%f '
# RPROMPT='' # You would likely want to disable RPROMPT for this style

# ===================================================================
#  BANNER
# ===================================================================
# This runs last when a new shell opens.
if [[ $- == *i* ]]; then
    # Animated "Welcome!" text
    figlet -f slant 'Welcome!' | boxes -d ansi-rounded | tte wipe

    # Define colors for convenience
    CYAN='\e[0;36m'
    LIGHT_CYAN='\e[1;36m'
    YELLOW='\e[1;33m'
    RED='\e[1;31m'
    GREEN='\e[38;2;173;255;47m'
    RESET='\033[0m'

    # Static info section
    echo -e "${CYAN}⚡=================================⚡${RESET}"
    echo -e "  ${LIGHT_CYAN}${RESET}  Zsh Version: ${YELLOW}$ZSH_VERSION${RESET}"
    if [ -n "$TERMUX_VERSION" ]; then
        echo -e  "  ${RED}${RESET} Termux Version: ${YELLOW}$TERMUX_VERSION${RESET}"
    fi
    echo -e "  ${YELLOW}󰆧${RESET} Installed Packages: ${YELLOW}$(dpkg -l | grep '^ii' | wc -l)${RESET}"
    echo -e "  ${GREEN}ALL PROCESSES ARE ONLINE${RESET}"
    echo -e "${CYAN}⚡=================================⚡${RESET}"

    # Add a final newline for clean prompt spacing
    echo ""
fi