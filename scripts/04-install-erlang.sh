#!/bin/bash

# Erlang/OTP Installation Script
# Builds and installs Erlang/OTP 27 from source with Rebar3

set -euo pipefail

# Get script directory and source utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/_utils.sh"

# Set script name for logging
SCRIPT_NAME="ERLANG"

log "Starting Erlang/OTP installation..."

# Build and install Erlang/OTP 27 from source (optimized for production)
log "Cloning and building Erlang/OTP 27..."
run_as_hb git clone --depth=1 --branch maint-27 https://github.com/erlang/otp.git /home/hb/otp-build
cd /home/hb/otp-build

log "Configuring Erlang build (without GUI components)..."
./configure --without-wx --without-debugger --without-observer --without-et

log "Building Erlang (this may take a while)..."
make -j$(nproc)

log "Installing Erlang..."
make install

log "Cleaning up Erlang build files..."
cd /home/hb
rm -rf /home/hb/otp-build

# Install Rebar3 (Erlang build tool)
log "Installing Rebar3..."
run_as_hb git clone --depth=1 https://github.com/erlang/rebar3.git /home/hb/rebar3-build
cd /home/hb/rebar3-build

log "Bootstrapping Rebar3..."
run_as_hb ./bootstrap

log "Installing Rebar3 to /usr/local/bin..."
mv /home/hb/rebar3-build/rebar3 /usr/local/bin/

cd /home/hb
rm -rf /home/hb/rebar3-build

# Install Rust for the hb user (required for some Elixir NIFs)
log "Installing Rust for hb user..."
run_as_hb bash -c 'curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain stable'

log "✓ Erlang/OTP and Rebar3 installation completed successfully!"
