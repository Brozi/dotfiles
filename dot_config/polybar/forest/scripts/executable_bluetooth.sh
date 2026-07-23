#!/bin/sh
# Check if Bluetooth is powered on
if ! bluetoothctl show | grep -q "Powered: yes"; then
    # Powered off: Gray color, larger font
    echo "%{F#6c7086}%{T4}%{T-}"
else
    # Check if a device is actively connected
    if bluetoothctl info | grep -q "Connected: yes"; then
        # Connected: Blue color, larger font
        echo "%{F#89b4fa}%{T4}%{T-}"
    else
        # Powered on but NOT connected: Default color, larger font
        echo "%{T4}%{T-}"
    fi
fi
