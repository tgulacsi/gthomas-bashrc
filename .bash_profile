#!/bin/bash
# ~/.profile: executed by the command interpreter for login shells.
# This file is NOT read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# shellcheck source=$HOME/.bashrc
. "$HOME/.bashrc"  

touch /tmp/wallpaper.png

export NMON=cdm4

export PS1=":\[\e[1;32m\]\u@\H:\[\e[m\] \[\e[1;37m\]\w\[\e[m\]\n\$(if [ \$? = 0 ]; then echo '$'; else echo '!'; fi) "

USER_RUN_DIR=/var/run/user/$(id -u)
export USER_RUN_DIR

if [ -L ~/.cache ]; then
	mkdir -p "$(readlink ~/.cache)"
else
	mv ~/.cache "$USER_RUN_DIR/"
	rm -rf ~/.cache
	ln -sf "$USER_RUN_DIR/.cache" ~/.cache
	mkdir -p "$USER_RUN_DIR/.cache"
fi
mkdir -p ~/.cache/mutt

eval "$(~/bin/invoke-gpg-agent)"

if [[ -z "$_ALIASES_HAS_BEEN_SET" ]]; then
	# enable color support of ls and also add handy aliases
	if [[ -x /usr/bin/dircolors ]]; then
		if [[ -r ~/.dircolors ]]; then
			eval "$(dircolors -b ~/.dircolors)"
		else
			eval "$(dircolors -b)"
		fi
		alias ls='ls --color=auto'
		#alias dir='dir --color=auto'
		#alias vdir='vdir --color=auto'

		alias grep='grep --color=auto'
		alias fgrep='fgrep --color=auto'
		alias egrep='egrep --color=auto'
	fi

	# some more ls aliases
	alias ll='ls -alF'
	alias la='ls -A'
	alias l='ls -lA'
	alias cp='cp --reflink=auto'

	alias gl='go list -f '\''{{range .Imports}}{{println .}}{{end}}'\'''

	alias st='stterm -f "Go Mono"'

	# Alias definitions.
	# You may want to put all your additions into a separate file like
	# ~/.bash_aliases, instead of adding them here directly.
	# See /usr/share/doc/bash-doc/examples in the bash-doc package.

	if [[ -f ~/.bash_aliases ]]; then
        # shellcheck source=$HOME/.bash_aliases
		. "$HOME/.bash_aliases"
	fi

	for fn in ~/dotfiles/bash-completions/completions/*; do
		. "$fn"
	done
	_ALIASES_HAS_BEEN_SET=1
fi

# profabevjava
export KRDIR=$HOME/Documents/abevjava/eKuldes

if [[ -z "$_ULIMIT_HAS_BEEN_SET" ]]; then
	memsize=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
	ulimit -S -d "$memsize"
	#ulimit -S -m $(( "$memsize" * 1 ))
	#ulimit -S -v $(( "$memsize" * 3 ))

	set -o vi
	_ULIMIT_HAS_BEEN_SET=1
fi

if [[ -z "$_PROMPT_HAS_BEEN_SET" ]]; then
	# don't put duplicate lines in the history. See bash(1) for more options
	# ... or force ignoredups and ignorespace
	HISTCONTROL=ignoredups:ignorespace
	# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
	HISTSIZE=1000
	HISTFILESIZE=2000

	if [[ -n "$BASH_VERSION" ]]; then
		# append to the history file, don't overwrite it
		shopt -s histappend

		# check the window size after each command and, if necessary,
		# update the values of LINES and COLUMNS.
		shopt -s checkwinsize

		# enable programmable completion features (you don't need to enable
		# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
		# sources /etc/bash.bashrc).
		if [[ -f /etc/bash_completion ]] && ! shopt -oq posix; then
            # shellcheck source=/etc/bash_completion
			. /etc/bash_completion
		fi
	fi

	# make less more friendly for non-text input files, see lesspipe(1)
	if [[ -x /usr/bin/lesspipe ]]; then
        eval "$(SHELL=/bin/sh lesspipe)"
    fi

	_PROMPT_HAS_BEEN_SET=1
fi

if [[ -e ~/.ssh/tgulacsi@github.com ]]; then
    # shellcheck source=$HOME/.ssh/tgulacsi@github.com
	. "$HOME/.ssh/tgulacsi@github.com"
fi

# no ! history expansion
set +H

#[ -x ~/bin/uno-ssh ] && . ~/bin/uno-ssh
# tmux
#echo "# TERM=$TERM XDG_VTNR=$XDG_VTNR TMUX=$TMUX" >&2
if [[ "$TERM" != 'dumb' ]]; then
	export COLORTERM=truecolor
	if [[ "$XDG_VTNR" = 7 || "$XDG_VTNR" = 8 ]] && which tmux >/dev/null 2>&1; then
		if [[ -z "$TMUX" ]]; then
			if [[ "$TERM" != 'sakura' ]]; then
				case "$TERM" in
				tmux- | xterm-) ;;
				*)
					export TERM=xterm-256color
					;;
				esac
                # last non-attached
                last="$(tmux list-sessions -F '#{session_attached} #S' | sed -ne '/^0/ {s/^0 //; p;}' | head -n1)"
                if [[ -n "$last" ]]; then
                    exec tmux attach-session -t "$last"
                fi
				exec tmux 
			fi
		fi
	fi
fi
