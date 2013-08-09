# exec startlxde
# exec dbus-launch lxsession -a
for nm in urxvtcd sakura lxterminal xfce4-terminal; do
    if which $nm 2>/dev/null; then
        export TERMINAL=$nm
        break
    fi
done

xset b off
~/bin/xkbmap
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &

if [ -f ~/.Xresources ]; then
    xrdb -merge ~/.Xresources
fi

fbxkb &
nm-applet &
#if which groximity 2>/dev/null; then
#    groximity 20:13:E0:36:E7:53 &
#else
    if which xscreensaver 2>/dev/null; then
        xscreensaver &
    fi
vi
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
#if which centerim-utf8 2>/dev/null; then
#    if [ -n "$TERMINAL" ]; then
#        $TERMINAL -e centerim-utf8 &
#    fi
#else
    which gajim 2>/dev/null && gajim &
#fi
) &
#/sbin/ifconfig eth0|grep -q 'inet addr:10\.' \
#&& for nm in ~/mnt/p520/*; do mount $nm & done

#which xflux 2>/dev/null &&  ./xflux -l 47.710686 -g 19.15161
which autocutsel 2>/dev/null && autocutsel -fork
gpg-agent --daemon --enable-ssh-support \
                   --write-env-file "${HOME}/.gpg-agent-info"

exec ck-launch-session dbus-launch i3

