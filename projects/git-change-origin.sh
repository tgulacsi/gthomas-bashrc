#!/bin/sh
PATTERN=${PATTERN:-gthomas\.homelinux\.org}
REPLACEMENT=${REPLACEMENT:-gthomas.eu}
EXT=${EXT:-.$(date '+%Y%m%d%H%M%S')}
find . -name .git -type d | while read gitdn; do
  fn="$gitdn/config"
  grep -q "$PATTERN" $fn && {
    echo "$fn"
    sed -i"${EXT}" -e "s/$PATTERN/$REPLACEMENT/g" "$fn"
  }
done
