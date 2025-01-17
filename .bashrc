###
### BASH INITALIZATION SCRIPT AND CONFIGURATION FILE
###
### Copyright (C) 2024 Walker Gollapudi <wgollapudi@outlook.com>
### MIT License. See LICENSE file for details.
###

# If the shell is not non-interactive, exit early 
case $- in
    *i*) ;;
      *) return;;
esac

### SOURCE $HOME/.config/aliases ###

if [ -r "$HOME/.config/aliases" ]; then
    . "$HOME/.config/aliases" 
fi


### GENERAL OPTIONS ###

# Prevent file overwrite on stdout redirection
# Use '>|' to force redirection to an existing file
set -o noclobber

# Automaticaly trim long paths in the prompt (requires Bash 4.x)
PROMPT_DIRTRIM=2

# Updates 'LINES' and 'COLUMNS' variables after every command, ensuring correct
# 	terminal sizing
shopt -s checkwinsize

# Enables recursive matching with '**' (e.g., 'ls **/*.txt' to list all .txt files
# 	in subdirectories
shopt -s globstar 2> /dev/null

# Use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to $H:%M:%S (24-hours format)
HISTTIMEFORMAT='%F %T '


### HISTORY CONFIGURATION ###

# Prevents duplicate entries and lines starting with a space from being saved
# 	in history
# See bash(1) for more options
HISTCONTROL="erasedups:ignoreboth"

#  New commands are append to the history file, instead of overwriting it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Record each line as it gets issued
PROMPT_COMMAND='history -a'

# Set the maximum number of history entries in memory and in the file to huge values.
# 	Doesn't appear to slow things down, so why not? 
# See HISTSIZE and HISTFILESIZE in bash(1) for more information
HISTSIZE=500000
HISTFILESIZE=100000

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"


### 'less' CONFIGURATION ###

# Makes less more capable of handling non-text files by preprocessing them
# See lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


### PROMPT CUSTOMIZATION ###

# Sets the 'debian_chroot' variable to indicate if the shell is running in a
# 	chroot enviroment
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Adds colors to the prompt if the terminal supports it (xterm-color, *-256color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# Includes username ('\u'), hostname ('\h'), and working directory ('\w').
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt 


### SET TERMINAL TITLE ###

# Sets the terminal title to display 'username@hostname: current-directory'
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac


### COLOR SUPPORT FOR COMMANDS ###

# Adds color to commands like 'ls', 'grep', and others for better readability
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


### BASH COMPLETION ###

# Enables advanced command-line completion for tools like 'git'
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


### FUNCTIONS ###

# Add a directory to $PATH
pathadd() {
	if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]] ; then
		PATH="$1${PATH:+":$PATH"}"
	fi
}

### RUST PATH MODIFICATION ###
. "$HOME/.cargo/env"
