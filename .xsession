#!/bin/bash
. $HOME/.bashrc
# exec startlxde
# exec dbus-launch lxsession -a
xset b off
~/bin/xkbmap
fbxkb &
#exec ck-launch-session dbus-launch awesome
exec ck-launch-session dbus-launch i3
