# -----------------
# Zsh configuration
# -----------------

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -v

# Jump by words and lines
bindkey '^\b' backward-delete-word
bindkey '^D' end-of-line
bindkey '^A' beginning-of-line
bindkey '^W' forward-word

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# -------
# Aliases
# -------

# jump in stack
alias d='dirs -v'
for index ({1..9}) alias $index="cd +${index}"; unset index

# General
alias pg='ping 8.8.8.8'
alias c='clear'
alias top='htop'

# Nvim
alias v='nvim'
alias vi='nvim'

# Exa
alias ls='exa --group-directories-first --icons' # Simple view
alias ll='ls --long --git --color-scale --no-icons' # Long view
alias la='ls --long --git --color-scale --grid --all --header --group --inode --links --blocks --modified --created' # Long view show everything

alias l='ll --all' # Long view + dots (default)
alias lr='ll --tree --level=5' # Long view + tree
alias lx='ll -sextension' # Sorted by extension
alias lk='ll -ssize' # Sorted by size
alias lt='ll -smodified' # Sorted by modified

alias tree='exa --tree --icons'

# --------------------
# Module configuration
# --------------------

# Set a custom path for the completion dump file.
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
# Colors used for prompt and highlighting
#

# https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg
RED='001'
BLUE='012'
YELLOW='011'
ORANGE='202'
GRAY='248'
WHITE='015'

#
# zsh-autosuggestions
#

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=${GRAY}"

# Suggest first from history, then tab completions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Max buffer size for autosuggestions
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=30

# Ctrl+space to accept; Ctrl+enter to execute suggestions
bindkey '^ ' autosuggest-accept
bindkey '^\n' autosuggest-execute

#
# zsh-history-substring-search
#

# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
# bindkey '^[[A' history-substring-search-up
# bindkey '^[[B' history-substring-search-down

# Bind up and down keys
zmodload -F zsh/terminfo +p:terminfo
if [[ -n ${terminfo[kcuu1]} && -n ${terminfo[kcud1]} ]]; then
  bindkey ${terminfo[kcuu1]} history-substring-search-up
  bindkey ${terminfo[kcud1]} history-substring-search-down
fi

# Bind up and down for vim mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="bg=${BLUE},fg=${WHITE}"
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="bg=${RED},fg=${WHITE}"

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/highlighters/main/main-highlighter.zsh
typeset -A ZSH_HIGHLIGHT_STYLE
# ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[unknown-token]="fg=${RED},bold"
ZSH_HIGHLIGHT_STYLES[reserved-word]="fg=${YELLOW}"
ZSH_HIGHLIGHT_STYLES[suffix-alias]="fg=${BLUE}"
ZSH_HIGHLIGHT_STYLES[precommand]="fg=${BLUE}"
ZSH_HIGHLIGHT_STYLES[commandseparator]="fg=${YELLOW}"
ZSH_HIGHLIGHT_STYLES[autodirectory]="fg=${BLUE},underline"
ZSH_HIGHLIGHT_STYLES[path]="underline"
ZSH_HIGHLIGHT_STYLES[globbing]="fg=${ORANGE}"
ZSH_HIGHLIGHT_STYLES[history-expansion]="fg=${ORANGE}"
# ZSH_HIGHLIGHT_STYLES[single-hyphen-option]="fg=${ORANGE}"
# ZSH_HIGHLIGHT_STYLES[double-hyphen-option]="fg=${ORANGE}"
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]="fg=${YELLOW}"
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]="fg=${YELLOW}"
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]="fg=${YELLOW}"
ZSH_HIGHLIGHT_STYLES[redirection]="fg=${YELLOW}"
ZSH_HIGHLIGHT_STYLES[arg0]="fg=${BLUE}"

# Max buffer size for highlighting
ZSH_HIGHLIGHT_MAXLENGTH=512

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

# Prompt
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_PROMPT_DEFAULT_PREFIX=' '

# Char
SPACESHIP_CHAR_SYMBOL=' '
SPACESHIP_CHAR_SYMBOL_SECONDARY='﬌ '
SPACESHIP_CHAR_COLOR_SECONDARY=${YELLOW}
SPACESHIP_CHAR_COLOR_SUCCESS=${BLUE}
SPACESHIP_CHAR_COLOR_FAILURE=${RED}

# User & Host
SPACESHIP_USER_SHOW='false'
SPACESHIP_HOST_SHOW='true'
SPACESHIP_HOST_COLOR_SSH=${BLUE}

# Dir
SPACESHIP_DIR_PREFIX=${SPACESHIP_PROMPT_DEFAULT_PREFIX}
SPACESHIP_DIR_TRUNC_PREFIX='…/'
SPACESHIP_DIR_LOCK_SYMBOL=' '
SPACESHIP_DIR_TRUNC=5
SPACESHIP_DIR_LOCK_COLOR=${RED}
SPACESHIP_DIR_COLOR=${ORANGE}

# Git
SPACESHIP_GIT_PREFIX=${SPACESHIP_PROMPT_DEFAULT_PREFIX}
SPACESHIP_GIT_BRANCH_PREFIX=' '
SPACESHIP_GIT_STATUS_PREFIX=' '
SPACESHIP_GIT_STATUS_SUFFIX=''
SPACESHIP_GIT_STATUS_COLOR=${BLUE}
SPACESHIP_GIT_BRANCH_COLOR=${ORANGE}

# Execution time
SPACESHIP_EXEC_TIME_PREFIX=${SPACESHIP_PROMPT_DEFAULT_PREFIX}
SPACESHIP_EXEC_TIME_COLOR=${YELLOW}

# Jobs
SPACESHIP_JOBS_PREFIX=${SPACESHIP_PROMPT_DEFAULT_PREFIX}
SPACESHIP_JOBS_SYMBOL=''
SPACESHIP_JOBS_AMOUNT_PREFIX=''
SPACESHIP_JOBS_COLOR=${BLUE}

# Exit code
SPACESHIP_EXIT_CODE_SHOW=true
SPACESHIP_EXIT_CODE_COLOR=${RED}