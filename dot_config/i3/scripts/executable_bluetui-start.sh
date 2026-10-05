#!/usr/bin/env bash

# Check if bluetui is already running so we don't spawn duplicates
if ! pgrep -f '^kitty --class bluetui-scrtch' >/dev/null; then
  # 1. Launch bluetui in the background
  kitty --class 'bluetui-scrtch' bluetui &

  # 2. Give bluetui 3 seconds to fully load and turn the adapter on
  sleep 3

  # 3. Force the adapter back off
  bluetoothctl power off
fi
