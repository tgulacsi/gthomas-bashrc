# exec startlxde
# exec dbus-launch lxsession -a
for nm in urxvtcd lxterminal xfce4-terminal; do
    if which $nm 2>/dev/null; then
        export TERMINAL=$nm
    fi
done

xset b off
~/bin/xkbmap
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &

[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

fbxkb &
nm-applet &
if which groximity 2>/dev/null; then
    groximity 20:13:E0:36:E7:53 &
else
    xscreensaver &
fi
#exec ck-launch-session dbus-launch awesome
(
sleep 1
if xrandr -q | grep -q 'HDMI1 connected'; then
    ~/.screenlayout/unosoft.sh &
else 
    ~/.screenlayout/solitaire.sh &
fi
sleep 1
[ -x ~/bin/uno-ssh ] && . ~/bin/uno-ssh &
sleep 1
which gajim 2>/dev/null && gajim &
) &
#/sbin/ifconfig eth0|grep -q 'inet addr:10\.' \
#&& for nm in ~/mnt/p520/*; do mount $nm & done

which xflux 2>/dev/null &&  ./xflux -l 47.710686 -g 19.15161

exec ck-launch-session dbus-launch i3

