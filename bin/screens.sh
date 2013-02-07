#!/bin/sh
N=${1:-$(xrandr | grep ' connected' | wc -l)}
case "${N:-1}" in
  1) CMD='xrandr --output HDMI1 --off --output LVDS1 --mode 1366x768 --pos 0x0 --rotate normal --output DP1 --off --output VGA1 --off' ;;
  2) CMD='xrandr --output HDMI1 --mode 1920x1080 --pos 1366x0 --rotate normal --output LVDS1 --mode 1366x768 --pos 0x0 --rotate normal --output DP1 --off --output VGA1 --off' ;;
  *) echo "unknown number of connected outputs: $N >&2" ; exit $N ;;
esac
echo $CMD
exec $CMD

