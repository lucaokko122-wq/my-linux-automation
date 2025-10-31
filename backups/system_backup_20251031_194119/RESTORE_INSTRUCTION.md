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

Backup created: 20251031_194119
