#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="$HOME/.config/polybar/shapes"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch one bar per connected monitor. The config falls back to HDMI-1 when
# MONITOR is not set, which matches this machine's primary display.
mapfile -t monitors < <(polybar -m | cut -d: -f1)

if ((${#monitors[@]})); then
  for monitor in "${monitors[@]}"; do
    MONITOR="$monitor" polybar -q main -c "$DIR"/config.ini &
  done
else
  polybar -q main -c "$DIR"/config.ini &
fi
