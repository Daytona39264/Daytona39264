# About SSH

SSH (Secure Shell) is a cryptographic network protocol that allows you to securely connect to remote computers and servers over an unsecured network.

## What is SSH?

SSH provides a secure channel over an unsecured network by using a client-server architecture. It was designed as a replacement for older, insecure protocols like Telnet and FTP that transmitted data, including passwords, in plain text.

### Key Features

- **Encryption**: All data transmitted between the client and server is encrypted
- **Authentication**: Multiple methods to verify identity (passwords, public key, certificates)
- **Integrity**: Ensures data hasn't been tampered with during transmission
- **Port Forwarding**: Ability to tunnel other protocols through SSH

## Why Use SSH with GitHub?

When you use SSH with GitHub, you gain several benefits:

1. **No Password Required**: Once set up, you don't need to enter your username and password for every Git operation
2. **Enhanced Security**: More secure than HTTPS with password authentication
3. **Automation**: Easier to automate Git operations in scripts and CI/CD pipelines
4. **Multiple Key Support**: You can use different SSH keys for different accounts or organizations

## How SSH Works

SSH uses public-key cryptography to authenticate users:

1. **Key Pair Generation**: You generate a pair of cryptographic keys
   - **Private Key**: Kept secret on your computer (e.g., `~/.ssh/id_ed25519`)
   - **Public Key**: Shared with services like GitHub (e.g., `~/.ssh/id_ed25519.pub`)

2. **Authentication Process**:
   - You attempt to connect to GitHub
   - GitHub sends a challenge encrypted with your public key
   - Your computer uses the private key to decrypt and respond
   - If the response is correct, you're authenticated

3. **Secure Communication**: Once authenticated, all data is encrypted using session keys

## SSH vs HTTPS

GitHub supports both SSH and HTTPS for Git operations. Here's a comparison:

| Feature | SSH | HTTPS |
|---------|-----|-------|
| Setup Complexity | Medium (key generation required) | Easy (just username/token) |
| Authentication | Key-based | Token-based or password |
| Credential Storage | Keys stored locally | Requires credential helper |
| Firewall Friendly | May be blocked (port 22) | Usually allowed (port 443) |
| Best For | Personal machines, automation | Shared computers, quick setup |

## SSH Key Types

GitHub supports several SSH key algorithms:

### Ed25519 (Recommended)
- **Command**: `ssh-keygen -t ed25519 -C "your_email@example.com"`
- **Advantages**: Small key size, fast, secure
- **Key Size**: 256 bits
- **Introduced**: OpenSSH 6.5 (2014)

### RSA
- **Command**: `ssh-keygen -t rsa -b 4096 -C "your_email@example.com"`
- **Advantages**: Widely compatible
- **Key Size**: Minimum 2048 bits, recommended 4096 bits
- **Note**: Older algorithm, larger keys than Ed25519

### ECDSA
- **Command**: `ssh-keygen -t ecdsa -b 521 -C "your_email@example.com"`
- **Advantages**: Good performance
- **Note**: Concerns about NSA influence on the standard

### DSA (Deprecated)
- **Not recommended**: Considered insecure by modern standards
- GitHub deprecated DSA key support in 2022

## Common SSH Use Cases with GitHub

1. **Cloning Repositories**
   ```bash
   git clone git@github.com:username/repository.git
   ```

2. **Adding Remote Repositories**
   ```bash
   git remote add origin git@github.com:username/repository.git
   ```

3. **Pushing Changes**
   ```bash
   git push origin main
   ```

4. **Pulling Updates**
   ```bash
   git pull origin main
   ```

## Security Considerations

### Best Practices

1. **Use Strong Passphrases**: Always protect your SSH keys with a strong passphrase
2. **Use Ed25519**: Prefer Ed25519 over RSA for new keys
3. **Keep Private Keys Private**: Never share your private key
4. **Use ssh-agent**: Store decrypted keys in memory for convenience
5. **Regular Key Rotation**: Periodically generate new keys and remove old ones
6. **Audit Keys**: Regularly review SSH keys in your GitHub account

### What to Protect

- **Private Key** (`id_ed25519`, `id_rsa`): NEVER share or commit to repositories
- **Passphrase**: Keep it secret and strong

### What You Can Share

- **Public Key** (`id_ed25519.pub`, `id_rsa.pub`): Safe to share, add to GitHub

## SSH Agent

The SSH agent is a helper program that manages your SSH keys:

- **Purpose**: Stores decrypted private keys in memory
- **Benefit**: You only need to enter your passphrase once per session
- **Security**: Keys are kept in memory, not on disk in decrypted form

## Next Steps

Now that you understand SSH, you can:

1. [Check for Existing SSH Keys](./checking-for-existing-ssh-keys.md)
2. [Generate a New SSH Key](./generating-a-new-ssh-key.md)
3. [Add Your SSH Key to GitHub](./adding-ssh-key-to-github.md)

## Additional Resources

- [OpenSSH Official Website](https://www.openssh.com/)
- [SSH Protocol on Wikipedia](https://en.wikipedia.org/wiki/Secure_Shell)
- [GitHub's SSH Documentation](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)
- [The Secure Shell (SSH) Authentication Protocol (RFC 4252)](https://tools.ietf.org/html/rfc4252)
