#!/bin/bash
# Генератор конфигов из шаблонов

echo "=== Генерация конфигураций ==="

# Запрашиваем данные
read -p "Страна (например RU): " COUNTRY
read -p "Организация: " ORGANIZATION
read -p "Домен сервера: " DOMAIN
read -p "Сеть VPN (например 10.8.0.0): " VPN_NETWORK

# Генерируем сертификаты
sed "s/{{COUNTRY}}/$COUNTRY/g; s/{{ORGANIZATION}}/$ORGANIZATION/g" \
    certificates/template-ca.cnf > certificates/ca.cnf
    
sed "s/{{SERVER_NAME}}/$DOMAIN/g" \
    configs/vpn/server-template.conf > configs/vpn/server.conf

echo "Конфиги сгенерированы в:"
echo "- certificates/ca.cnf"
echo "- configs/vpn/server.conf"
