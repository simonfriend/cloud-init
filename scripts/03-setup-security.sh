#!/bin/bash

# Security & Firewall Configuration Script
# Configures UFW firewall and project setup

set -euo pipefail

# Get script directory and source utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/_utils.sh"

# Set script name for logging
SCRIPT_NAME="SECURITY"

log "Starting security configuration..."

# Configure UFW firewall with required ports
log "Configuring UFW firewall..."
ufw --force reset
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow 21/tcp    # FTP (if needed)
ufw allow 80/tcp    # HTTP (for Let's Encrypt challenges)
ufw allow 443/tcp   # HTTPS
ufw allow 3001/tcp  # Agent
ufw --force enable

log "✓ Security configuration completed successfully!"
