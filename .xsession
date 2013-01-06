#!/bin/bash
. $HOME/.bashrc
# exec startlxde
# exec dbus-launch lxsession -a
xset b off
~/bin/xkbmap
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &
fbxkb &
nm-applet &
if which groximity 2>/dev/null; then
    groximity 20:13:E0:36:E7:53 &
else
    xscreensaver &
fi
which gajim 2>/dev/null && gajim &
#exec ck-launch-session dbus-launch awesome
(
sleep 1
if xrandr -q | grep -q 'HDMI1 connected'; then
    ~/.screenlayout/unosoft.sh &
else 
    ~/.screenlayout/solitaire.sh &
fi
) &
#/sbin/ifconfig eth0|grep -q 'inet addr:10\.' \
#&& for nm in ~/mnt/p520/*; do mount $nm & done

exec ck-launch-session dbus-launch i3
