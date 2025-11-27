#!/bin/bash
set -e

echo "=== START DEPLOYMENT ==="

SERVERS=(
    "localhost,$USER,22"
)

for server in "${SERVERS[@]}"; do
    IFS=',' read -r ip user port <<< "$server"
    echo "Deploying to $ip..."
    
    scp -P "$port" scripts/server-roles/base-setup.sh "${user}@${ip}:/tmp/"
    ssh -p "$port" "${user}@${ip}" "sudo bash /tmp/base-setup.sh"
done

echo "=== DEPLOYMENT COMPLETE ==="
