#!/bin/sh
set -x
connected=$(xrandr | grep -F ' connected' | fgrep -v 'not connected')
N=${1:-$(echo "$connected" | wc -l)}
main=$(echo "$connected" | cut -d\  -f1,3 | grep -v -F HDMI)
NAME="$(xrandr | grep -Fv VIRTUAL | grep -F connected | grep -Fv 'not connected' | cut -d\  -f1 | grep -Fv eDP | head -n 1)"
NAME="${NAME:-HDMI-1}"
echo "NAME=$NAME"
if [ -z "$SIZE" ]; then
	SIZE="$(xrandr | sed -ne "/^$NAME/,/[*]/p" | grep -F '*' | tail -n1 | awk '{print $1}')"
fi
nm=${main% *}
sz=${main#* }
sz=${sz%%+*}
sz=${SIZE:-}
pos=${sz%x*}

scale=1x1
noScale="$(xrandr | sed -ne '/DP-1 connected/,/connected/p' | grep -Fq '1920x1080')"
if [ -n "$noScale" ] && [ "$noScale" -eq 1 ] && [ "${pos}" -ge 1367 ]; then
    scale='0.7114583x0.7114583'
fi
case "${N:-1}" in
  1) CMD="xrandr --output $NAME --auto" ;;
  2) CMD="xrandr --output $NAME --auto --pos ${pos}x0 --rotate normal --output $nm --auto --pos 0x0 --rotate normal" ;;
  *) echo "unknown number of connected outputs: $N >&2" ; exit "$N" ;;
esac
echo "$CMD"
exec $CMD
