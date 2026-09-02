#!/bin/env bash
speed=$(nvidia-settings -t -q GPUCurrentFanSpeedRPM 2>/dev/null)

if [ "$speed" != "" ]; then
  echo "$speed RPM"
else
  echo "FAN ERROR"
fi
