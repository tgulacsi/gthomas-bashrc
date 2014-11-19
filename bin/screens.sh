#!/bin/sh
connected=$(xrandr | grep -F ' connected')
N=${1:-$(echo "$connected" | wc -l)}
main=$(echo "$connected" | cut -d\  -f1,3 | grep -v -F HDMI1)
nm=${main% *}
sz=${main#* }
sz=${sz%%+*}
sz=${SIZE:-1920x1080}
pos=${sz%x*}
scale=
if [ ${pos} -gt 1366 ]; then
    scale=--scale 0.75x0.75
fi
case "${N:-1}" in
  1) CMD="xrandr --output HDMI1 --off --output $nm --mode $sz $scale --pos 0x0 --rotate normal" ;;
  2) CMD="xrandr --output HDMI1 --mode $sz --pos ${pos}x0 --rotate normal --output $nm --mode $sz $scale --pos 0x0 --rotate normal" ;;
  *) echo "unknown number of connected outputs: $N >&2" ; exit $N ;;
esac
echo $CMD
exec $CMD

