#!/bin/bash

# Service Management Script
# Configures and starts system services, performs cleanup

set -euo pipefail

# Get script directory and source utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/_utils.sh"

# Set script name for logging
SCRIPT_NAME="SERVICES"

log "Starting service management..."

# Enable and start Nginx
# log "Enabling and starting Nginx service..."
# systemctl enable nginx
# systemctl start nginx

# Disable unnecessary services for security
log "Disabling unnecessary services..."
systemctl disable vsftpd 2>/dev/null || true
systemctl stop vsftpd 2>/dev/null || true

# Clean up package cache
log "Cleaning up package cache..."
apt-get autoremove -y
apt-get autoclean

log "✓ Service management completed successfully!"
