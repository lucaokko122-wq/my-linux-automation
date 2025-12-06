#!/bin/bash
# Развертывание системы бэкапов

set -e

echo "Развертывание системы бэкапов..."

# Установка BorgBackup
echo "Установка BorgBackup..."
sudo apt update
sudo apt install -y borgbackup

# Создание папок
echo "Создание структуры папок..."
sudo mkdir -p /backup/repository
sudo mkdir -p /etc/backup

# Настройка конфига
echo "Настройка конфигурации..."
if [ -f configs/backup/config.yml ]; then
    sudo cp configs/backup/config.yml /etc/backup/config.yml
else
    echo "Конфиг не найден, создаем стандартный..."
    cat > /etc/backup/config.yml << EOF
backup:
  source_dirs:
    - /etc
    - /home
    - /var/www
  repository: /backup/repository
  retention:
    daily: 7
    weekly: 4
    monthly: 12
EOF
fi

# Создание скрипта бэкапа
echo "Создание скрипта бэкапа..."
sudo cp scripts/backup/backup.sh /usr/local/bin/backup.sh
sudo chmod +x /usr/local/bin/backup.sh

# Настройка cron
echo "Настройка автоматических бэкапов..."
echo "0 2 * * * root /usr/local/bin/backup.sh daily" | sudo tee /etc/cron.d/backup

echo "Система бэкапов развернута!"
echo "Бэкапы запускаются ежедневно в 2:00"
