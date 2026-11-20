#!/bin/bash

# Live wallpaper
# Change to kill window id = 0
killall mpv
exec mpv --wid=0 --loop-file=yes ~/.config/wallpaper/Cyberpunk_2077_1080.mp4 &

# Status bar
exec slstatus &
