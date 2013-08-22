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
sleep 0.5
if xrandr -q | grep -q 'HDMI1 connected'; then
    ~/.screenlayout/unosoft.sh &
else
    ~/.screenlayout/solitaire.sh &
fi
sleep 1
[ -x ~/bin/uno-ssh ] && . ~/bin/uno-ssh &
sleep 1

for nm in pidgin gajim centerim-utf8; do
    if which $nm 2>/dev/null; then
        if [ "$nm" = centerim-utf8 ]; then
            $TERMINAL -e centerim-utf8 &
        else
            $nm &
        fi
        break
    fi
done
) &

(
for i in seq 120; do
    addr=$(/sbin/ifconfig eth0 | grep 'inet addr:')
    if [ -z "$addr" ]; then
        sleep 1
        continue
    fi
    if echo "$addr" | grep -q 'addr:10\.'; then
        p520.mountall
    fi
    break
done
) &

if [ -x ~/bin/nasaBackground.sh ]; then
    (
    sleep 3
    ~/bin/nasaBackground.sh
    ) &
fi
#which xflux 2>/dev/null &&  ./xflux -l 47.710686 -g 19.15161
which autocutsel 2>/dev/null && autocutsel -s PRIMARY -fork
gpg-agent --daemon --enable-ssh-support \
                   --write-env-file "${HOME}/.gpg-agent-info"

exec ck-launch-session dbus-launch i3

