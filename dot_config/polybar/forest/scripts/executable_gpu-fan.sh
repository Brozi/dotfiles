#!/bin/bash
speed=$(nvidia-settings -q GPUCurrentFanSpeedRPM -t)

if [ "$speed" != "" ]; then
  echo "$speed RPM"
else
  echo "FAN ERROR"
fi
