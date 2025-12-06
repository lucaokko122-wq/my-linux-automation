#!/bin/bash
# Развертывание VPN сервера

set -e

echo "🚀 Начало развертывания VPN..."

# Проверяем конфиг
if [ ! -f config.yml ]; then
    echo "❌ Файл config.yml не найден"
    echo "Скопируйте пример: cp config-example.yml config.yml"
    exit 1
fi

# Установка OpenVPN
echo "Установка OpenVPN..."
sudo apt update
sudo apt install -y openvpn easy-rsa

# Генерация сертификатов
echo "Генерация сертификатов..."
cd /etc/openvpn
sudo make-cadir easy-rsa
cd easy-rsa

# Настройка VPN
echo "Настройка конфигурации..."
sudo cp /usr/share/doc/openvpn/examples/sample-config-files/server.conf /etc/openvpn/server.conf

# Запуск сервиса
echo "Запуск VPN сервера..."
sudo systemctl enable openvpn@server
sudo systemctl start openvpn@server

echo "VPN сервер развернут!"
echo "Инструкция для клиентов в /etc/openvpn/client/"
