#!/usr/bin/env bash

shopt -s nullglob

base="/sys/class/power_supply"

capacity_files=("$base"/*/capacity)

if (( ${#capacity_files[@]} > 0 )) && [[ -r "${capacity_files[0]}" ]]; then
  printf '%s%%\n' "$(cat "${capacity_files[0]}")"
else
  printf 'N/A\n'
fi
