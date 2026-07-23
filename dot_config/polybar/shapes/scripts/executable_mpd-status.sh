#!/usr/bin/env bash

if command -v mpc >/dev/null 2>&1; then
  song="$(mpc current 2>/dev/null)"
  if [[ -n "$song" ]]; then
    printf '%s\n' "$song"
    exit 0
  fi
fi

printf 'Offline\n'
