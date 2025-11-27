#!/bin/bash
echo "=== FIREWALL SETUP ==="

apt-get install -y ufw

ufw default deny incoming
ufw default allow outgoing
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp

#ufw вкл вручную
echo "=== FIREWALL READY ==="
echo "Run manually: ufw enable"
