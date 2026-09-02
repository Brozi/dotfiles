#!/usr/bin/env bash

NOTIFY_ICON=/usr/share/icons/Papirus/32x32/apps/system-software-update.svg

get_mint_interval_seconds() {
  # Fetch values and strictly strip out any non-numeric characters (like "uint32 ")
  local mins=$(gsettings get org.linuxmint.updates refresh-minutes 2>/dev/null | tr -cd '0-9')
  local hours=$(gsettings get org.linuxmint.updates refresh-hours 2>/dev/null | tr -cd '0-9')
  local days=$(gsettings get org.linuxmint.updates refresh-days 2>/dev/null | tr -cd '0-9')

  # Enforce default integer fallbacks if the variables end up empty
  mins=${mins:-0}
  hours=${hours:-2}
  days=${days:-0}

  # Calculate total interval in seconds
  echo $(((days * 86400) + (hours * 3600) + (mins * 60)))
}

get_total_updates() {
  UPDATES=$(~/.config/polybar/forest/scripts/updates-apt 2>/dev/null | wc -l)
}

while true; do
  get_total_updates
  REFRESH_SEC=$(get_mint_interval_seconds)

  # Validate that REFRESH_SEC is actually a number, and enforce the 10-minute minimum
  if ! [[ "$REFRESH_SEC" =~ ^[0-9]+$ ]] || ((REFRESH_SEC < 600)); then
    REFRESH_SEC=3600
  fi

  # Notify user of updates
  if hash notify-send &>/dev/null; then
    if ((UPDATES > 20)); then
      notify-send -u critical -i "$NOTIFY_ICON" \
        "You really need to update!!" "$UPDATES New packages"
    elif ((UPDATES > 10)); then
      notify-send -u normal -i "$NOTIFY_ICON" \
        "You should update soon" "$UPDATES New packages"
    elif ((UPDATES > 2)); then
      notify-send -u low -i "$NOTIFY_ICON" \
        "$UPDATES New packages"
    fi
  fi

  # Output to Polybar
  if ((UPDATES > 0)); then
    echo "$UPDATES"
  else
    echo "None"
  fi

  # Wait for the exact duration
  sleep "$REFRESH_SEC"
done
