#!/bin/bash

# Shared utility functions for HyperBEAM bootstrap scripts
# This file should be sourced by bootstrap scripts

# Logging function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] ${SCRIPT_NAME:-BOOTSTRAP}: $*" | tee -a /var/log/hb-bootstrap.log
}

# Function to run commands as hb user
run_as_hb() {
    sudo -u hb "$@"
}
