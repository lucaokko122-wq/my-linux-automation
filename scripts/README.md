 Запуск развертывания
bash
# Полное развертывание
./scripts/master-deploy.sh all

# Или поэтапно
./scripts/master-deploy.sh vpn
./scripts/master-deploy.sh monitoring
./scripts/master-deploy.sh backup
