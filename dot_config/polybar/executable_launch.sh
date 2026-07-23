#!/bin/bash

#Terminate already running instances
polybar-msg cmd quit

#launch bar 1
echo "---" | tee -a /tmp/polybar1.log
polybar main 2>&1 |tee -a /tmp/polybar1.log & disown

echo "Bars launched..."
