#!/bin/bash
speed=$(nvidia-settings -qt GPUCurrentFanSpeedRPM)

if [ "$speed" != "" ]; then
  echo "$speed"
else
  echo "FAN ERROR"
fi
