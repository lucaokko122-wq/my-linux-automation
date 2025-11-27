#!/bin/bash
echo "=== WEB SERVER SETUP ==="

apt-get install -y nginx

systemctl enable nginx
systemctl start nginx

mkdir -p /var/www/html
echo "<h1>Web Server Works! $(hostname)</h1>" > /var/www/html/index.html

echo "=== WEB SERVER DONE ==="
