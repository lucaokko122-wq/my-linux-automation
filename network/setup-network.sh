#!/bin/bash

# Setup DNSMasq
echo "Setting up DNSMasq..."
cp dnsmasq.conf /etc/dnsmasq.conf
systemctl enable dnsmasq
systemctl start dnsmasq

# Setup HAProxy
echo "Setting up HAProxy..."
cp haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg
systemctl enable haproxy
systemctl start haproxy

# Setup WireGuard
echo "Setting up WireGuard..."
cp wireguard/wg0.conf /etc/wireguard/
chmod 600 /etc/wireguard/wg0.conf
systemctl enable wg-quick@wg0
systemctl start wg-quick@wg0

echo "Network services configured!"
