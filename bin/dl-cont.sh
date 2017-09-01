#!/bin/sh
youtube-dl --prefer-free-format --prefer-insecure --no-playlist --hls-use-mpegts "$@"
