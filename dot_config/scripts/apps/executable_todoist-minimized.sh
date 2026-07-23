#!/bin/bash
# Buffer for the DE to load
sleep 5
# Launch Todoist
/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=todoist --file-forwarding com.todoist.Todoist @@u %U @@ & 
# Continuously check for the window every 1 second
while ! /usr/bin/wmctrl -l | grep -i "Skrzynka"; do
	sleep 1
done
# 1 second delay
sleep 1
wmctrl -c "Skrzynka"
