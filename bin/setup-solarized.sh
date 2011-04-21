#!/bin/sh
echo 'setup solarized'

BASE=~/solarized
mk_or_get () {
    dn=$1
    shift
    CMD="$@"
    if [ -e $dn ]; then
        cd $dn && git pull origin master:master
        cd $BASE
    else
        $CMD
    fi
}

mkdir -p $BASE
cd $BASE || exit 1

[ -e dircolors ] || {
    wget --no-check-certificate 'https://github.com/seebi/solarized/raw/989a67d68e1a35d130d4afe6299b5f1c0d5c9122/ls-colors-solarized/dircolors'
    cp -p dircolors ~/.dircolors
    eval $(dircolors ~/.dircolors)
}

mk_or_get solarized \
    git clone 'https://github.com/altercation/solarized.git'
mkdir -p ~/.vim/bundle
rsync -a solarized/vim-colors-solarized ~/.vim/bundle/
rsync -a solarized/xresources-colors-solarized/.Xresources ~/

mk_or_get gnome-terminal-colors-solarized \
    git clone 'https://github.com/sigurdga/gnome-terminal-colors-solarized.git'
cd gnome-terminal-colors-solarized
./set_dark.sh
cd ..

mk_or_get solarized-gedit \
    git clone 'https://github.com/craig552uk/solarized-gedit.git'
mkdir -p ~/.gnome2/gedit/styles/
rsync -a solarized-gedit/*.xml ~/.gnome2/gedit/styles/