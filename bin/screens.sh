#!/bin/sh
set -e
set -u
connected="$(xrandr | grep -F ' connected' | grep -Fv 'not connected')"
N=${1:-$(echo "$connected" | wc -l)}
main=$(echo "$connected" | cut -d\  -f1 | grep -v -F HDMI)
NAME="$(xrandr | grep -Fv VIRTUAL | grep -F connected | grep -Fv 'not connected' | cut -d\  -f1 | grep -Fv eDP | head -n 1)"
NAME="${NAME:-HDMI-1}"
echo "NAME=$NAME"
if [ -z "${SIZE:-}" ]; then
	SIZE="$(xrandr | sed -ne "/^$NAME/,/[*]/p" | grep -F '*' | tail -n1 | awk '{print $1}')"
fi
nm=${main% *}
pos="$(xrandr | sed -ne '/DP-1 connected/,/+/ s/^.* \([1-9][0-9]*\)x.*$/\1/p' | head -n1)"
echo "# main=$main SIZE=$SIZE -> nm=$nm pos=$pos" >&2

set -x
case "${N:-1}" in
  1) exec xrandr --output "$main" --auto
	  ;;
  2)
	  if [ "${SIZE%x*}" -ge 2560 ]; then
		exec xrandr --output "$main" --off --output "$NAME" --auto --pos "${pos}x0" --rotate normal --scale 1x1
	  else
		exec xrandr --output "$nm" --auto --pos 0x0 --rotate normal --output "$NAME" --auto --pos "${pos}x0" --rotate normal --scale 1x1
	  fi
	  ;;
  *) echo "unknown number of connected outputs: $N >&2" ;
	  exit "$N"
	  ;;
esac
