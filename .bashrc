#!/bin/bash
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

if [[ ${__bashrc_bench:-0} -eq 1 ]]; then
	PS4='+ $EPOCHREALTIME\011 '
	exec 5> /tmp/command.txt
	BASH_XTRACEFD="5"
	echo "See /tmp/command.txt" >&2
	set -x
fi

# set PATH so it includes user's private bin if it exists
#export LANGUAGE="hu_HU:en_US:en"
export LANGUAGE="en"
export LANG="hu_HU.UTF-8"
export LC_ALL=
#export ENV=$HOME/.profile

export MOZ_ENABLE_WAYLAND=1
export _JAVA_AWT_WM_NONREPARENTING=1
export GDK_BACKEND=wayland

export TNS_ADMIN=$HOME/.config/oracle
export TMPDIR=${TMPDIR:-/tmp}
EDITOR='vim'
export EDITOR
export VISUAL=$EDITOR
export PAGER='less'
export CCACHE_COMPRESS=1

export JAVA_OPTS='-XX:+IgnoreUnrecognizedVMOptions --add-modules java.se.ee'
if [[ -e "$HOME/android-sdk" ]]; then
	export PATH=$HOME/android-sdk/tools/bin:$PATH
fi

if [[ -z "$SUDO_ASKPASS" ]]; then
	export SUDO_ASKPASS=/usr/bin/ssh-askpass
fi

if [[ -d /usr/local/plan9 ]]; then
	export PLAN9=/usr/local/plan9
	PATH=$PATH:$PLAN9/bin
fi

export GO111MODULE=on
unset GOPATH
export GOBIN=~/bin
if [[ -x "/usr/local/go/bin/go" ]] && ! echo "$PATH" | grep -q /usr/local/go/bin; then
	export PATH=/usr/local/go/bin:$PATH
	if [[ -z "$GOROOT_BOOTSTRAP" ]] && [[ -e /usr/local/go1.4.2/bin/go ]]; then
		export GOROOT_BOOTSTRAP=/usr/local/go1.4.2
	fi
	export GOPRIVATE=unosoft.hu
	export GOPROXY=http://proxy.golang.org,direct
	export MAGEFILE_HASHFAST=1
fi
if [[ -z "$_OHOME_HAS_BEEN_SET" ]]; then
	export TNS_ADMIN=$HOME
	#echo OH=$ORACLE_HOME
	if [[ -z "$ORACLE_HOME" ]]; then
		for bdn in /u01/app/oracle/product /usr/lib/oracle; do
			#echo "bdn=$bdn"
			if [[ ! -d $bdn ]]; then
				continue
			fi
			dn="$(find "$bdn" -maxdepth 2 -type d \( -name xe -o -name client64 \) \
                2>/dev/null | head -n1)"
            #echo "#dn=$dn"
            export ORACLE_BASE=$bdn
            export ORACLE_HOME=$dn
            #export ORACLE_SID=XE
            export PATH=$ORACLE_HOME/bin:$PATH
            #echo "H=$ORACLE_HOME"
			break
		done
	fi
	#echo OH=$ORACLE_HOME
	_OHOME_HAS_BEEN_SET=1
fi

if [[ -z "$_PATH_HAS_BEEN_SET" ]]; then
	if [[ -d "$HOME/bin" ]] && echo "$PATH" | grep -vq "$HOME/bin"; then
		PATH="$HOME/bin:$PATH"
	fi
	export PATH
	_PATH_HAS_BEEN_SET=1
fi

if [[ -f ~/.fzf.bash ]]; then
    # shellcheck source=$HOME/.fzf.bash
    source ~/.fzf.bash
fi
