#!/bin/bash
pgrep -f '^kitty --class monitor' || kitty --class monitor --session ~/.config/kitty/sessions/monitor2.kitty-session &
