#!/usr/bin/env bash

dir="$HOME/.config/rofi/launchers/type-1"
theme='style-6'

## Run
rofi \
  -modi "clipboard:greenclip print" \
  -show clipboard \
  -run-command '{cmd}'
