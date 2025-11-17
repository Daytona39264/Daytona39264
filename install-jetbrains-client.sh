#!/bin/bash

# JetBrains Gateway Installation Script for Linux
# This script downloads and installs JetBrains Gateway
# for remote development with JetBrains IDEs

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
INSTALL_DIR="${HOME}/.local/share/JetBrains"
BIN_DIR="${HOME}/.local/bin"
DOWNLOAD_URL="https://download.jetbrains.com/idea/gateway/JetBrainsGateway-2025.2.4.tar.gz"
TEMP_DIR=$(mktemp -d)

# Functions
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log_step() {
    echo -e "${BLUE}[STEP]${NC} $1"
}

cleanup() {
    log_info "Cleaning up temporary files..."
    rm -rf "$TEMP_DIR"
}

trap cleanup EXIT

check_dependencies() { # Added check_dependencies function
    log_info "Checking dependencies..."

    local missing_deps=()

    for cmd in wget tar; do
        if ! command -v "$cmd" &> /dev/null; then
            missing_deps+=("$cmd")
        fi
    done

    if [ ${#missing_deps[@]} -ne 0 ]; then
        log_error "Missing dependencies: ${missing_deps[*]}"
        log_info "Please install them using your package manager:"
        log_info "  Ubuntu/Debian: sudo apt-get install ${missing_deps[*]}"
        log_info "  Fedora/RHEL: sudo dnf install ${missing_deps[*]}"
        log_info "  Arch: sudo pacman -S ${missing_deps[*]}"
        exit 1
    fi

    log_info "All dependencies satisfied"
}

check_disk_space() { # Added check_disk_space function
    log_info "Checking available disk space..."

    # shellcheck disable=SC2155
    local available_kb=$(df -k "$HOME" | awk 'NR==2 {print $4}')
    local required_kb=$((500 * 1024)) # 500 MB

    if [ "$available_kb" -lt "$required_kb" ]; then
        log_error "Insufficient disk space. Required: 500 MB, Available: $((available_kb / 1024)) MB"
        exit 1
    fi

    log_info "Disk space check passed"
}

download_gateway() { # Added download_gateway function
    log_info "Downloading JetBrains Gateway..."

    cd "$TEMP_DIR"

    if wget -O jetbrains-gateway.tar.gz "$DOWNLOAD_URL"; then
        log_info "Download completed successfully"
    else
        log_error "Failed to download JetBrains Gateway"
        log_info "You can manually download from: https://www.jetbrains.com/remote-development/gateway/"
        exit 1
    fi
}

install_gateway() { # Added install_gateway function
    log_info "Installing JetBrains Gateway..."

    # Create installation directory
    mkdir -p "$INSTALL_DIR"
    mkdir -p "$BIN_DIR"

    # Extract the archive
    log_info "Extracting archive..."
    tar -xzf "$TEMP_DIR/jetbrains-gateway.tar.gz" -C "$INSTALL_DIR"

    # Find the extracted directory (it might have a version number)
    CLIENT_DIR=$(find "$INSTALL_DIR" -maxdepth 1 -type d -name "JetBrainsGateway*" | head -n 1)

    if [ -z "$CLIENT_DIR" ]; then
        log_error "Could not find extracted Gateway directory"
        exit 1
    fi

    # Create symlink in bin directory
    log_info "Creating symbolic link..."
    ln -sf "$CLIENT_DIR/bin/gateway.sh" "$BIN_DIR/jetbrains-gateway"

    log_info "Installation completed to: $CLIENT_DIR"
}

update_path() { # Added update_path function
    log_info "Checking PATH configuration..."

    if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
        log_warn "$BIN_DIR is not in your PATH"

        # Detect shell and provide instructions
        if [ -n "$BASH_VERSION" ]; then
            log_info "Add the following line to your ~/.bashrc:"
            echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
        elif [ -n "$ZSH_VERSION" ]; then
            log_info "Add the following line to your ~/.zshrc:"
            echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
        else
            log_info "Add $BIN_DIR to your PATH in your shell configuration file"
        fi
    else
        log_info "PATH is already configured correctly"
    fi
}

verify_installation() { # Added verify_installation function
    log_info "Verifying installation..."

    if [ -f "$BIN_DIR/jetbrains-gateway" ]; then
        log_info "JetBrains Gateway installed successfully!"
        log_info "Location: $BIN_DIR/jetbrains-gateway"

        # Try to run it to check version
        if "$BIN_DIR/jetbrains-gateway" --help &>/dev/null; then
            log_info "Gateway is executable and ready to use"
        else
            log_warn "Gateway binary found but may need additional configuration"
        fi
    else
        log_error "Installation verification failed"
        exit 1
    fi
}

print_usage_info() { # Added print_usage_info function
    cat << EOF

${GREEN}=== JetBrains Gateway Installation Complete ===${NC}

To use JetBrains Gateway:
  1. Run: jetbrains-gateway
  2. Or use the full path: $BIN_DIR/jetbrains-gateway

For remote development:
  - Launch Gateway and connect to your remote workspace
  - Choose your preferred IDE (IntelliJ IDEA, PyCharm, WebStorm, etc.)
  - Gateway will download the necessary IDE backend

Documentation:
  - JetBrains Gateway: https://www.jetbrains.com/remote-development/gateway/
  - Remote Development: https://www.jetbrains.com/remote-development/

EOF
}

# Main installation flow
main() {
    log_info "Starting JetBrains Gateway installation..."

    check_dependencies
    check_disk_space
    download_gateway
    install_gateway
    update_path
    verify_installation
    print_usage_info

    log_info "Installation script completed successfully!"
}

# Run main function
main
