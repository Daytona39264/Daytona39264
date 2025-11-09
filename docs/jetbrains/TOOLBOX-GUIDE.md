# JetBrains Toolbox Complete Guide

Comprehensive guide for using JetBrains Toolbox App to manage your JetBrains IDEs and development tools.

## Table of Contents

- [What is JetBrains Toolbox?](#what-is-jetbrains-toolbox)
- [Why Use Toolbox?](#why-use-toolbox)
- [Installation](#installation)
- [First Launch & Setup](#first-launch--setup)
- [Managing IDEs](#managing-ides)
- [Project Management](#project-management)
- [Update Management](#update-management)
- [Settings & Configuration](#settings--configuration)
- [Command Line Integration](#command-line-integration)
- [Tips & Tricks](#tips--tricks)
- [Troubleshooting](#troubleshooting)

## What is JetBrains Toolbox?

**JetBrains Toolbox** is a free desktop application that serves as a centralized hub for installing, updating, and managing all JetBrains IDEs and development tools. Think of it as a "package manager" specifically for JetBrains products.

### Key Features

- **Unified Management**: Install and manage all JetBrains products from one place
- **Automatic Updates**: Keep IDEs up-to-date without manual intervention
- **Version Control**: Run multiple versions of the same IDE side-by-side
- **Project Shortcuts**: Quick access to recent projects across all IDEs
- **Settings Sync**: Synchronize IDE configurations across machines
- **Rollback Support**: Easily revert to previous IDE versions
- **Shell Scripts**: Generate CLI commands for terminal access

### Supported Products

Toolbox can install and manage:

**IDEs:**
- IntelliJ IDEA (Ultimate & Community)
- PyCharm (Professional & Community)
- WebStorm
- PhpStorm
- GoLand
- RubyMine
- CLion
- Rider
- DataGrip
- RustRover

**Tools:**
- JetBrains Gateway (Remote Development)
- Fleet (Next-gen IDE)
- Writerside (Technical writing)
- Aqua (Test automation)
- ReSharper (Visual Studio extension manager)

## Why Use Toolbox?

### Benefits Over Standalone Installation

| Aspect | With Toolbox | Without Toolbox |
|--------|--------------|-----------------|
| Installation | One-click install | Manual download & setup |
| Updates | Automatic, with notifications | Check manually, download, install |
| Multiple Versions | Easy side-by-side installation | Complex manual setup |
| Project Access | Quick launcher from system tray | Navigate file system or IDE |
| Disk Space | Shared plugins & components | Duplicate installations |
| Uninstall | Clean removal through Toolbox | Manual cleanup required |
| License Management | Centralized view | Per-IDE activation |

### When to Use Toolbox

**Use Toolbox if you:**
- Work with multiple JetBrains IDEs
- Want automatic updates
- Need to test different IDE versions
- Prefer GUI-based management
- Work on many projects
- Want quick project access
- Use multiple machines and want settings sync

**Skip Toolbox if you:**
- Only use one JetBrains product
- Prefer CLI-only workflows
- Work in headless/server environments
- Have strict disk space constraints
- Want minimal system overhead

## Installation

### Quick Install

```bash
# Clone this repository
git clone https://github.com/Daytona39264/Daytona39264.git
cd Daytona39264

# Run the Toolbox installer
./install-jetbrains-toolbox.sh
```

### Manual Installation

**Linux:**
```bash
# Download
wget https://download.jetbrains.com/toolbox/jetbrains-toolbox-latest.tar.gz

# Extract
tar -xzf jetbrains-toolbox-latest.tar.gz

# Run (will auto-install to ~/.local/share/JetBrains/Toolbox)
./jetbrains-toolbox-*/jetbrains-toolbox
```

**macOS:**
1. Download from: https://www.jetbrains.com/toolbox-app/
2. Open the DMG file
3. Drag Toolbox to Applications folder
4. Launch from Applications

**Windows:**
1. Download from: https://www.jetbrains.com/toolbox-app/
2. Run the .exe installer
3. Follow installation wizard
4. Launch from Start Menu or system tray

## First Launch & Setup

### Initial Configuration

When you first launch Toolbox:

1. **Accept Privacy Policy**
   - Review and accept the privacy policy
   - Configure data sharing preferences

2. **Login (Optional but Recommended)**
   - Click "Log in to JetBrains Account"
   - Use your JetBrains credentials
   - Benefits:
     - License management
     - Settings synchronization
     - Early access programs
     - Special offers

3. **Configure Installation Directory**
   - Click the gear icon (⚙️) → Settings
   - Default locations:
     - Linux: `~/.local/share/JetBrains/Toolbox/apps`
     - macOS: `~/Library/Application Support/JetBrains/Toolbox/apps`
     - Windows: `%LOCALAPPDATA%\JetBrains\Toolbox\apps`
   - Change if needed (requires more disk space elsewhere)

4. **Enable Shell Scripts** (Recommended)
   - Settings → Tools → Generate shell scripts
   - Choose directory:
     - Linux/macOS: `~/.local/bin` or `/usr/local/bin`
     - Windows: Add to PATH
   - Enables commands like `idea .` or `pycharm .`

5. **Configure Update Behavior**
   - Settings → Tools → Update behavior
   - Options:
     - **Keep up to date**: Auto-download and install
     - **Update manually**: Notify only
     - **Install updates on IDE restart**: Queue updates

### Understanding the Interface

**Main Window Sections:**

1. **Installed Tools** (Top)
   - Shows all installed IDEs and tools
   - Quick launch buttons
   - Version information
   - Settings per tool

2. **Available Tools** (Bottom)
   - Browse all installable products
   - Search functionality
   - Version selection

3. **System Tray Icon**
   - Right-click for quick actions
   - Recent projects list
   - Settings access

## Managing IDEs

### Installing an IDE

1. **Find the IDE**
   - Scroll through "Available Tools"
   - Or use the search bar at the top

2. **Select Version**
   - Click the dropdown next to "Install"
   - Options:
     - **Recommended** (latest stable)
     - **EAP** (Early Access Program - beta)
     - **Previous versions** (older stable releases)

3. **Install**
   - Click "Install"
   - Download progress shown
   - IDE appears in "Installed Tools" when ready

4. **Launch**
   - Click the IDE icon in Toolbox
   - Or use desktop shortcut (created automatically)
   - Or use shell command (if enabled): `idea`, `pycharm`, `webstorm`, etc.

### Installing Multiple Versions

Perfect for testing or compatibility:

1. Find the installed IDE in Toolbox
2. Click the ⚙️ icon next to it
3. Select "Install another version"
4. Choose the version
5. Click "Install"

Both versions will appear separately in Toolbox with their version numbers.

### Updating an IDE

**Automatic Updates:**
- If enabled, Toolbox downloads updates automatically
- Updates install on next IDE restart
- Notification badge appears in Toolbox

**Manual Updates:**
1. Find the IDE in Toolbox
2. If update available, "Update" button appears
3. Click "Update"
4. Close the IDE if running
5. Update installs automatically

### Rolling Back

If an update causes issues:

1. Find the IDE in Toolbox
2. Click ⚙️ → "Install another version"
3. Select the previous version
4. Click "Install"
5. Click ⚙️ on the problematic version → "Uninstall"

### Uninstalling an IDE

1. Find the IDE in Toolbox
2. Click the ⚙️ icon
3. Select "Uninstall"
4. Confirm removal
5. Toolbox cleans up all files

**Note:** Projects and settings are preserved by default.

## Project Management

### Accessing Recent Projects

**From System Tray:**
1. Click the Toolbox icon
2. Hover over an IDE name
3. See list of recent projects
4. Click project to open

**From Main Window:**
1. Click the IDE icon
2. Recent projects shown below the icon
3. Click to open

### Pinning Favorite Projects

1. Find the project in recent projects list
2. Hover over the project name
3. Click the pin icon (📌)
4. Pinned projects appear at the top

### Opening Projects from Terminal

If shell scripts are enabled:

```bash
# IntelliJ IDEA
idea ~/path/to/project

# PyCharm
pycharm ~/path/to/project

# WebStorm
webstorm ~/path/to/project

# Open current directory
cd ~/my-project
idea .
```

## Update Management

### Update Channels

Configure in Settings → Tools:

1. **Stable** (Default)
   - Production-ready releases
   - Most stable, recommended for production work

2. **EAP** (Early Access Program)
   - Beta/preview releases
   - New features before stable release
   - May have bugs

3. **Beta**
   - Release candidates
   - More stable than EAP, less than Stable

### Update Settings

**Settings → Tools → Update to:**

- **Latest version**: Always update to newest
- **Major versions only**: Skip minor updates
- **Custom**: Choose specific versions

**Update Installation:**

- **Automatic**: Download and install immediately
- **On restart**: Download now, install when IDE closes
- **Manual**: Notify only, user decides when

### Updating All Tools

1. Click "Update All" in Toolbox (if available)
2. Or update each tool individually
3. Close all running IDEs for installation
4. Toolbox installs updates sequentially

## Settings & Configuration

### Accessing Settings

- Click the gear icon (⚙️) in Toolbox header
- Or right-click system tray icon → Settings

### Important Settings

**Appearance:**
- Theme (Light/Dark/System)
- Launch on system startup
- Show in system tray

**Tools:**
- Installation directory
- Shell scripts location
- Update behavior
- Update channels
- Keep only the latest version (saves disk space)

**Privacy:**
- Send anonymous usage statistics
- Check for updates automatically

**Advanced:**
- Proxy settings
- Custom repository URLs (for offline installations)
- Debug logging

### Configuring Shell Scripts

1. Settings → Tools
2. Check "Generate shell scripts"
3. Choose location:
   ```bash
   # Linux/macOS
   ~/.local/bin        # Recommended for single user
   /usr/local/bin      # System-wide (needs sudo)

   # Windows
   Add chosen directory to PATH
   ```
4. Apply changes
5. Test in terminal:
   ```bash
   which idea    # Should show the script path
   idea --help   # Should show IntelliJ help
   ```

## Command Line Integration

### Available Commands

After enabling shell scripts:

```bash
# IntelliJ IDEA
idea [options] [path]

# PyCharm
pycharm [options] [path]

# WebStorm
webstorm [options] [path]

# PhpStorm
phpstorm [options] [path]

# GoLand
goland [options] [path]

# CLion
clion [options] [path]

# Other IDEs follow similar pattern
```

### Common Options

```bash
# Open current directory
idea .

# Open specific file
idea /path/to/file.java

# Open file at specific line
idea --line 42 /path/to/file.java

# Diff two files
idea diff file1.txt file2.txt

# Merge files
idea merge base.txt left.txt right.txt

# Format code
idea format /path/to/file.java

# Show version
idea --version

# Wait for IDE to close (for scripts)
idea --wait .
```

### Using in Scripts

```bash
#!/bin/bash

# Open project in IntelliJ
cd ~/my-project
idea .

# Wait for user to close IDE
idea --wait .

# Continue with script after IDE closes
echo "IDE closed, continuing..."
```

### Integration with Git

```bash
# Set IntelliJ as git difftool
git config --global diff.tool idea
git config --global difftool.idea.cmd 'idea diff "$LOCAL" "$REMOTE"'

# Set as git mergetool
git config --global merge.tool idea
git config --global mergetool.idea.cmd 'idea merge "$BASE" "$LOCAL" "$REMOTE" "$MERGED"'

# Use with git
git difftool HEAD HEAD~1 file.txt
git mergetool
```

## Tips & Tricks

### Productivity Tips

1. **Quick Project Switching**
   - Keep Toolbox in system tray
   - Click icon → hover over IDE → click project
   - Faster than navigating file system

2. **Pin Most-Used Projects**
   - Pin frequently accessed projects to top
   - Right-click project → Pin

3. **Multiple IDE Versions for Testing**
   - Install stable for production work
   - Install EAP for trying new features
   - Install older version for legacy projects

4. **Shared Plugins**
   - Toolbox shares plugins between IDE versions
   - Saves disk space and download time
   - Configure once, use everywhere

5. **Settings Sync**
   - Enable Settings Sync in each IDE
   - Settings backup to JetBrains cloud
   - Sync across all machines automatically

### Space-Saving Tips

1. **Keep Only Latest Version**
   - Settings → Keep only the latest version
   - Auto-removes old versions after update
   - Saves significant disk space

2. **Selective Installation**
   - Only install IDEs you actively use
   - Use Gateway for remote development instead of full IDE

3. **Clear Old Projects**
   - Periodically remove projects from recent list
   - Settings in each IDE → File → Remove from recent

### Advanced Usage

**Custom Toolbox Directory:**
```bash
# Linux: Custom location
TOOLBOX_HOME=/custom/path jetbrains-toolbox
```

**Portable Toolbox:**
- Install Toolbox to USB drive
- Set all paths to relative
- Use on multiple machines

**Offline Installation:**
- Download IDE installers manually
- Place in Toolbox cache directory
- Toolbox uses local files

**Corporate Environments:**
- Configure proxy in Settings
- Use custom repository URLs
- Centralized license server

## Troubleshooting

### Toolbox Won't Start

**Issue:** Double-clicking does nothing

**Solutions:**
```bash
# Check if already running
ps aux | grep jetbrains-toolbox

# Kill stuck process
killall jetbrains-toolbox

# Clear cache and restart
rm -rf ~/.local/share/JetBrains/Toolbox/logs
jetbrains-toolbox
```

### IDE Not Appearing After Install

**Issue:** Installed IDE doesn't show in Toolbox

**Solutions:**
1. Refresh Toolbox (Ctrl+R or Cmd+R)
2. Check installation directory in Settings
3. Verify disk space
4. Check logs: `~/.local/share/JetBrains/Toolbox/logs/`

### Shell Scripts Not Working

**Issue:** `idea` command not found

**Solutions:**
```bash
# 1. Check if scripts enabled
# Settings → Generate shell scripts

# 2. Check script location in PATH
echo $PATH | grep -o ~/.local/bin

# 3. Add to PATH if missing
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# 4. Verify script exists
ls -l ~/.local/bin/idea
```

### Update Failures

**Issue:** Update downloads but won't install

**Solutions:**
1. Close the IDE completely
2. Check disk space
3. Disable antivirus temporarily (Windows)
4. Clear Toolbox cache:
   ```bash
   rm -rf ~/.local/share/JetBrains/Toolbox/update
   ```
5. Retry update

### Projects Not Showing

**Issue:** Recent projects list is empty

**Solutions:**
1. Open IDE and access projects
2. Projects appear after opening them once
3. Check IDE logs for errors
4. Re-add projects manually in IDE

### High Memory/CPU Usage

**Issue:** Toolbox using too many resources

**Solutions:**
1. Close unused IDEs
2. Disable automatic updates temporarily
3. Clear cache:
   ```bash
   rm -rf ~/.local/share/JetBrains/Toolbox/cache
   ```
4. Restart Toolbox

### License Issues

**Issue:** License not recognized after installing via Toolbox

**Solutions:**
1. Login to JetBrains Account in Toolbox
2. Open IDE → Help → Register
3. Choose "JetBrains Account" login
4. Sign in with your credentials
5. License auto-activates

### Uninstalling Toolbox

**Complete Removal:**

```bash
# Linux
rm -rf ~/.local/share/JetBrains/Toolbox
rm ~/.local/bin/jetbrains-toolbox
rm ~/.local/share/applications/jetbrains-toolbox.desktop

# macOS
rm -rf ~/Library/Application\ Support/JetBrains/Toolbox
rm -rf ~/Library/Caches/JetBrains/Toolbox
rm -rf ~/Library/Logs/JetBrains/Toolbox
rm -rf /Applications/JetBrains\ Toolbox.app

# Windows (PowerShell)
Remove-Item $env:LOCALAPPDATA\JetBrains\Toolbox -Recurse
```

**Note:** This also removes installed IDEs. Backup projects first!

## Resources

### Official Documentation
- JetBrains Toolbox: https://www.jetbrains.com/toolbox-app/
- Support: https://www.jetbrains.com/help/toolbox/
- FAQ: https://www.jetbrains.com/help/toolbox/faq.html

### Related Guides
- [Quick Start Guide](QUICK-START.md)
- [Full Installation Guide](INSTALL.md)
- [SSH Setup for Remote Development](../ssh/)

### Community
- JetBrains Community Forum: https://intellij-support.jetbrains.com/hc/en-us/community/topics
- Issue Tracker: https://youtrack.jetbrains.com/issues/TBX
- Reddit: r/JetBrains

---

**Last Updated**: November 2025
**Maintained by**: [@Daytona39264](https://github.com/Daytona39264)
