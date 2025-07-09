#!/bin/bash

# ANSI color code table generator in Bash

# Define foreground and background codes
fgs=(
  "39"
  "30" "1;30"
  "31" "1;31"
  "32" "1;32"
  "33" "1;33"
  "34" "1;34"
  "35" "1;35"
  "36" "1;36"
  "37" "1;37"
)
bgs=(
  "49" "40" "100" "47" "41" "42" "43" "44" "45" "46"
)
text=" *** "

# Print header row
printf "%4s │ " ""
for bg in "${bgs[@]}"; do
  printf " %3s  " "$bg"
done
printf "\n"

# Print separator line
printf "%s" "─────┼"
for ((i = 0; i < 60; i++)); do
  printf "%s" "─"
done
printf "\n"

# Print color combinations
for fg in "${fgs[@]}"; do
  # Left column (foreground codes)
  printf "%4s │ " "$fg"

  # Color combinations
  for bg in "${bgs[@]}"; do
    printf "\x1b[%sm\x1b[%sm%s\x1b[0m " "$bg" "$fg" "$text"
  done
  printf "\n"
done
