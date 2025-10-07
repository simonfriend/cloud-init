#!/bin/bash

# Repository Cloning Script
# Clones HyperBEAM related repositories

set -euo pipefail

# Get script directory and source utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/_utils.sh"

# Set script name for logging
SCRIPT_NAME="REPOS"

log "Starting repository cloning..."

# Clone HyperBEAM OS repository
log "Cloning HyperBEAM OS repository..."
run_as_hb git clone https://github.com/permaweb/hb-os /home/hb/hb-os

# Clone HyperBEAM and checkout edge
log "Cloning HyperBEAM repository..."
run_as_hb git clone https://github.com/permaweb/hyperbeam.git /home/hb/hyperbeam
run_as_hb bash -c "cd /home/hb/hyperbeam && git checkout edge"

# Clone SNPhost https://github.com/virtee/snphost.git
log "Cloning SNPhost repository..."
run_as_hb git clone https://github.com/virtee/snphost.git /home/hb/snphost
run_as_hb bash -c "cd /home/hb/snphost && source ~/.cargo/env && cargo build --release"
cp /home/hb/snphost/target/release/snphost /usr/local/bin/snphost

log "✓ Repository cloning completed successfully!"
