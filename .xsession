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
if xrandr -q | grep -q 'HDMI1 connected'; then
    ~/.screenlayout/unosoft.hu
else 
    ~/.screenlayout/solitaire.sh
fi
exec ck-launch-session dbus-launch i3
