#!/usr/bin/env bash

# macOS
# Define color codes for memory usage levels in tmux status bar
COLOR_MEM_LOW="#[fg=#00ff00, bg=default]"
COLOR_MEM_MODERATE="#[fg=#ffff00, bg=default]"
COLOR_MEM_HIGH="#[fg=#ff0000, bg=default]"

# Calculate memory usage percentage on macOS
mem_total=$(sysctl -n hw.memsize) # Total memory in bytes
vm_stat_output=$(vm_stat)
pages_free=$(echo "$vm_stat_output" | awk '/Pages free/ {print $3}' | tr -d '.')
pages_active=$(echo "$vm_stat_output" | awk '/Pages active/ {print $3}' | tr -d '.')
pages_inactive=$(echo "$vm_stat_output" | awk '/Pages inactive/ {print $3}' | tr -d '.')
pages_speculative=$(echo "$vm_stat_output" | awk '/Pages speculative/ {print $3}' | tr -d '.')
pages_wired=$(echo "$vm_stat_output" | awk '/Pages wired/ {print $4}' | tr -d '.')

# Calculate used memory in bytes
page_size=$(pagesize)
mem_used=$(((pages_active + pages_inactive + pages_speculative + pages_wired) * page_size))

# Calculate memory usage percentage
mem_usage=$((mem_used * 100 / mem_total))

# Display memory usage with color coding based on thresholds
if ((mem_usage >= 80)); then
  echo "${COLOR_MEM_HIGH} ${mem_usage}%"
elif ((mem_usage >= 60)); then
  echo "${COLOR_MEM_MODERATE} ${mem_usage}%"
elif ((mem_usage >= 40)); then
  echo "${COLOR_MEM_MODERATE} ${mem_usage}%"
elif ((mem_usage >= 20)); then
  echo "${COLOR_MEM_LOW} ${mem_usage}%"
else
  echo "${COLOR_MEM_LOW} ${mem_usage}%"
fi

# Gentoo Linux
# Define color codes for memory usage levels in tmux status bar
# COLOR_MEM_LOW="#[fg=#00ff00, bg=default]"
# COLOR_MEM_MODERATE="#[fg=#ffff00, bg=default]"
# COLOR_MEM_HIGH="#[fg=#ff0000, bg=default]"

# # Calculate memory usage percentage
# mem_usage=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')

# # Display memory usage with color coding based on thresholds
# if ((mem_usage >= 80)); then
#   echo "${COLOR_MEM_HIGH} ${mem_usage}%"
# elif ((mem_usage >= 60)); then
#   echo "${COLOR_MEM_MODERATE} ${mem_usage}%"
# elif ((mem_usage >= 40)); then
#   echo "${COLOR_MEM_MODERATE} ${mem_usage}%"
# elif ((mem_usage >= 20)); then
#   echo "${COLOR_MEM_LOW} ${mem_usage}%"
# else
#   echo "${COLOR_MEM_LOW} ${mem_usage}%"
# fi
