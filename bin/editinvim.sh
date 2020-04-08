#!/bin/bash

function setclip() {
	xsel -n -b -i
}

function getclip() {
	xsel -n -b -o
}

file="$(mktemp)"
trap "rm '$file'" EXIT
getclip >"$file"
{
	echo "$file"
	cat "$file"
} >&2
stterm -e sh -c "env TERM=stterm-256color nvim '$file'"

if [ -s "$file" ]; then
	setclip <"$file"
	xdotool key ctrl+v
fi
