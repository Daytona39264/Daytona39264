# JetBrains Client Installation Guide

Complete guide for installing and using JetBrains Client (Gateway thin client) for remote development.

## Table of Contents

- [Overview](#overview)
- [System Requirements](#system-requirements)
- [Installation Methods](#installation-methods)
  - [Automated Installation (Recommended)](#automated-installation-recommended)
  - [Manual Installation](#manual-installation)
  - [JetBrains Toolbox](#jetbrains-toolbox)
- [Post-Installation](#post-installation)
- [Usage](#usage)
- [Troubleshooting](#troubleshooting)
- [Resources](#resources)

## Overview

**JetBrains Client** (formerly JetBrains Gateway thin client) is a lightweight application that enables remote development with JetBrains IDEs. It allows you to:

- Connect to remote development environments (servers, containers, workspaces)
- Use full-featured JetBrains IDEs (IntelliJ IDEA, PyCharm, WebStorm, etc.) on remote machines
- Develop with the power of your remote server while maintaining a responsive local UI
- Perfect for cloud development environments like Daytona, GitHub Codespaces, or custom remote servers

## System Requirements

### Minimum Requirements

- **OS**: Linux (x86_64), macOS, or Windows
- **RAM**: 512 MB for the client (IDE backend requires additional memory on remote)
- **Disk Space**: 500 MB for installation
- **Network**: Stable internet connection for remote development

### Linux-Specific Requirements

- **Distribution**: Ubuntu 18.04+, Fedora 28+, Debian 9+, or equivalent
- **Dependencies**:
  - `wget` or `curl`
  - `tar`
  - `glibc 2.23+`
  - X11 or Wayland display server

### Supported IDEs (Remote Backend)

- IntelliJ IDEA Ultimate
- PyCharm Professional
- WebStorm
- PhpStorm
- GoLand
- RubyMine
- CLion
- Rider
- DataGrip
- And other JetBrains IDEs

## Installation Methods

### Automated Installation (Recommended)

We provide an automated installation script that handles all steps:

```bash
# Clone the repository if you haven't already
git clone https://github.com/Daytona39264/Daytona39264.git
cd Daytona39264

# Run the installation script
./install-jetbrains-client.sh
```

The script will:
1. Check system dependencies
2. Verify disk space
3. Download JetBrains Client
4. Extract and install to `~/.local/share/JetBrains`
5. Create a symlink in `~/.local/bin`
6. Provide PATH configuration instructions if needed

### Manual Installation

If you prefer manual installation or the automated script doesn't work:

#### Step 1: Download

Download the latest JetBrains Client for your platform:

```bash
# For Linux x86_64
wget https://download.jetbrains.com/idea/code-with-me/backend/jetbrains-clients-downloader-linux-x86_64-latest.tar.gz

# Alternative: Use curl
curl -L -o jetbrains-client.tar.gz \
  https://download.jetbrains.com/idea/code-with-me/backend/jetbrains-clients-downloader-linux-x86_64-latest.tar.gz
```

Or download from the official page:
- https://www.jetbrains.com/remote-development/gateway/

#### Step 2: Extract

```bash
# Create installation directory
mkdir -p ~/.local/share/JetBrains

# Extract the archive
tar -xzf jetbrains-client.tar.gz -C ~/.local/share/JetBrains
```

#### Step 3: Create Symlink

```bash
# Create bin directory if it doesn't exist
mkdir -p ~/.local/bin

# Create symbolic link (adjust path if needed)
ln -s ~/.local/share/JetBrains/jetbrains-clients*/jetbrains-clients-downloader \
  ~/.local/bin/jetbrains-client
```

#### Step 4: Update PATH

Add `~/.local/bin` to your PATH if not already included:

**For Bash** (`~/.bashrc`):
```bash
export PATH="$HOME/.local/bin:$PATH"
```

**For Zsh** (`~/.zshrc`):
```bash
export PATH="$HOME/.local/bin:$PATH"
```

**For Fish** (`~/.config/fish/config.fish`):
```fish
set -gx PATH $HOME/.local/bin $PATH
```

Reload your shell configuration:
```bash
source ~/.bashrc  # or ~/.zshrc, or restart your terminal
```

### JetBrains Toolbox (Recommended for Multiple IDEs)

**JetBrains Toolbox** is the official application manager from JetBrains that provides a unified way to install, update, and manage all JetBrains IDEs and tools, including JetBrains Gateway (Client).

#### Why Use Toolbox?

- **Centralized Management**: Install and update all JetBrains products from one place
- **Automatic Updates**: Keep your IDEs and tools up-to-date automatically
- **Version Management**: Install and switch between multiple versions of the same IDE
- **Project Management**: Quick access to recent projects across all IDEs
- **Easy Rollback**: Revert to previous versions if needed
- **System Tray Integration**: Quick launcher for all installed tools
- **Settings Sync**: Synchronize IDE settings across machines

#### Toolbox vs. Standalone Installation

| Feature | Toolbox | Standalone |
|---------|---------|------------|
| Installation Complexity | Easy (GUI) | Moderate (CLI/Manual) |
| Updates | Automatic | Manual |
| Multiple IDE Management | Yes | No |
| Version Switching | Yes | Manual |
| Disk Space (Overhead) | ~100 MB | None |
| Best For | Multiple IDEs | Single tool/CLI environments |

#### Step 1: Download Toolbox

**Linux:**
```bash
# Method 1: Direct download
wget https://download.jetbrains.com/toolbox/jetbrains-toolbox-latest.tar.gz

# Method 2: Get specific version
wget https://download.jetbrains.com/toolbox/jetbrains-toolbox-2.1.3.18901.tar.gz

# Extract the archive
tar -xzf jetbrains-toolbox-*.tar.gz

# Make it executable
chmod +x jetbrains-toolbox-*/jetbrains-toolbox

# Run the installer
./jetbrains-toolbox-*/jetbrains-toolbox
```

**macOS:**
```bash
# Download the DMG
curl -L -o JetBrainsToolbox.dmg \
  https://download.jetbrains.com/toolbox/jetbrains-toolbox-latest.dmg

# Mount and install
open JetBrainsToolbox.dmg
# Drag to Applications folder
```

**Windows:**
Download the `.exe` installer from:
https://www.jetbrains.com/toolbox-app/

#### Step 2: Initial Setup

1. **Launch Toolbox**
   - Linux: The app will start and add an icon to your system tray
   - macOS: Open from Applications
   - Windows: Run the installed executable

2. **Login (Optional but Recommended)**
   - Sign in with your JetBrains account
   - Enables license management and settings sync
   - Not required for Community editions or trial usage

3. **Configure Settings**
   - Click the gear icon in Toolbox
   - Set installation directory (default: `~/.local/share/JetBrains/Toolbox/apps`)
   - Configure update preferences
   - Enable/disable automatic updates
   - Set shell scripts directory (for command-line access)

#### Step 3: Install JetBrains Gateway (Client)

1. **Open JetBrains Toolbox** from your system tray or applications

2. **Find Gateway**
   - Scroll through the available tools
   - Or use the search bar: type "Gateway"

3. **Install**
   - Click the "Install" button next to "JetBrains Gateway"
   - Toolbox will download and install the latest version
   - A desktop entry/launcher will be created automatically

4. **Launch Gateway**
   - Click the Gateway icon in Toolbox
   - Or use the desktop launcher
   - Or run from command line (if shell scripts enabled): `gateway`

#### Step 4: Install IDE Backends (Optional)

If you want full JetBrains IDEs locally (not just for remote development):

1. **Browse Available IDEs** in Toolbox
   - IntelliJ IDEA Ultimate / Community
   - PyCharm Professional / Community
   - WebStorm
   - PhpStorm
   - GoLand
   - CLion
   - RubyMine
   - Rider
   - DataGrip
   - And more...

2. **Install Desired IDEs**
   - Click "Install" next to any IDE
   - Choose version (latest stable, EAP, or specific version)
   - Toolbox handles everything automatically

3. **Manage Versions**
   - Click the ⚙️ icon next to an installed IDE
   - "Install another version" to have multiple versions
   - Useful for testing or compatibility

#### Toolbox Features

**Project Management:**
- See all recent projects across all IDEs
- Open projects quickly from the system tray
- Pin frequently used projects

**Update Management:**
- Automatic update checking
- Choose update channels (Stable, EAP, Beta)
- Update all tools with one click
- Schedule updates for specific times

**Shell Scripts:**
- Enable in Settings → Generate shell scripts
- Access IDEs from command line
- Example: `idea .` to open current directory in IntelliJ IDEA
- Scripts location: `~/.local/bin` (Linux), `/usr/local/bin` (macOS)

**Licensing:**
- View all active licenses
- Manage subscriptions
- Easy license activation across IDEs

#### Toolbox Command Line

While Toolbox is primarily a GUI application, you can control it programmatically:

```bash
# Linux: Toolbox location
~/.local/share/JetBrains/Toolbox/bin/jetbrains-toolbox

# macOS: Toolbox location
~/Library/Application\ Support/JetBrains/Toolbox/bin/jetbrains-toolbox

# Example: Open Toolbox
jetbrains-toolbox &
```

#### Uninstalling via Toolbox

To remove JetBrains Gateway or other tools:

1. Open Toolbox
2. Find the tool you want to remove
3. Click the ⚙️ (settings) icon
4. Select "Uninstall"
5. Confirm removal

#### Troubleshooting Toolbox

**Toolbox won't start:**
```bash
# Check if it's already running
ps aux | grep toolbox

# Kill existing process if stuck
killall jetbrains-toolbox

# Remove settings file (last resort)
rm -f ~/.local/share/JetBrains/Toolbox/.settings.json
```

**Tools not appearing in Toolbox:**
- Check your internet connection
- Refresh the tool list (Settings → Update list)
- Check available disk space
- Verify Toolbox isn't in offline mode

**Can't find installed tools:**
- Check installation directory in Settings
- Verify shell scripts are enabled
- Re-scan for installed applications

## Post-Installation

### Verify Installation

Check that JetBrains Client is properly installed:

```bash
# Check if the binary is accessible
which jetbrains-client

# Try running it (should show help or version)
jetbrains-client --help
```

### First Launch

When you first launch JetBrains Client:

```bash
jetbrains-client
```

The client will:
1. Open the JetBrains Gateway interface
2. Allow you to configure remote connections
3. Download IDE backends as needed

## Usage

### Connecting to a Remote Environment

#### Method 1: SSH Connection

1. Launch JetBrains Client:
   ```bash
   jetbrains-client
   ```

2. Select "SSH Connection"

3. Enter connection details:
   - Host: `user@hostname` or `user@ip-address`
   - Port: (default 22)
   - Authentication: Password or SSH key

4. Choose your IDE (IntelliJ IDEA, PyCharm, etc.)

5. Select or create a project directory

6. The IDE backend will be installed on the remote machine and the client will connect

#### Method 2: Daytona Workspace

If you're using Daytona:

1. Launch JetBrains Client

2. Select "Daytona" from the providers

3. Authenticate with your Daytona account

4. Select your workspace

5. Choose your IDE

6. Start coding!

#### Method 3: Direct URL

Some platforms provide direct connection URLs:

```bash
jetbrains-client "jetbrains-gateway://connect#host=example.com&..."
```

### Keyboard Shortcuts

Once connected, you can use standard JetBrains IDE shortcuts:

- `Ctrl+Shift+A` (Cmd+Shift+A on macOS): Find Action
- `Ctrl+N` (Cmd+O): Find Class
- `Ctrl+Shift+N` (Cmd+Shift+O): Find File
- `Alt+Enter` (Option+Enter): Show Context Actions
- `Ctrl+Space`: Code Completion

Full shortcut reference: https://www.jetbrains.com/help/idea/mastering-keyboard-shortcuts.html

## Troubleshooting

### Common Issues

#### Issue: Command not found

**Problem**: Running `jetbrains-client` shows "command not found"

**Solution**:
1. Check if `~/.local/bin` is in your PATH:
   ```bash
   echo $PATH | grep ".local/bin"
   ```

2. If not, add it to your shell configuration (see [Post-Installation](#post-installation))

3. Restart your terminal or source your shell config:
   ```bash
   source ~/.bashrc  # or ~/.zshrc
   ```

#### Issue: Connection Failed

**Problem**: Cannot connect to remote host

**Solutions**:
- Verify SSH access: `ssh user@hostname`
- Check firewall rules on remote host
- Ensure the remote host has sufficient resources (RAM, disk)
- Check network connectivity

#### Issue: IDE Backend Installation Failed

**Problem**: Backend installation fails on remote host

**Solutions**:
- Ensure remote host has internet access
- Check available disk space on remote (need ~2GB for IDE backend)
- Verify write permissions in installation directory
- Try a different IDE version

#### Issue: Slow Performance

**Problem**: IDE feels sluggish or unresponsive

**Solutions**:
- Check network latency: `ping your-remote-host`
- Reduce network bandwidth usage (disable sync features if needed)
- Allocate more memory to IDE backend on remote
- Use a server closer to your location
- Check CPU/RAM usage on remote server

### Network Issues

If you're behind a corporate proxy or firewall:

1. Configure proxy settings in JetBrains Client:
   - Settings → Appearance & Behavior → System Settings → HTTP Proxy

2. Ensure the following ports are accessible:
   - SSH: 22 (or your custom SSH port)
   - JetBrains backend communication ports (varies by setup)

### Logs and Diagnostics

Access logs for troubleshooting:

```bash
# Client logs
~/.local/share/JetBrains/JetBrainsClient*/log/

# IDE backend logs (on remote)
~/.cache/JetBrains/RemoteDev-IU/log/  # IntelliJ IDEA
~/.cache/JetBrains/RemoteDev-PY/log/  # PyCharm
# etc.
```

## Resources

### Official Documentation

- **JetBrains Gateway**: https://www.jetbrains.com/remote-development/gateway/
- **Remote Development**: https://www.jetbrains.com/remote-development/
- **Documentation**: https://www.jetbrains.com/help/idea/remote-development-overview.html

### Video Tutorials

- Getting Started with JetBrains Gateway: https://www.youtube.com/watch?v=XXXXXXXXXXXX
- Remote Development Best Practices: https://www.youtube.com/jetbrains

### Community Support

- **JetBrains Community Forum**: https://intellij-support.jetbrains.com/hc/en-us/community/topics
- **Issue Tracker**: https://youtrack.jetbrains.com/issues
- **Stack Overflow**: Tag questions with `jetbrains-gateway` or `jetbrains-ide`

### Related Guides in This Repository

- [SSH Connection Guide](../ssh/) - Set up SSH keys for remote connections
- [Claude Code Integration](../claude-code/) - AI-powered development assistance

## Alternative Tools

If JetBrains Client doesn't meet your needs, consider:

- **VS Code Remote SSH**: https://code.visualstudio.com/docs/remote/ssh
- **Eclipse Che**: https://www.eclipse.org/che/
- **Gitpod**: https://www.gitpod.io/
- **GitHub Codespaces**: https://github.com/features/codespaces

---

## Contributing

Found an issue with this guide or want to improve it?

1. Fork this repository
2. Make your changes
3. Submit a pull request

Or [open an issue](https://github.com/Daytona39264/Daytona39264/issues) to report problems or suggest improvements.

---

**Last Updated**: November 2025
**Maintained by**: [@Daytona39264](https://github.com/Daytona39264)
