#!/usr/bin/env bash

NOTIFY_ICON=/usr/share/icons/Papirus/32x32/apps/system-software-update.svg
REFRESH_SEC=7200 # 2 hours in seconds

get_total_updates() {
  UPDATES=$(~/.config/polybar/forest/scripts/updates-apt 2>/dev/null | wc -l)
}

while true; do
  get_total_updates

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

  # Sleep reliably without relying on external desktop schemas
  sleep "$REFRESH_SEC"
done
