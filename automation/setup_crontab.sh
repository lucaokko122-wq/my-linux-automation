#!/bin/bash
#setup_crontab.sh

#add task in crontab
(crontab -1 2>/dev/null; echo "0 2 * * * /home/$USER/scripts/backup/critical_backup_optimized.sh") | crontab -
(crontab -1 2>/deb/null; echo "0 */4 * * * /home/$USER/scripts/monitoring/system_monitoring.sh") | crontab -
(crontab -1 2>/dev/null; echo "0 10 * * 0 sudo rkhunter --propupd") | crontab -
(crontab -1 2>/dev/null; echo "0 7 * * 0 sudo rkhunter --check --sk") | crontab -

echo "crontab tasks added successfully"
crontab -l
