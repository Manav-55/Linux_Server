#!/bin/bash
# Check critical services and report their status

critical_services=("ssh" "nginx" "postgresql" "docker")

for service in "${critical_services[@]}"; do
    if systemctl is-active --quiet "$service"; then
        echo "✓ $service is running"
    else
        echo "✗ $service is not running"
        # Optionally restart the service
        # sudo systemctl start "$service"
    fi
done