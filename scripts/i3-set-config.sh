#!/bin/sh

MONITOR_SETTING=${1:-roadwarrior}

# Chmod the scripts dir
chmod +x /home/travis/bin/*

# Polybar doesn't like this at all
killall -q polybar

# ADD DPI Back here? 

case $1 in
  roadwarrior)
    xrandr --output eDP1 --primary --mode 2560x1440 --pos 0x0 --rotate normal --output DP2 --off --output DP1 --off
    xrandr --output HDMI1 --mode 1920x1080 --same-as eDP1
    I3_CONFIG=roadwarrior
    ;;
  office)
    #xrandr --output DP2 --primary --mode 3440x1440 --pos 2560x0 --rotate normal --output eDP1 --mode 2560x1440 --pos 0x0 --rotate normal --output HDMI1 --off --output DP2 --off
    xrandr --output DP1 --primary --mode 3840x1600 --rotate normal --above eDP1 --output eDP1 --dpi 130 --mode 2560x1440 --rotate normal --output HDMI1 --off --output DP2 --off
    I3_CONFIG=office
    ;;
  extend)
    xrandr --output eDP1 --primary --mode 2560x1440 --pos 0x0 --rotate normal --output DP2 --off --output DP2 --off, exec xrandr --output HDMI1 --auto --right-of eDP1
    I3_CONFIG=roadwarrior
    ;;
  *)
    echo 'Usage: i3-set-config.sh roadwarrior|office|extend'
    exit 1
esac

#xrandr --output eDP1 --dpi 130

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
