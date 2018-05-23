#!/bin/sh

MONITOR_SETTING=${1:-roadwarrior}

# Polybar doesn't like this at all
killall -q polybar

case $1 in
  roadwarrior)
    xrandr --output eDP1 --primary --mode 2560x1440 --pos 0x0 --rotate normal --output DP1-2 --off --output DP1-2 --off
    xrandr --output HDMI1 --mode 1920x1080 --same-as eDP1
    I3_CONFIG=roadwarrior
    ;;
  office)
    xrandr --output DP1-2 --primary --mode 3440x1440 --pos 1920x0 --rotate normal --output eDP1 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI1 --off --output DP2 --off
    I3_CONFIG=office
    ;;
  extend)
    xrandr --output eDP1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP1-2 --off --output DP1-2 --off, exec xrandr --output HDMI1 --auto --right-of eDP1
    I3_CONFIG=roadwarrior
    ;;
  *)
    echo 'Usage: i3-set-config.sh roadwarrior|altwork|extend'
    exit 1
esac

# Give xrandr a second to take effect
sleep 2

# Generate i3 config from pieces
cat \
  ~/.config/i3/config_base \
  ~/.config/i3/config_${I3_CONFIG} \
  > ~/.config/i3/config

# Re-enable caps:escape
setxkbmap -option caps:escape

# Restart i3
i3-msg restart
