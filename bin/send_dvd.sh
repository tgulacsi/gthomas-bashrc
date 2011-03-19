#!/bin/sh
ISO="${ISO:-/opt/data/gthomas/${1:-send_dvd}.iso}"
#dd if=/dev/sr0  bs=$((1024^2)) | pigz -c - | mbuffer -m 512M -p 25 | nc -q 30 miranda 3333
rm -f "${ISO}"
dd_rescue /dev/sr0 "$ISO" &
CHILD=$!
sleep 5
tail --follow=descriptor -c 1024M "${ISO}" \
  | pigz -c - | mbuffer -q -m 128M -p 25 | nc -q 30 miranda 3333
kill $CHILD
