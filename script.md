# Скрипты

scripts/master-deploy.sh - главный скрипт, запускает всё остальное
scripts/server-roles/base-setup.sh - ставит базовые пакеты и настройки
scripts/server-roles/web-server.sh - ставит nginx и php
scripts/security/firewall-setup.sh - настраивает фаервол
scripts/backups/daily-backup.sh - делает бэкапы
scripts/monitoring/health-check.sh - проверяет состояние сервера
scripts/emergency/restart-nginx.sh - перезапускает веб-сервер

Все скрипты запускаются из главного, вручную не трогать.
Если нужно добавить свой скрипт - кидай в scripts/custom/
