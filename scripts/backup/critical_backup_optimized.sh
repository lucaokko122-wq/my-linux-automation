#!/bin/bash

set -e

BACKUP_DIR="/home/$USER/backups"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="system_backup_$DATE"

echo "starting optimizied backup system..."

mkdir -p $BACKUP_DIR/$BACKUP_NAME

#1 system critical configs (not .git)
echo "backing up system configs..."
sudo tar -czf $BACKUP_DIR/$BACKUP_NAME/etc_configs.tar.gz -C / etc/ 2>/dev/null|| true
#2 SSH Key and conf (crit)
echo "backing up SSH data.."
sudo tar -czf $BACKUP_DIR/$BACKUP_NAME/ssh_data.tar.gz -C ~/ .ssh/
#3 MYSQL database
echo "Backing up MySQL database..."
mkdir -p $BACKUP_DIR/$BACKUP_NAME/mysql
sudo mysqlpdump --all-databases > $BACKUP_DIR/$BACKUP_NAME/mysql/full_backup.sql 2>/dev/null || true
#4 rkhunter config and logs
echo "backing up rkhunter..."
sudo tar -czf $BACKUP_DIR/$BACKUP_NAME/rkhunter.tar.gz -C / etc/rkhunter.conf /var/log/rkhunter.log 2>/dev/null || true
#create restore script
#5 Nginx configs
echo "backing up nginx..."
sudo tar -czf $BACKUP_DIR/$BACKUP_NAME/nginx_configs.tar.gz -C / etc/nginx/
#6 sysytemd service 
echo "backing up systemd service..."
sudo tar -czf $BACKUP_DIR/$BACKUP_NAME/systemd_service.tar.gz -C / etc/systemd/system

#create restore script
cat > $BACKUP_DIR/$BACKUP_NAME/RESTORE_INSTRUCTION.md << EOF
#System Restore Instuction

To restore from this backup:
1. SSH Keys:
tar -xzf ssh_data.tar.gz -C /

2.MySQL:
mysql -u root -p < mysql/full_backup.sql

3. Nginx:
sudo tar -xzf nginx_configs.tar.gz -C /

4.Systemd:
sudo tar -xzf systemd_service.tar.gz -C /
sudo systemctl daemon-reload

5 Scripts from git:
git clone https://github.com/lucaokko122-wq

Backup created: $DATE
EOF

#Compress entire backup
tar -czf $BACKUP_DIR/$BACKUP_NAME.tar.gz -C $BACKUP_DIR $BACKUP_NAME/
rm -rf $BACKUP_DIR/$BACKUP_NAME

echo "Backup_completed: $BACKUP_DIR/$BACKUP_NAME.tar.gz"
echo "Size: $(du -h $BACKUP_DIR/$BACKUP_NAME.tar.gz | cut -f1)"

