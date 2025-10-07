# HyperBEAM Server Setup Scripts

This directory contains modular setup scripts for provisioning HyperBEAM development servers. These scripts are executed by `cloud-init` during server initialization.

## Directory Structure

```
cloud-init/
├── cloud-init.yaml          # Main cloud-init configuration
├── resources/               # Configuration files and templates
│   ├── nginx-default.conf   # Nginx reverse proxy configuration
│   └── hyperbeam.service    # Systemd service definition
└── scripts/                    # Executable setup scripts
    ├── bootstrap.sh             # Main orchestrator
    ├── 01-install-packages.sh   # Package installation
    ├── 02-deploy-configs.sh     # Configuration deployment
    ├── 03-setup-security.sh     # Security and firewall
    ├── 04-install-erlang.sh     # Erlang/OTP installation
    ├── 05-install-dev-tools.sh  # Development environment
    ├── 06-clone-repositories.sh # Repository cloning
    └── 07-setup-services.sh     # Service management
```

## Script Overview

### `bootstrap.sh` (Main Orchestrator)
- Coordinates the execution of all setup scripts in the correct order
- Provides logging and error handling
- Entry point called by cloud-init

### `01-install-packages.sh`
- Installs core system packages and development tools
- Adds package repositories (Neovim PPA, Node.js)
- Installs packages: git, neovim, nginx, build tools, etc.

### `02-deploy-configs.sh`
- Deploys nginx reverse proxy configuration from resources/
- Substitutes {{ HOSTNAME }} template variables with actual hostname
- Deploys HyperBEAM systemd service file from resources/
- Sets proper file permissions and ownership
- Reloads systemd to pick up service changes

### `03-setup-security.sh`
- Configures UFW firewall rules
- Sets up basic security hardening



### `04-install-erlang.sh`
- Builds and installs Erlang/OTP 27 from source
- Installs Rebar3 build tool
- Sets up Rust development environment

### `05-install-dev-tools.sh`
- Configures Neovim with LazyVim
- Installs Oh My Zsh with Powerlevel10k theme
- Sets up enhanced terminal environment

### `06-clone-repositories.sh`
- Clones HyperBEAM OS repository
- Clones HyperBEAM repository and checks out edge branch
- Sets proper ownership for hb user

### `07-setup-services.sh`
- Enables and starts system services (Nginx)
- Disables unnecessary services for security
- Performs system cleanup

## Execution Order

Scripts are executed in the following order by `bootstrap.sh`:

1. `01-install-packages.sh` - System packages first
2. `02-deploy-configs.sh` - Configuration file deployment
3. `03-setup-security.sh` - Security and firewall setup
4. `04-install-erlang.sh` - Language runtime installation
5. `05-install-dev-tools.sh` - Development environment
6. `06-clone-repositories.sh` - Repository cloning
7. `07-setup-services.sh` - Service management and cleanup

## Benefits of This Architecture

- **Modularity**: Each script has a single responsibility
- **Maintainability**: Easy to modify individual components
- **Version Control**: Scripts can be versioned and reviewed
- **Testing**: Individual scripts can be tested locally
- **Reusability**: Scripts can be used in other deployment contexts
- **Error Handling**: Better isolation and debugging of issues

## Usage

The scripts are automatically executed by cloud-init when the server is provisioned. For manual execution or testing:

```bash
# Run individual script
./01-install-packages.sh

# Run full bootstrap process
./bootstrap.sh
```

## Logging

All scripts log to `/var/log/hb-bootstrap.log` with timestamps and script identifiers for easy debugging.
