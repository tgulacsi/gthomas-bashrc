#!/bin/bash
CMD="mkvmerge -o $1"
shift
i=0
for mts in "$@"; do
    mkv=$(basename $mts .MTS).mkv
    MKV="avconv -i $mts -vcodec copy -acodec copy -f matroska $mkv"
    echo $MKV
    $MKV || exit $?
    nm=$mkv

    new=$(echo "$nm" | sed -e 's/ .*\././')
    [ "x$new" != "x$nm" ] && mv "$nm" "$new"
    #echo "$nm = $new ($CMD)"
    if [ $i -lt 1 ]; then
	CMD="$CMD $new"
    else
	CMD="$CMD +$new"
    fi
    i=$(($i+1))
done

echo $CMD
$CMD
echo $CMD
