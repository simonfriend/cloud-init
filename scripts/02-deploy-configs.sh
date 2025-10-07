#!/bin/bash

# Configuration Files Deployment Script
# Deploys nginx and systemd configuration files

set -euo pipefail

# Get script directory and source utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/_utils.sh"

# Set script name for logging
SCRIPT_NAME="CONFIGS"

# Resources directory
RESOURCES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../resources" && pwd)"

log "Starting configuration files deployment..."

# Deploy Nginx configuration
log "Deploying Nginx reverse proxy configuration..."
cp "$RESOURCES_DIR/nginx-default.conf" /etc/nginx/sites-available/default
chown root:root /etc/nginx/sites-available/default
chmod 644 /etc/nginx/sites-available/default

# Deploy HyperBEAM systemd service
log "Deploying HyperBEAM systemd service configuration..."
cp "$RESOURCES_DIR/hyperbeam.service" /etc/systemd/system/hyperbeam.service
chown root:root /etc/systemd/system/hyperbeam.service
chmod 644 /etc/systemd/system/hyperbeam.service

# Reload systemd to pick up new service
log "Reloading systemd daemon..."
systemctl daemon-reload

log "✓ Configuration files deployment completed successfully!"
