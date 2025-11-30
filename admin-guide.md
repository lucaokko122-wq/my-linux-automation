# Руководство Администратора

## 🎯 Быстрый старт

### Предварительные требования
- Linux сервер (Ubuntu 20.04+/CentOS 7+)
- Доступ по SSH с правами sudo
- Python 3.6+ (для Ansible)
- Docker (опционально)

### 1. Клонирование проекта
```bash
git clone https://github.com/lucaokko122-wq/my-linux-automation.git
cd my-linux-automation

Запуск автоматизации
```bash
# Полное развертывание
./scripts/master-deploy.sh all

# Или поэтапно
./scripts/master-deploy.sh base      # Базовая настройка
./scripts/master-deploy.sh web       # Веб-серверы
./scripts/master-deploy.sh security  # Безопасность
./scripts/master-deploy.sh monitoring # Мониторинг

# Ежедневные операци
Мониторинг состояния
```bash
./scripts/monitoring/health-check.sh
./scripts/monitoring/metrics-collector.sh

Резервное копирование
```bash
# Ежедневные бэкапы
./scripts/backups/daily-backup.sh

# Восстановление
./scripts/backups/restore-backup.sh [backup-file]

Обновления безопасности
```bash
./scripts/security/auto-update.sh
./scripts/security/vulnerability-scan.sh

