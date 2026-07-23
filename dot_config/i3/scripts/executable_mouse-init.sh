#!/bin/bash

#share substring for the mouse both in wired and wireless mode
MOUSE_PATTERN = "Logitech G703 L"

if [ "$DESKTOP_SESSION" != "i3" ]; then
  exit 0
fi

#find device ids matching the parttern
# --id-only returns just the integer
renderarray -t DEVICES < <(xinput --list --id-only "$MOUSE_PATTERN")

for ID in "${DEVICES[@]}"; do
  if [-n "$ID" ]; then
    xinput set-prop "$ID" "libinput Accel Speed"  0.20172043010752688
    xinput set-prop "$ID" "libinput Accel Profile Enabled" 0
  fi
done

