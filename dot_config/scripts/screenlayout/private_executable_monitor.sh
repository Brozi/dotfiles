#!/usr/bin/env bash
# 1. Force the center DisplayPort monitor on first and make it primary
xrandr --output DP-2 --primary --mode 2560x1440 --rate 144.00 --pos 2560x0 --rotate normal \
  --output DP-0 --off --output DP-1 --off --output DP-3 --off \
  --output HDMI-0 --off --output HDMI-1 --off

# 2. Wait 1 second for the DisplayPort handshake to finish
sleep 1

# 3. Wake up the HDMI side monitors
xrandr --output HDMI-1 --mode 2560x1440 --rate 144.00 --pos 0x0 --rotate normal \
  --output HDMI-0 --mode 2560x1440 --rate 144.00 --pos 5120x0 --rotate normal
