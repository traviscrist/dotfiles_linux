#!/bin/sh

STEP=5

# SINK=`pactl list sinks short | grep RUNNING | sed -e 's,^\([0-9][0-9]*\)[^0-9].*,\1,'`
SINK=`pacmd list-sinks |awk '/* index:/{print $3}'`

case $1 in
  up)
    pactl set-sink-volume $SINK +$STEP%
    ;;
  down)
    pactl set-sink-volume $SINK -$STEP%
    ;;
  toggle-mute)
    pactl set-sink-mute $SINK toggle
    ;;
  *)
    echo 'Usage: volume.sh up|down|toggle-mute'
esac

VOLUME=$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')
STATE=$(pactl list sinks | grep '^[[:space:]]Mute:' | head -n $(( $SINK + 1 )) | tail -n 1 | grep yes)

# Show volume with volnoti
if [[ -n $STATE ]]; then
    volnoti-show -m
else
    volnoti-show $VOLUME
fi

exit 0
