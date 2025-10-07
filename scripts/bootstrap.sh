#!/bin/bash

# HyperBEAM Server Bootstrap Script
# Main orchestrator that runs all setup scripts in the correct order

set -euo pipefail

# Get script directory and source utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/_utils.sh"

# Set script name for logging
SCRIPT_NAME="BOOTSTRAP"

log "Starting HyperBEAM server bootstrap process..."

# Define the execution order
SCRIPTS=(
    "01-install-packages.sh"
    "02-deploy-configs.sh"
    "03-setup-security.sh"
    "04-install-erlang.sh"
    "05-install-dev-tools.sh"
    "06-clone-repositories.sh"
    "07-setup-services.sh"
)

# Execute each script in order
for script in "${SCRIPTS[@]}"; do
    script_path="$SCRIPT_DIR/$script"
    
    if [[ -f "$script_path" ]]; then
        log "Executing: $script"
        chmod +x "$script_path"
        
        if bash "$script_path"; then
            log "✓ Successfully completed: $script"
        else
            log "✗ Failed to execute: $script"
            exit 1
        fi
    else
        log "✗ Script not found: $script_path"
        exit 1
    fi
done

log "✓ HyperBEAM server bootstrap completed successfully!"
