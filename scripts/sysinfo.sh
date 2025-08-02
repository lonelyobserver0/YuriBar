#!/bin/bash
set -euo pipefail

# Redirect stderr of commands to /dev/null to prevent non-JSON output
cpu_usage=$(top -bn1 2>/dev/null | grep "Cpu(s)" 2>/dev/null | awk '{print 100 - $8}' | LC_ALL=C awk '{printf "%.1f", $1}')
read ram_total ram_used <<<$(free -h 2>/dev/null | awk '/Mem:/ {print $2, $3}')
ram_percent=$(free 2>/dev/null | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')
read disk_total disk_used disk_percent <<<$(df -h / 2>/dev/null | awk 'NR==2 {print $2, $3, $5}' | tr -d '%')

# Use a standard HERE_DOC_DELIMITER (e.g., JSON_END)
# The line immediately after the `cat <<JSON_END` MUST start with your JSON.
# There should be NO leading spaces on the line with JSON_END.
cat <<JSON_END
{"text": "", "tooltip": " CPU: ${cpu_usage}%\\n RAM: ${ram_used} / ${ram_total} (${ram_percent}%)\\n󰋊 Disk: ${disk_used} / ${disk_total} (${disk_percent}%)"}
JSON_END
