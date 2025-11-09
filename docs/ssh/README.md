# Connecting to GitHub with SSH

You can connect to GitHub using the Secure Shell Protocol (SSH), which provides a secure channel over an unsecured network.

## Overview

SSH is a secure protocol used as the primary means of connecting to Linux servers remotely. It provides a text-based interface by spawning a remote shell. After connecting, all commands you type in your local terminal are sent to the remote server and executed there.

When you set up SSH with GitHub, you can push and pull to/from repositories without having to supply your username and personal access token at each visit.

## Table of Contents

1. [About SSH](./about-ssh.md) - Learn what SSH is and why you should use it
2. [Checking for Existing SSH Keys](./checking-for-existing-ssh-keys.md) - Before you generate an SSH key, check for existing keys
3. [Generating a New SSH Key](./generating-a-new-ssh-key.md) - Generate a new SSH key and add it to the ssh-agent
4. [Adding a New SSH Key to Your GitHub Account](./adding-ssh-key-to-github.md) - Add your public SSH key to GitHub
5. [Testing Your SSH Connection](./testing-ssh-connection.md) - Verify your SSH connection works
6. [Working with SSH Key Passphrases](./ssh-key-passphrases.md) - Manage and secure your SSH key passphrases
7. [Using SSH Agent Forwarding](./ssh-agent-forwarding.md) - Securely use your local SSH keys on remote servers
8. [Managing Deploy Keys](./managing-deploy-keys.md) - Set up SSH keys for repository-specific access

## Quick Start

If you're new to SSH and want to get started quickly:

1. **Check for existing SSH keys** - You may already have SSH keys on your computer
   ```bash
   ls -al ~/.ssh
   ```

2. **Generate a new SSH key** - If you don't have one, create a new SSH key pair
   ```bash
   ssh-keygen -t ed25519 -C "your_email@example.com"
   ```

3. **Add your SSH key to ssh-agent** - Start the ssh-agent and add your key
   ```bash
   eval "$(ssh-agent -s)"
   ssh-add ~/.ssh/id_ed25519
   ```

4. **Add the SSH key to your GitHub account** - Copy your public key and add it to GitHub
   ```bash
   cat ~/.ssh/id_ed25519.pub
   ```
   Then go to GitHub Settings → SSH and GPG keys → New SSH key

5. **Test your connection**
   ```bash
   ssh -T git@github.com
   ```

## Prerequisites

- A GitHub account
- Access to a terminal/command line
- Basic familiarity with command line operations

## Platform-Specific Guides

The instructions in this guide work across multiple platforms:

- **macOS**: Use the built-in Terminal application
- **Linux**: Use your distribution's terminal
- **Windows**: Use Git Bash, WSL, or PowerShell

## Getting Help

If you encounter issues:

1. Check the [Testing Your SSH Connection](./testing-ssh-connection.md) guide for troubleshooting
2. Review the [SSH Key Passphrases](./ssh-key-passphrases.md) guide if you're having passphrase issues
3. Consult [GitHub's SSH documentation](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)

## Security Best Practices

- Always use a passphrase to protect your SSH keys
- Use Ed25519 algorithm for new keys (more secure and performant than RSA)
- Never share your private key (`id_ed25519` or `id_rsa`)
- Only share your public key (`id_ed25519.pub` or `id_rsa.pub`)
- Regularly audit and remove unused SSH keys from your GitHub account

## Additional Resources

- [GitHub Documentation](https://docs.github.com)
- [OpenSSH Manual](https://www.openssh.com/manual.html)
- [SSH Protocol Specification](https://www.ssh.com/academy/ssh/protocol)

---

Ready to get started? Begin with [About SSH](./about-ssh.md) to learn more about the protocol, or jump straight to [Checking for Existing SSH Keys](./checking-for-existing-ssh-keys.md) to begin the setup process.
