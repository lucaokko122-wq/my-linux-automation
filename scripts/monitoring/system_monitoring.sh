#!/bin/bash
#system_monitoring.sh

LOG_FILE="/home/$USER/monitoring/system_health_$(date +%Y%m%d).log"

mkdir -p  /home/$USER/moitoring
echo "=== System start monitoring $(date) ===" | tee -a $LOG_FILE

#1 Disk space
echo "Disk Usage:" | tee -a $LOG_FILE
df -h | grep -v tmpfs | tee -a $LOG_FILE

#2 Memory
echo -e "\nMemory Usage: " | tee -a $LOG_FILE
free -h | tee -a $LOG_FILE


#3 Services
echo -e "\nCritical Service Status:" | tee -a $LOG_FILE
services=("MySQL", "Nginx", "ssh")
for service in "${services[@]}"; do
	status=$(systemctl is-active $service 2>/dev/null || echo "not-found")
	echo "$service: $status" | tee -a $LOG_FILE
done

#4 Network
echo -e "\nNerwork Connection Status: " | tee -a $LOG_FILE
netstat -tunlp | grep -E "(LISTEN)" | tee -a $LOG_FILE

echo -e "\n===Check Completed===" | tee -a $LOG_FILE
