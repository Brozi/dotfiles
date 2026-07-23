#!/usr/bin/env bash

## Author  : Aditya Shakya (adi1090x)
## Github  : @adi1090x
## Applets : Screenshot

# Import Current Theme
source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$type/$style"

# Directory Fix: Bulletproof fallback if xdg-user-dir returns empty
pic_dir=$(xdg-user-dir PICTURES 2>/dev/null)
if [[ -z "$pic_dir" ]]; then
  pic_dir="$HOME/Pictures"
fi
dir="${pic_dir}/Screenshots"

# Theme Elements
prompt='Screenshot'
mesg="DIR: ${dir}"

if [[ "$theme" == *'type-1'* ]]; then
  list_col='1'
  list_row='5'
  win_width='400px'
elif [[ "$theme" == *'type-3'* ]]; then
  list_col='1'
  list_row='5'
  win_width='120px'
elif [[ "$theme" == *'type-5'* ]]; then
  list_col='1'
  list_row='5'
  win_width='520px'
elif [[ ("$theme" == *'type-2'*) || ("$theme" == *'type-4'*) ]]; then
  list_col='5'
  list_row='1'
  win_width='670px'
fi

# Options
layout=$(cat "${theme}" | grep 'USE_ICON' | cut -d'=' -f2)
if [[ "$layout" == 'NO' ]]; then
  option_1=" Capture Desktop"
  option_2=" Capture Area"
  option_3=" Capture Window"
  option_4=" Capture in 5s"
  option_5=" Capture in 10s"
else
  option_1=""
  option_2=""
  option_3=""
  option_4=""
  option_5=""
fi

# Rofi CMD
rofi_cmd() {
  rofi -theme-str "window {width: $win_width;}" \
    -theme-str "listview {columns: $list_col; lines: $list_row;}" \
    -theme-str 'textbox-prompt-colon {str: ""; padding: 11px 18px 11px 14px;}' \
    -dmenu \
    -p "$prompt" \
    -mesg "$mesg" \
    -markup-rows \
    -theme "${theme}"
}

# Pass variables to rofi dmenu
run_rofi() {
  echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5" | rofi_cmd
}

# Bulletproof Paths (Removed broken xrandr geometry)
time=$(date +%Y-%m-%d-%H-%M-%S)
filepath="${dir}/Screenshot_${time}.png"

if [[ ! -d "$dir" ]]; then
  mkdir -p "$dir"
fi

# notify and view screenshot asynchronously
notify_view() {
  notify_cmd_shot='dunstify -u low --replace=699'
  if [[ -e "$filepath" ]]; then
    ${notify_cmd_shot} "Copied to clipboard."
    ${notify_cmd_shot} "Screenshot Saved."
    # The '&' forces viewnior to background, stopping the script from hanging
    viewnior "$filepath" &
  else
    ${notify_cmd_shot} "Screenshot Failed."
  fi
}

# Copy screenshot to clipboard
copy_shot() {
  tee "$filepath" | xclip -selection clipboard -t image/png
}

# countdown
countdown() {
  for sec in $(seq $1 -1 1); do
    dunstify -t 1000 --replace=699 "Taking shot in : $sec"
    sleep 1
  done
}

# take shots (Refactored to avoid cd jumping)
shotnow() {
  sleep 0.5 && maim -u -f png | copy_shot
  notify_view
}

shot5() {
  countdown '5'
  sleep 1 && maim -u -f png | copy_shot
  notify_view
}

shot10() {
  countdown '10'
  sleep 1 && maim -u -f png | copy_shot
  notify_view
}

shotwin() {
  maim -u -f png -i $(xdotool getactivewindow) | copy_shot
  notify_view
}

shotarea() {
  maim -u -f png -s -b 2 -c 0.35,0.55,0.85,0.25 -l | copy_shot
  notify_view
}

# Execute Command
run_cmd() {
  if [[ "$1" == '--opt1' ]]; then
    shotnow
  elif [[ "$1" == '--opt2' ]]; then
    shotarea
  elif [[ "$1" == '--opt3' ]]; then
    shotwin
  elif [[ "$1" == '--opt4' ]]; then
    shot5
  elif [[ "$1" == '--opt5' ]]; then
    shot10
  fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
$option_1) run_cmd --opt1 ;;
$option_2) run_cmd --opt2 ;;
$option_3) run_cmd --opt3 ;;
$option_4) run_cmd --opt4 ;;
$option_5) run_cmd --opt5 ;;
esac
