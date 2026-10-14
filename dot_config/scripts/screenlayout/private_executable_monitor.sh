#!/usr/bin/env bash
# 1. Force the center monitor on and disable the sides
xrandr --output DP-2 --primary --mode 2560x1440 --rate 144.00 --pos 2560x0 --rotate normal \
  --output HDMI-0 --off \
  --output HDMI-1 --off

# 2. Wait 1 second for the DP handshake
sleep 1

# 3. Assert all three monitors together to build the 7680x1440 virtual screen
xrandr --output HDMI-1 --mode 2560x1440 --rate 144.00 --pos 0x0 --rotate normal \
  --output DP-2 --primary --mode 2560x1440 --rate 144.00 --pos 2560x0 --rotate normal \
  --output HDMI-0 --mode 2560x1440 --rate 144.00 --pos 5120x0 --rotate normal
