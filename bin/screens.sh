#!/bin/sh
connected=$(xrandr | grep -F ' connected')
N=${1:-$(echo "$connected" | wc -l)}
main=$(echo "$connected" | cut -d\  -f1,3 | grep -v -F HDMI1)
nm=${main% *}
sz=${main#* }
sz=${sz%%+*}
pos=${sz%x*}
case "${N:-1}" in
  1) CMD="xrandr --output HDMI1 --off --output $nm --mode 1366x768 --pos 0x0 --rotate normal" ;;
  2) CMD="xrandr --output HDMI1 --mode 1366x768 --pos ${pos}x0 --rotate normal --output $nm --mode $sz --pos 0x0 --rotate normal" ;;
  *) echo "unknown number of connected outputs: $N >&2" ; exit $N ;;
esac
echo $CMD
exec $CMD

