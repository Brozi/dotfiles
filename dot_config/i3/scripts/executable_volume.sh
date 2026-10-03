#!/usr/bin/env bash

NOTIF_ID=2593
DURATION=1000
VOLUME_STEP=2

function send_notification() {
  volume=$(pamixer --get-volume)
  is_muted=$(pamixer --get-mute)

  if [ "$is_muted" = "true" ]; then
    dunstify -a "Volume" -r $NOTIF_ID -t $DURATION "Volume: Muted"
  else
    dunstify -a "Volume" -r $NOTIF_ID -t $DURATION -h int:value:"$volume" "Volume: ${volume}%"
  fi
}
case $1 in
up)
  # Increase volume by 2%
  pamixer -i $VOLUME_STEP
  send_notification
  ;;
down)
  # Decrease volume by 2%
  pamixer -d $VOLUME_STEP
  send_notification
  ;;
mute)
  # Toggle mute
  pamixer -t
  send_notification
  ;;
esac
