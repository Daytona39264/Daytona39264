# JetBrains Client Quick Start

Get up and running with JetBrains Client in 5 minutes.

## Prerequisites

- Linux, macOS, or Windows system
- Internet connection
- SSH access to a remote server (optional, for remote development)

## Installation

### One-Line Install (Linux)

```bash
curl -fsSL https://raw.githubusercontent.com/Daytona39264/Daytona39264/main/install-jetbrains-client.sh | bash
```

Or clone and run:

```bash
git clone https://github.com/Daytona39264/Daytona39264.git
cd Daytona39264
./install-jetbrains-client.sh
```

### Quick Manual Install

```bash
# Download
wget https://download.jetbrains.com/idea/code-with-me/backend/jetbrains-clients-downloader-linux-x86_64-latest.tar.gz

# Extract
mkdir -p ~/.local/share/JetBrains
tar -xzf jetbrains-clients-downloader-linux-x86_64-latest.tar.gz -C ~/.local/share/JetBrains

# Add to PATH
mkdir -p ~/.local/bin
ln -s ~/.local/share/JetBrains/jetbrains-clients*/jetbrains-clients-downloader ~/.local/bin/jetbrains-client

# Update PATH in your shell config
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

## First Connection

### Connect via SSH

1. Launch JetBrains Client:
   ```bash
   jetbrains-client
   ```

2. Click **"SSH Connection"**

3. Enter your details:
   ```
   Host: user@your-server.com
   Port: 22
   Authentication: SSH Key (recommended)
   ```

4. Select your IDE (e.g., **IntelliJ IDEA**, **PyCharm**)

5. Choose your project directory on the remote server

6. Wait for backend installation (happens once per IDE)

7. Start coding!

### Connect to Daytona

1. Launch JetBrains Client

2. Select **"Daytona"** provider

3. Authenticate with your Daytona credentials

4. Select your workspace

5. Choose IDE and start developing

## Common Commands

```bash
# Launch JetBrains Client
jetbrains-client

# Check version
jetbrains-client --version

# View help
jetbrains-client --help

# Connect with URL
jetbrains-client "jetbrains-gateway://connect#..."
```

## Essential Shortcuts

| Action | Shortcut (Linux/Win) | Shortcut (macOS) |
|--------|---------------------|------------------|
| Find Action | `Ctrl+Shift+A` | `Cmd+Shift+A` |
| Find File | `Ctrl+Shift+N` | `Cmd+Shift+O` |
| Find Class | `Ctrl+N` | `Cmd+O` |
| Quick Fix | `Alt+Enter` | `Option+Enter` |
| Code Completion | `Ctrl+Space` | `Ctrl+Space` |
| Run | `Shift+F10` | `Ctrl+R` |
| Debug | `Shift+F9` | `Ctrl+D` |
| Terminal | `Alt+F12` | `Option+F12` |
| Settings | `Ctrl+Alt+S` | `Cmd+,` |

## Quick Troubleshooting

### Command Not Found

```bash
# Add to PATH
export PATH="$HOME/.local/bin:$PATH"
source ~/.bashrc
```

### Can't Connect

```bash
# Test SSH connection first
ssh user@your-server.com

# Check port is accessible
nc -zv your-server.com 22
```

### Slow Performance

- Check network latency: `ping your-server.com`
- Use a closer server if possible
- Allocate more RAM to remote IDE backend

## Next Steps

- Read the [Full Installation Guide](INSTALL.md)
- Configure your IDE settings
- Set up SSH keys: [SSH Guide](../ssh/)
- Explore remote development features
- Try different JetBrains IDEs

## Need Help?

- Full docs: [INSTALL.md](INSTALL.md)
- JetBrains Support: https://www.jetbrains.com/support/
- This repo's issues: https://github.com/Daytona39264/Daytona39264/issues

---

**Happy Remote Coding! 🚀**
