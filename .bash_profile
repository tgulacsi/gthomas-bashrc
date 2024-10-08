#!/bin/bash
# ~/.profile: executed by the command interpreter for login shells.
# This file is NOT read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# shellcheck source=$HOME/.bashrc disable=SC1091
. "$HOME/.bashrc"  

if [[ -n "${XDG_RUNTIME_DIR:-}" ]]; then
	touch "$XDG_RUNTIME_DIR/wallpaper.png"
fi

export NMON=cdm4

export PS1=":\[\e[1;32m\]\u@\H:\[\e[m\] \[\e[1;37m\]\w\[\e[m\]\n\$(if [ \$? = 0 ]; then echo '$'; else echo '!'; fi) "

export "USER_RUN_DIR=/var/run/user/$(id -u)"

if [ -L ~/.cache ]; then
	mkdir -p "$(readlink ~/.cache)"
elif ! [ -e ~/.cache.do-not-touch ]; then
{ set -e
	mv ~/.cache "$USER_RUN_DIR/"
	rm -rf ~/.cache
	ln -sf "$USER_RUN_DIR/.cache" ~/.cache
	mkdir -p "$USER_RUN_DIR/.cache"
}
fi
mkdir -p ~/.cache/mutt

# shellcheck source=$HOME/bin/invoke-gpg-agent disable=SC1091
if [[ -x "$HOME/bin/invoke-gpg-agent" ]]; then
. "$HOME/bin/invoke-gpg-agent"
fi

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
		# shellcheck disable=SC1091
		# shellcheck source=$HOME/.bash_aliases
		. "$HOME/.bash_aliases"
	fi

	for fn in ~/dotfiles/bash-completions/completions/*; do
		# shellcheck disable=SC1091
		. "$fn"
	done
	_ALIASES_HAS_BEEN_SET=1
fi

# profabevjava
export KRDIR=$HOME/Documents/abevjava/eKuldes

if [[ -z "$_ULIMIT_HAS_BEEN_SET" ]]; then
	memsize=$(awk '/MemTotal/ {printf "%d", $2 * 921}' /proc/meminfo)
	ulimit -S -d "$memsize"
	#ulimit -S -m $(( "$memsize" * 1 ))
	#ulimit -S -v $(( "$memsize" * 3 ))
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
		    # shellcheck source=/etc/bash_completion disable=SC1091
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
	# shellcheck disable=SC1091
	# shellcheck source=.ssh/tgulacsi@github.com
	. "$HOME/.ssh/tgulacsi@github.com"
fi

# no ! history expansion
set -o vi +H

if [ "$(tty)" = "/dev/tty3" ]; then
	#export "WLR_DRM_DEVICES=$(for fn in /dev/dri/card[0-9]; do if udevadm info -a -n "$fn" | grep -qF boot_vga; then echo -n 0; else echo -n 1; fi; echo " $fn"; done | sort -n | cut -c3-  | head -n1 | tr '\n' ':' | sed -e 's/:$//')"
	#export WLR_NO_HARDWARE_CURSORS=1
	unset DISPLAY
	exec systemd-cat -t sway -- dbus-run-session sway 
fi

# sh <(curl -L https://nixos.org/nix/install)
if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then . ~/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
if [ -e ~/.config/nix/nix.conf ]; then export NIX_USER_CONF_FILES=~/.config/nix/nix.conf; fi

#[ -x ~/bin/uno-ssh ] && . ~/bin/uno-ssh
# tmux
#echo "# TERM=$TERM XDG_VTNR=$XDG_VTNR TMUX=$TMUX" >&2
if [[ "$TERM" != 'dumb' ]]; then
	export DISPLAY=${DISPLAY:-:0}
	export COLORTERM=truecolor
	export TERM=xterm-256color
	if which tmux >/dev/null 2>&1; then
		if [[ -z "$TMUX" ]]; then
			# last non-attached
			last="$(tmux list-sessions -F '#{session_attached} #S' | sed -ne '/^0/ {s/^0 //; p;}' | head -n1)"
			if [[ -n "$last" ]]; then
				exec tmux attach-session -t "$last"
			fi
			exec tmux
		fi
	fi
fi

