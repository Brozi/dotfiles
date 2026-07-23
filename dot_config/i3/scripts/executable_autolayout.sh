#!/usr/bin/env bash
killall -q i3-autolayout
while pgrep -u 1000 -x i3-autolayout >/dev/null; do sleep 1; done
i3-autolayout autolayout &
