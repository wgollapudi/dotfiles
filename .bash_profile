###
### LOGIN SHELL INITALIZATION SCRIPT
###
### Copyright (C) 2024 Walker Gollapudi <wgollapudi@outlook.com>
### MIT License. See LICENSE file for details.
###

### Source '.bashrc' ###

if [-n "$BASH_VERSION" ] ; then
	if [ -f "$HOME/.bashrc" ] ; then
		. "$HOME/.bashrc"
	fi
fi


### Enviroment Variables ###

# Mimic Linux path variables
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# Set some variables
export EDITOR=vim
export PAGER=less

# Set default less(1) options
export LESS='-SRi'

# Set default cc(1) options
if command -v gcc-14 &>/dev/null ; then
	export CC=gcc-14
fi

# Include user bin directory in path
if [ -d "$HOME/bin" ] ; then
	PATH="$HOME/bin:$PATH"
fi

# Include users private bin directory in path
if [ -d "$HOME/.local/bin" ] ; then
	PATH="$HOME/.local/bin:$PATH"
fi

export PATH

# Set default permissions to rwxrwx---
umask 007
