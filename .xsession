#!/bin/bash
. $HOME/.bashrc
# exec startlxde
# exec dbus-launch lxsession -a
xset b off
~/bin/xkbmap
fbxkb &
nm-applet &
xscreensaver &
which gajim 2>/dev/null && gajim &
#exec ck-launch-session dbus-launch awesome
xrandr -q | grep -q 'HDMI1 connected' && xrandr --output LVDS1 --auto --left-of HDMI1
exec ck-launch-session dbus-launch i3
