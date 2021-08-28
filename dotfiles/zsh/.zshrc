# -----------------
# Zsh configuration
# -----------------

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -v

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# --------------------
# Module configuration
# --------------------

# # Set a custom path for the completion dump file.
zstyle ':zim:completion' dumpfile "${ZDOTDIR:-${HOME}}/.zcompdump-${ZSH_VERSION}"


# Append `../` to your input for each `.` you type after an initial `..`
zstyle ':zim:input' double-dot-expand yes

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# show the command name typed by the user while the command is being executed,
# then the current directory name after the command ended
zstyle ':zim:termtitle' hooks 'preexec' 'precmd'
zstyle ':zim:termtitle:preexec' format '${${(A)=1}[1]}'
zstyle ':zim:termtitle:precmd'  format '%1~'

# #
# # zsh-autosuggestions
# #

# # Customize the style that the suggestions are shown with.
# # See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

# #
# # zsh-syntax-highlighting
# #

# # Set what highlighters will be used.
# # See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
# ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# # Customize the main highlighter styles.
# # See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
# typeset -A ZSH_HIGHLIGHT_STYLES
# ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  # Update static initialization script if it does not exist or it's outdated, before sourcing it
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# Spaceship
#

SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  host          # Hostname section
  dir           # Current directory section
  #vi_mode       # Vi-mode indicator
  char          # Prompt character
)

SPACESHIP_RPROMPT_ORDER=(
  exit_code     # Exit code section
  exec_time     # Execution time
  jobs          # Background jobs indicator
  # docker      # Docker section
  git           # Git section (git_branch + git_status)
)

# https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg
SPACESHIP_ORANGE='202'

# Prompt
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_PROMPT_DEFAULT_PREFIX=' '

# Char
SPACESHIP_CHAR_SYMBOL=' '
SPACESHIP_CHAR_SYMBOL_SECONDARY='﬌ '
SPACESHIP_CHAR_COLOR_SECONDARY=${SPACESHIP_ORANGE}

# User & Host
SPACESHIP_USER_SHOW='false'
SPACESHIP_HOST_SHOW='true'
SPACESHIP_HOST_COLOR_SSH=${SPACESHIP_ORANGE}

# Dir
SPACESHIP_DIR_PREFIX=${SPACESHIP_PROMPT_DEFAULT_PREFIX}
SPACESHIP_DIR_TRUNC_PREFIX='…/'
SPACESHIP_DIR_LOCK_SYMBOL=' '
SPACESHIP_DIR_LOCK_COLOR=${SPACESHIP_ORANGE}

# Git
SPACESHIP_GIT_PREFIX=${SPACESHIP_PROMPT_DEFAULT_PREFIX}
SPACESHIP_GIT_BRANCH_PREFIX=' '
SPACESHIP_GIT_BRANCH_COLOR=${SPACESHIP_ORANGE}
SPACESHIP_GIT_STATUS_COLOR='yellow'
SPACESHIP_GIT_STATUS_PREFIX=' '
SPACESHIP_GIT_STATUS_SUFFIX=''

# Execution time
SPACESHIP_EXEC_TIME_PREFIX=${SPACESHIP_PROMPT_DEFAULT_PREFIX}
SPACESHIP_EXEC_TIME_COLOR='cyan'

# Jobs
SPACESHIP_JOBS_PREFIX=${SPACESHIP_PROMPT_DEFAULT_PREFIX}
SPACESHIP_JOBS_SYMBOL=''
SPACESHIP_JOBS_AMOUNT_PREFIX=''

# Exit code
SPACESHIP_EXIT_CODE_SHOW=true

#
# zsh-history-substring-search
#

# # Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
# bindkey '^[[A' history-substring-search-up
# bindkey '^[[B' history-substring-search-down

# # Bind up and down keys
# zmodload -F zsh/terminfo +p:terminfo
# if [[ -n ${terminfo[kcuu1]} && -n ${terminfo[kcud1]} ]]; then
#   bindkey ${terminfo[kcuu1]} history-substring-search-up
#   bindkey ${terminfo[kcud1]} history-substring-search-down
# fi

# bindkey '^P' history-substring-search-up
# bindkey '^N' history-substring-search-down
# bindkey -M vicmd 'k' history-substring-search-up
# bindkey -M vicmd 'j' history-substring-search-down

# -------
# Aliases
# -------

# jump in stack
alias d='dirs -v'
for index ({1..9}) alias $index="cd +${index}"; unset index

# alias c='clear'
# # alias l='exa'
# alias v='nvim'
# alias vi='nvim'
# alias top='htop'