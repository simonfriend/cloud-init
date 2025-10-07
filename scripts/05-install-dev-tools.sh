#!/bin/bash

# Development Tools Installation Script
# Deploys pre-configured dotfiles for development environment

set -euo pipefail

# Get script directory and source utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/_utils.sh"

# Set script name for logging
SCRIPT_NAME="DEVTOOLS"

# Resources directory
RESOURCES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../resources" && pwd)"

log "Starting development tools installation..."

# Deploy pre-configured dotfiles
log "Deploying pre-configured dotfiles for hb user..."

# Backup existing configs and copy new ones
run_as_hb bash -c "
    # Backup existing configs
    mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null || true
    mv ~/.oh-my-zsh ~/.oh-my-zsh.bak 2>/dev/null || true
    mv ~/.zshrc ~/.zshrc.bak 2>/dev/null || true
    mv ~/.p10k.zsh ~/.p10k.zsh.bak 2>/dev/null || true
    
    # Copy pre-configured files
    cp -r '$RESOURCES_DIR/dotfiles/.config' ~/
    cp -r '$RESOURCES_DIR/dotfiles/.oh-my-zsh' ~/
    cp '$RESOURCES_DIR/dotfiles/.zshrc' ~/
    cp '$RESOURCES_DIR/dotfiles/.p10k.zsh' ~/ 2>/dev/null || true
    
    # Set proper permissions
    chmod -R 755 ~/.config ~/.oh-my-zsh
    chmod 644 ~/.zshrc ~/.p10k.zsh 2>/dev/null || true
"

# Set zsh as the default shell for hb user
log "Setting zsh as default shell for hb user..."
chsh -s /usr/bin/zsh hb

log "✓ Development tools installation completed successfully!"
