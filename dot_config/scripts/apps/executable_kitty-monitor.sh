#!/bin/bash

# 1. Launch the isolated Kitty session in the background
kitty --title "monitor" --session ~/.config/kitty/sessions/monitor.kitty-session &

# 2. Poll the display server until the window registers
WAIT_TIME=0
while ! wmctrl -l | grep -q "monitor"; do
  sleep 0.5
  WAIT_TIME=$((WAIT_TIME + 1))
  if [ $WAIT_TIME -ge 20 ]; then
    exit 1
  fi
done

# 3. The Mapping Buffer
# Crucial: You must allow Cinnamon time to physically draw the window 
# before attempting to move or alter its state.
sleep 1

# 4. Relocate to the Second Monitor FIRST
# We move it safely into the second monitor's coordinate grid. 
# The exact width and height (800,600) do not matter here, because 
# the next command will immediately overwrite them.
wmctrl -r "monitor" -e 0,1950,50,800,600

# 5. Trigger Native Fullscreen
# This sends an X11 property change to Cinnamon, stripping the window borders 
# and expanding it to fill whatever monitor it currently resides on.
wmctrl -r "monitor" -b add,maximized_vert,maximized_horz
