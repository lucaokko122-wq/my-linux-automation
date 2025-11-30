# Руководство админа

Скачай проект: git clone https://github.com/lucaokko122-wq/my-linux-automation.git
Заходи в папку: cd my-linux-automation
Настрой серверы в файле infrastructure/servers.list - просто напиши IP адреса своих серверов
Запусти главный скрипт: ./scripts/master-deploy.sh all
Жди пока все установится
Проверь в браузере: http://твой-ip-сервера

Ежедневно запускай:
./scripts/monitoring/health-check.sh - проверка состояния
./scripts/backups/daily-backup.sh - бэкапы
./scripts/security/daily-scan.sh - проверка безопасности

Если сломалось:
Сайт не грузится - ./scripts/emergency/restart-nginx.sh
Сервер не отвечает - ./scripts/emergency/reboot-server.sh
Все плохо - ./scripts/backups/disaster-recovery.sh

Логи смотри тут:
/var/log/automation/deploy.log - установка
/var/log/automation/backup.log - бэкапы
/var/log/nginx/access.log - сайт
