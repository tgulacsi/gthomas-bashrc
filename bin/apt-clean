#!/bin/sh
set -x
aptitude search -F '%p' '~c' | xargs -n 512 sudo aptitude -y purge
sudo apt-get autoremove -y
sudo apt-get autoclean -y
