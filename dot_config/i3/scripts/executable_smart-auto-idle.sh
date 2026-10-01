#!/usr/bin/env bash

while true; do
  # check if any media player is actively playing
  if [ "$(playerctl status 2>/dev/null)" = "Playing" ]; then
    xset s reset
  fi
  # wait 30 seconds before checking again
  sleep 30
done
