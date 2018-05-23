#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch one bar per monitor
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    [[ $m = "eDP1" ]] && t=right || t=
    MONITOR=$m TRAY=$t polybar --reload example &
  done
else
  TRAY=right polybar --reload example &
fi

echo "Bars launched..."
