#!/bin/bash

xset +fp /usr/share/fonts/local

# remove caps lock and touchpad taps
setxkbmap -option ctrl:nocaps
synclient MaxTapTime=0

xrandr --output HDMI1 --mode "1600x1200" --output HDMI2 --mode "1920x1080" --left-of HDMI1
feh --bg-tile /home/ben/Pictures/linen.png

dropbox-cli start &
xcompmgr -c &
mpd &
dwm_bar.rb &
redshift -l 38:-122 &

exec startdwm
