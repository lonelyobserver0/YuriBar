#!/bin/bash

# Calcolo CPU
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')

# RAM
ram_total=$(free -h | awk '/Mem:/ {print $2}')
ram_used=$(free -h | awk '/Mem:/ {print $3}')
ram_percent=$(free | awk '/Mem:/ {printf("%.0f", $3/$2 * 100)}')

# Disco
disk_total=$(df -h / | awk 'NR==2 {print $2}')
disk_used=$(df -h / | awk 'NR==2 {print $3}')
disk_percent=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')

# Output JSON
echo "{
  \"cpu_usage\": \"$cpu_usage\",
  \"ram_total\": \"$ram_total\",
  \"ram_used\": \"$ram_used\",
  \"ram_percent\": \"$ram_percent\",
  \"disk_total\": \"$disk_total\",
  \"disk_used\": \"$disk_used\",
  \"disk_percent\": \"$disk_percent\"
}"
