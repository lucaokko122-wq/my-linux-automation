#!/bin/bash
# Полное развертывание всей инфраструктуры

echo "Полное развертывание инфраструктуры..."

# Проверка зависимостей
./scripts/check-dependencies.sh

# Развертывание компонентов
./scripts/deploy-vpn.sh
./scripts/deploy-monitoring.sh  
./scripts/deploy-backup.sh

echo "Вся инфраструктура развернута!"
echo ""
echo "Что было установлено:"
echo "VPN сервер - доступ по OpenVPN"
echo "Мониторинг - Prometheus + Grafana"
echo "Бэкапы - BorgBackup с авторасписанием"
echo ""
echo "Для проверки запустите: ./scripts/verify-deployment.sh"
