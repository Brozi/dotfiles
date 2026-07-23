#!/bin/bash
# Terminate already running bar instances
killall -9 -q picom

# Wait until the processes have been shut down
while pgrep -u $UID -x picom >/dev/null; do sleep 1; done

picom -b
