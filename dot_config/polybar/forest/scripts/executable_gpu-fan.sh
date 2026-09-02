#!/bin/bash
speed=$(nvidia-settings -q -t GPUCurrentFanSpeedRPM)

if [ "$speed" != "" ]; then
  echo "$speed RPM"
else
  echo "FAN ERROR"
fi
