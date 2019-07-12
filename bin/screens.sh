#!/bin/sh
set -e
set -u
#!/bin/bash

SCREEN_LEFT=eDP-1
START_DELAY=2

renice +19 $$ >/dev/null

if ! which inotifywait >/dev/null 2>/dev/null; then
	sudo -A apt install inotify-tools
fi

sleep $START_DELAY

OLD_DUAL="dummy"

while /bin/true; do
    DUAL="$(grep -h ^connected /sys/class/drm/card0-DP-?/status)"
	echo "# DUAL=$DUAL" >&2

    if [ "$OLD_DUAL" != "$DUAL" ]; then
        if [ "$DUAL" = "connected" ]; then
			SCREEN_RIGHT="$(xrandr -q | fgrep ' connected' | awk '/^[^e]/ { print $1 }')"
			echo "# SCREEN_RIGHT=$SCREEN_RIGHT" >&2
            echo 'Dual monitor setup'
            xrandr --output "$SCREEN_LEFT" --off --rotate normal --pos 0x0 --output "$SCREEN_RIGHT" --auto --rotate normal --right-of "$SCREEN_LEFT"
        else
            echo 'Single monitor setup'
            xrandr --auto
        fi

        OLD_DUAL="$DUAL"
    fi

    inotifywait -q -e close_write -e create -e delete -t 30 -r /sys/class/drm/ >/dev/null || echo $?
done

exit 0

connected="$(xrandr | grep -F ' connected' | grep -Fv 'not connected' | cut -d\  -f1)"
echo "# connected=$connected" >&2
N=${1:-$(echo "$connected" | wc -l)}
echo "# N=$N" >&2
if [ "${N:-1}" -eq 1 ]; then
	exec xrandr --output "$connected" --auto
elif [ "${N:-1}" -ge 3 ]; then
	echo "unknown number of connected outputs: $N" >&2
	exit $N
fi

main=$(echo "$connected" | cut -d\  -f1 | grep -v -E 'DP-[0-9]-|HDMI')
echo "# main=$main" >&2
NAME="$(xrandr | grep -Fv VIRTUAL | grep -F connected | grep -Fv 'disconnected' | cut -d\  -f1 | grep -Fv eDP | head -n 1)"
echo "# name=$NAME" >&2
NAME="${NAME:-HDMI-1}"
echo "# NAME=$NAME" >&2
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
esac
