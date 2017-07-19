#!/bin/sh
set -x
connected=$(xrandr | grep -F ' connected' | fgrep -v 'not connected')
N=${1:-$(echo "$connected" | wc -l)}
main=$(echo "$connected" | cut -d\  -f1,3 | grep -v -F HDMI)
nm=${main% *}
sz=${main#* }
sz=${sz%%+*}
sz=${SIZE:-1920x1080}
pos=${sz%x*}
scale=
noScale=$(xrandr | sed -ne '/DP-1 connected/,/connected/p' | fgrep -q '1920x1080')

if [ $noScale -eq 0 ] && [ ${pos} -gt 1366 ]; then
    scale='--scale 0.75x0.75'
fi
NAME=$(xrandr | fgrep -v VIRTUAL | fgrep connected | fgrep -v 'not connected' | cut -d\  -f1 | fgrep -v eDP | head -n 1)
NAME=${NAME:-HDMI1}
echo "NAME=$NAME"
case "${N:-1}" in
  1) CMD="xrandr --output $NAME --off --output $nm --mode $sz $scale --pos 0x0 --rotate normal" ;;
  2) CMD="xrandr --output $NAME --mode $sz --pos ${pos}x0 --rotate normal --output $nm --mode $sz $scale --pos 0x0 --rotate normal" ;;
  *) echo "unknown number of connected outputs: $N >&2" ; exit $N ;;
esac
echo $CMD
exec $CMD

