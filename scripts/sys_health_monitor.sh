#!/bin/bash

CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=80

# Check CPU Usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
echo "CPU Usage: $CPU_USAGE%"

if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) )); then
    echo "CPU usage is above threshold!" >> /var/log/sys_health.log
fi

# Check Memory Usage
MEMORY_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
echo "Memory Usage: $MEMORY_USAGE%"

if (( $(echo "$MEMORY_USAGE > $MEMORY_THRESHOLD" | bc -l) )); then
    echo "Memory usage is above threshold!" >> /var/log/sys_health.log
fi

# Check Disk Usage
DISK_USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')
echo "Disk Usage: $DISK_USAGE%"

if [ $DISK_USAGE -gt $DISK_THRESHOLD ]; then
    echo "Disk usage is above threshold!" >> /var/log/sys_health.log
fi

# Check Running Processes
echo "Running Processes:" >> /var/log/sys_health.log
ps aux >> /var/log/sys_health.log
