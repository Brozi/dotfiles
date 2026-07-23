#!/bin/bash
speed=$(nvidia-smi --query-gpu=fan.speed --format=csv,noheader,nounits)

if [ "$speed" != "" ]; then
  echo "$speed %"
else
  echo "FAN ERROR"
fi
