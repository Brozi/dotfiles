#!/bin/sh

#Default to fan1 if no argument is provided
#Default to fan1 if no argument is provided
#Default to fan1 if no argument is provided
FAN="${1:-fan1}"

# Redirect stderr to drop the hardware I/O errors before filtering
speed=$(sensors 2>/dev/null | grep "$FAN" | sed -e "s/${FAN}: *//" -e 's/ RPM.*$//')

if [ "$speed" != "" ]; then
  echo "$speed RPM"
else
  echo "FAN ERROR"
fi
