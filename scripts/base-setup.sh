#!/bin/bash
echo "=== BASIC SETUP ==="

apt-get update
apt-get upgrade -y

apt-get install -y curl wget git vim htop ufw

timedatectl set-timezone Europe/Moscow

echo "=== BASIC SETUP DONE ==="
