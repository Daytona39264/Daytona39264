#!/bin/bash

# JetBrains Toolbox Installation Script for Linux
# This script downloads and installs JetBrains Toolbox App
# which provides centralized management for all JetBrains IDEs and tools

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
INSTALL_DIR="${HOME}/.local/share/JetBrains/Toolbox"
BIN_DIR="${HOME}/.local/bin"
DOWNLOAD_URL="https://download.jetbrains.com/toolbox/jetbrains-toolbox-latest.tar.gz"
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

print_banner() {
    cat << "EOF"
    ____       __  ____            _
   / __/___   / /_/ __ )___  _____(_)___  _____
  / /_ / _ \ / __/ __  / __ \/ ___/ / __ \/ ___/
 / __//  __// /_/ /_/ / /_/ / /  / / / / (__  )
/_/   \___/ \__/_____/ .___/_/  /_/_/ /_/____/
                    /_/
   ______            ____
  /_  __/___  ____  / / /_  ____  _  __
   / / / __ \/ __ \/ / __ \/ __ \| |/_/
  / / / /_/ / /_/ / / /_/ / /_/ />  <
 /_/  \____/\____/_/_.___/\____/_/|_|

EOF
    echo -e "${BLUE}JetBrains Toolbox Installer${NC}"
    echo ""
}

check_dependencies() {
    log_step "Checking dependencies..."

    local missing_deps=()

    for cmd in wget tar; do
        if ! command -v "$cmd" &> /dev/null; then
            missing_deps+=("$cmd")
        fi
    done

    # Check for display server (X11 or Wayland)
    if [ -z "$DISPLAY" ] && [ -z "$WAYLAND_DISPLAY" ]; then
        log_warn "No display server detected. Toolbox requires a GUI environment."
        log_warn "You may need to run this in a desktop environment."
    fi

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

check_disk_space() {
    log_step "Checking available disk space..."

    local available_kb=$(df -k "$HOME" | awk 'NR==2 {print $4}')
    local required_kb=$((500 * 1024)) # 500 MB

    if [ "$available_kb" -lt "$required_kb" ]; then
        log_error "Insufficient disk space. Required: 500 MB, Available: $((available_kb / 1024)) MB"
        exit 1
    fi

    log_info "Disk space check passed ($((available_kb / 1024)) MB available)"
}

check_existing_installation() {
    log_step "Checking for existing installations..."

    if [ -d "$INSTALL_DIR" ]; then
        log_warn "JetBrains Toolbox directory already exists at: $INSTALL_DIR"
        read -p "Do you want to continue? This will update/reinstall Toolbox (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            log_info "Installation cancelled by user"
            exit 0
        fi
    else
        log_info "No existing installation found"
    fi
}

download_toolbox() {
    log_step "Downloading JetBrains Toolbox..."

    cd "$TEMP_DIR"

    if wget -O jetbrains-toolbox.tar.gz "$DOWNLOAD_URL" 2>&1 | grep -v "saving"; then
        log_info "Download completed successfully"
    else
        log_error "Failed to download JetBrains Toolbox"
        log_info "You can manually download from: https://www.jetbrains.com/toolbox-app/"
        exit 1
    fi
}

install_toolbox() {
    log_step "Installing JetBrains Toolbox..."

    # Create installation directory
    mkdir -p "$INSTALL_DIR"
    mkdir -p "$BIN_DIR"

    # Extract the archive
    log_info "Extracting archive..."
    tar -xzf "$TEMP_DIR/jetbrains-toolbox.tar.gz" -C "$TEMP_DIR"

    # Find the extracted directory
    EXTRACTED_DIR=$(find "$TEMP_DIR" -maxdepth 1 -type d -name "jetbrains-toolbox-*" | head -n 1)

    if [ -z "$EXTRACTED_DIR" ]; then
        log_error "Could not find extracted Toolbox directory"
        exit 1
    fi

    # Find the binary
    TOOLBOX_BIN=$(find "$EXTRACTED_DIR" -type f -name "jetbrains-toolbox" | head -n 1)

    if [ -z "$TOOLBOX_BIN" ]; then
        log_error "Could not find Toolbox binary"
        exit 1
    fi

    # Make it executable
    chmod +x "$TOOLBOX_BIN"

    # Copy to installation directory
    cp "$TOOLBOX_BIN" "$INSTALL_DIR/jetbrains-toolbox"

    log_info "Toolbox binary installed to: $INSTALL_DIR/jetbrains-toolbox"

    # Create symlink in bin directory
    log_info "Creating symbolic link..."
    ln -sf "$INSTALL_DIR/jetbrains-toolbox" "$BIN_DIR/jetbrains-toolbox"
}

create_desktop_entry() {
    log_step "Creating desktop entry..."

    local desktop_dir="${HOME}/.local/share/applications"
    mkdir -p "$desktop_dir"

    cat > "$desktop_dir/jetbrains-toolbox.desktop" << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=JetBrains Toolbox
Icon=jetbrains-toolbox
Exec=$INSTALL_DIR/jetbrains-toolbox
Comment=JetBrains Toolbox App
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-toolbox
StartupNotify=true
EOF

    log_info "Desktop entry created"
}

update_path() {
    log_step "Checking PATH configuration..."

    if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
        log_warn "$BIN_DIR is not in your PATH"

        # Detect shell and provide instructions
        if [ -n "$BASH_VERSION" ]; then
            log_info "Add the following line to your ~/.bashrc:"
            echo -e "  ${YELLOW}export PATH=\"\$HOME/.local/bin:\$PATH\"${NC}"
        elif [ -n "$ZSH_VERSION" ]; then
            log_info "Add the following line to your ~/.zshrc:"
            echo -e "  ${YELLOW}export PATH=\"\$HOME/.local/bin:\$PATH\"${NC}"
        else
            log_info "Add $BIN_DIR to your PATH in your shell configuration file"
        fi
    else
        log_info "PATH is already configured correctly"
    fi
}

launch_toolbox() {
    log_step "Launching JetBrains Toolbox..."

    if [ -n "$DISPLAY" ] || [ -n "$WAYLAND_DISPLAY" ]; then
        log_info "Starting Toolbox in background..."
        nohup "$INSTALL_DIR/jetbrains-toolbox" > /dev/null 2>&1 &
        log_info "Toolbox is starting. Look for the icon in your system tray."
    else
        log_warn "No display server detected. Cannot launch GUI."
        log_info "Please run 'jetbrains-toolbox' in a desktop environment."
    fi
}

print_usage_info() {
    cat << EOF

${GREEN}═══════════════════════════════════════════════════════${NC}
${GREEN}  JetBrains Toolbox Installation Complete!${NC}
${GREEN}═══════════════════════════════════════════════════════${NC}

${BLUE}What is JetBrains Toolbox?${NC}
  A unified application manager for all JetBrains IDEs and tools.

${BLUE}Key Features:${NC}
  • Install and update all JetBrains products from one place
  • Manage multiple versions of the same IDE
  • Quick access to recent projects
  • Automatic updates and rollback support
  • Shell script generation for CLI access

${BLUE}How to Use:${NC}
  1. Look for the Toolbox icon in your system tray
  2. Click the icon to open Toolbox
  3. Browse and install available tools:
     - JetBrains Gateway (for remote development)
     - IntelliJ IDEA, PyCharm, WebStorm, etc.
  4. Manage your projects and IDE versions

${BLUE}Command Line Access:${NC}
  Run: ${YELLOW}jetbrains-toolbox${NC}
  Or:  ${YELLOW}$BIN_DIR/jetbrains-toolbox${NC}

${BLUE}Installing JetBrains Gateway:${NC}
  1. Open Toolbox
  2. Search for "Gateway"
  3. Click "Install"
  4. Launch Gateway from Toolbox when ready

${BLUE}Next Steps:${NC}
  • Install JetBrains Gateway for remote development
  • Install your favorite JetBrains IDEs
  • Configure automatic updates in Settings
  • Enable shell scripts for CLI access

${BLUE}Documentation:${NC}
  • Full Guide: docs/jetbrains/INSTALL.md
  • Quick Start: docs/jetbrains/QUICK-START.md
  • Official Docs: https://www.jetbrains.com/toolbox-app/

${BLUE}Uninstall:${NC}
  To remove Toolbox, run:
  ${YELLOW}rm -rf $INSTALL_DIR${NC}
  ${YELLOW}rm $BIN_DIR/jetbrains-toolbox${NC}
  ${YELLOW}rm ~/.local/share/applications/jetbrains-toolbox.desktop${NC}

EOF
}

# Main installation flow
main() {
    print_banner
    log_info "Starting JetBrains Toolbox installation..."
    echo

    check_dependencies
    check_disk_space
    check_existing_installation
    download_toolbox
    install_toolbox
    create_desktop_entry
    update_path
    launch_toolbox
    print_usage_info

    echo
    log_info "Installation script completed successfully!"
    log_info "JetBrains Toolbox should now be running in your system tray."
}

# Run main function
main
