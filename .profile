# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
#export LANGUAGE="hu_HU:en_US:en"
export LANGUAGE="en"
export LANG="hu_HU.UTF-8"
#export LC_ALL=hu_HU.UTF-8

mkdir -p /tmp/$USER
if [ -h $HOME/.cache ]; then
  TGT=$(readlink -f $HOME/.cache)
  [ -n "$TGT" ] && [ ! -e "$TGT" ] && mkdir $TGT
else
  mv $HOME/.cache /tmp/$USER/
  ln -s /tmp/$USER/.cache $HOME/
fi
[ -d $HOME/.mozilla/firefox ] && {
    for CD in $HOME/.mozilla/firefox/*.default; do
      if [ -h $CD/Cache ]; then
        TGT=$(readlink -f $CD/Cache)
        [ -n "$TGT" ] && [ ! -e "$TGT" ] && mkdir $TGT
      else
        TGT=/tmp/$USER${CD:${#HOME}}
        mkdir -p $TGT
        mv $CD/Cache $TGT
        ln -s $TGT $CD/Cache
      fi
    done
}

keychain

#. /home/gthomas/.profabevjava

if [ -z "$DISPLAY" ]; then
    if tmux list-session 2>&1 >/dev/null; then
        tmux attach
    else
        tmux new-session
    fi
fi

