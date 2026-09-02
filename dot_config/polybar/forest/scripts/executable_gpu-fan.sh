#!/bin/bash
speed=$(nvidia-settings -qt GPUCurrentFanSpeedRPM)

if [ "$speed" != "" ]; then
  echo "$speed RPM"
else
  echo "FAN ERROR"
fi
