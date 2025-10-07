#!/bin/bash

# Package Installation Script
# Installs core system packages and development tools

set -euo pipefail

# Get script directory and source utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/_utils.sh"

# Set script name for logging
SCRIPT_NAME="PACKAGES"

log "Starting package installation..."

# Add Neovim unstable PPA for latest version
log "Adding Neovim PPA..."
add-apt-repository -y ppa:neovim-ppa/unstable

# Update package lists
log "Updating package lists..."
apt-get update -y

# Install core system packages and development tools
log "Installing core packages..."
apt-get install -y \
    git neovim nginx zsh ufw certbot python3-pip awscli \
    software-properties-common fzf ripgrep fd-find cmake \
    pkg-config ncurses-dev libssl-dev ca-certificates \
    sshpass bat build-essential

# Install Certbot DNS plugin for Let's Encrypt automation
log "Installing Certbot DNS plugin..."
pip3 install certbot-dns-route53

# Install Node.js 22.x (for frontend tooling)
log "Installing Node.js 22.x..."
curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
apt-get install -y nodejs=22.16.0-1nodesource1

log "✓ Package installation completed successfully!"
