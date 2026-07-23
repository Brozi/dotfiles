#!/bin/bash
# Get the birth time of the root filesystem
INSTALL_DATE_FULL=$(stat -c %w /)
# Convert the date string to seconds since 01-01-1970
INSTALL_DATE_SECONDS=$(date -d "$INSTALL_DATE_FULL" +%s)
CURRENT_DATE_SECONDS=$(date +%s)
# Calculate the difference in days (86400 seconds per day)
DAYS=$((($CURRENT_DATE_SECONDS - $INSTALL_DATE_SECONDS) / 86400))
# Output the result
echo "$DAYS days"
