# --- Zsh History Settings ---
setopt APPEND_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE SHARE_HISTORY
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# --- Aliases ---
alias ll='ls -la --color=auto'
alias cls='clear'

# ===================================================================
#  PROMPT SETUP (DEFINITIONS & ACTIVATION)
# ===================================================================

# --- Zsh Modules and Options ---
autoload -U add-zsh-hook colors && colors
setopt PROMPT_SUBST

# --- Command Execution Timer ---
LAST_CMD_DURATION=0
_record_start_time() { zsh_timer=${EPOCHSECONDS} }
_set_cmd_duration() {
  local duration=$((EPOCHSECONDS - zsh_timer))
  LAST_CMD_DURATION="${duration:-0}"
}
add-zsh-hook preexec _record_start_time
add-zsh-hook precmd _set_cmd_duration

# --- Gruvbox Color & Symbol Definitions ---
GRUV_BG0="%K{0}"      # dark gray
GRUV_BG_BLUE="%K{12}" # blue
GRUV_BG_GREEN="%K{10}" # green
GRUV_BG_RED="%K{9}"   # red
GRUV_FG_LIGHT="%F{15}" # light
GRUV_FG_GRAY="%F{8}"  # gray
GRUV_FG_DARK="%F{0}"  # black
RESET_COLORS="%f%k"
ARROW_RIGHT=""

# --- Git Status Function ---
git_prompt_info() {
  local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [[ -n "$branch" ]]; then
    if [[ -n $(git status --porcelain) ]]; then
      echo "%{$GRUV_BG_RED%G%F{0}%}  $branch %{$RESET_COLORS%G%F{9}%}$ARROW_RIGHT"
    else
      echo "%{$GRUV_BG_GREEN%G%F{0}%}  $branch %{$RESET_COLORS%G%F{10}%}$ARROW_RIGHT"
    fi
  fi
}

# --- Prompt Activation ---
PROMPT="%{$GRUV_BG0%G%F{15}%} %n@debian %{$RESET_COLORS%G%F{0}%}$ARROW_RIGHT%{$GRUV_BG_BLUE%G%F{0}%} %~ %{$RESET_COLORS%G%F{12}%}$ARROW_RIGHT\$(git_prompt_info)%{$RESET_COLORS%} "
PROMPT+=$'\n'"%{$GRUV_FG_GRAY%}❯%{$RESET_COLORS%} "
RPROMPT='%F{magenta}Debian%f  %F{red}⌛ ${LAST_CMD_DURATION}s%f'

# ===================================================================
#  BANNER
# ===================================================================
if [[ $- == *i* ]]; then
    # terminal width
    local width=$(tput cols)

    # Center the entire output block with lolcat
    {
        
        figlet -f slant -c -w "$width" 'Welcome!'

        echo # Blank line 

        local zsh_line="  Zsh Version: $ZSH_VERSION"
        local termux_line=""
        [ -n "$TERMUX_VERSION" ] && termux_line="  Termux Version: $TERMUX_VERSION"
        local pkg_line="󰆧  Installed Packages: $(dpkg -l | grep '^ii' | wc -l)"
        local status_line="⚡ ALL PROCESSES ARE ONLINE"

        # Calculate padding and print each line centered
        printf "%*s\n" $(( (${#zsh_line} + width) / 2 )) "$zsh_line"
        [ -n "$termux_line" ] && printf "%*s\n" $(( (${#termux_line} + width) / 2 )) "$termux_line"
        printf "%*s\n" $(( (${#pkg_line} + width) / 2 )) "$pkg_line"
        printf "%*s\n" $(( (${#status_line} + width) / 2 )) "$status_line"

    } | lolcat

    echo # Final blank line
fi