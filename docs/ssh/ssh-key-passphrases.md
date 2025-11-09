# Working with SSH Key Passphrases

A passphrase adds an extra layer of security to your SSH keys by encrypting the private key file. This guide covers creating, changing, and managing SSH key passphrases.

## What is an SSH Key Passphrase?

An SSH key passphrase is a password that encrypts your private SSH key. Even if someone obtains your private key file, they cannot use it without the passphrase.

### How It Works

1. **Key Generation**: When you create an SSH key with a passphrase, the private key is encrypted
2. **Key Usage**: Each time you use the key, you must enter the passphrase to decrypt it
3. **ssh-agent**: Stores the decrypted key in memory so you only enter the passphrase once per session

## Why Use a Passphrase?

### Security Benefits

- **Protection against theft**: If someone steals your laptop or copies your SSH key file, they still can't use it
- **Defense in depth**: Adds a second factor of security beyond just possessing the file
- **Compliance**: Many security policies require passphrase-protected keys
- **Reduced impact of breaches**: If your private key is exposed, you have time to revoke it before it's used

### The Trade-off

**Without passphrase:**
- ✅ More convenient (no password entry)
- ❌ Less secure (anyone with the file can use it)
- ❌ Dangerous if key is stolen or exposed

**With passphrase:**
- ✅ Much more secure
- ✅ Meets security best practices
- ⚠️ Slightly less convenient (but ssh-agent helps)

## Creating a Key with a Passphrase

When generating a new SSH key, you'll be prompted for a passphrase:

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

You'll see:
```
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
```

### Strong Passphrase Guidelines

**Good passphrases:**
- At least 12-16 characters
- Mix of uppercase, lowercase, numbers, and symbols
- Not a dictionary word or common phrase
- Unique to this key (don't reuse passwords)

**Examples of strong passphrases:**
- `Tr0pic@l-P1n3apple!2024`
- `MyC@t7sN@me!sWh1skers`
- `C0ff33&D0nuts#Everyday`

**Avoid:**
- Common words: `password`, `github`, `ssh`
- Personal info: birthday, name, username
- Short phrases: less than 12 characters
- Leaving it blank (empty passphrase)

### Passphrase vs Password

- **Password**: Usually shorter, used for login
- **Passphrase**: Usually longer, can be a sentence or phrase
- **Best**: Use a long, memorable phrase with modifications

Example: "I drink 3 cups of coffee every morning!" → `!Dr1nk3Cup$0fC0ff33`

## Adding a Passphrase to an Existing Key

If you created a key without a passphrase, you can add one:

```bash
ssh-keygen -p -f ~/.ssh/id_ed25519
```

**Parameters explained:**
- `-p`: Change the passphrase
- `-f`: Specify the key file

You'll see:
```
Enter old passphrase: (press Enter if there was none)
Enter new passphrase:
Enter same passphrase again:
Your identification has been saved with the new passphrase.
```

## Changing an Existing Passphrase

To change your passphrase:

```bash
ssh-keygen -p -f ~/.ssh/id_ed25519
```

Follow the prompts:
```
Enter old passphrase: [enter current passphrase]
Enter new passphrase: [enter new passphrase]
Enter same passphrase again: [re-enter new passphrase]
```

### When to Change Your Passphrase

- Regularly as part of security hygiene (every 6-12 months)
- If you suspect it might be compromised
- When rotating keys
- If you used a weak passphrase initially

## Removing a Passphrase

**⚠️ Warning**: Removing a passphrase reduces security significantly. Only do this if absolutely necessary.

```bash
ssh-keygen -p -f ~/.ssh/id_ed25519
```

When prompted:
```
Enter old passphrase: [enter current passphrase]
Enter new passphrase: [press Enter for no passphrase]
Enter same passphrase again: [press Enter again]
```

### When Removing Might Be Acceptable

- Automated systems (CI/CD servers) - but consider using deploy keys instead
- Highly secure, physically isolated systems
- When protected by other security layers (disk encryption, HSM, etc.)

### Better Alternatives to Removing

Instead of removing the passphrase:
1. Use ssh-agent to cache the decrypted key
2. Use deploy keys for automation
3. Use SSH certificates for advanced setups
4. Use hardware security keys (YubiKey, etc.)

## Using ssh-agent

The SSH agent stores your decrypted keys in memory, so you only enter your passphrase once per session.

### Starting ssh-agent

#### macOS
```bash
eval "$(ssh-agent -s)"
```

#### Linux
```bash
eval "$(ssh-agent -s)"
```

#### Windows (Git Bash)
```bash
eval "$(ssh-agent -s)"
```

### Adding Your Key to ssh-agent

```bash
ssh-add ~/.ssh/id_ed25519
```

You'll be prompted:
```
Enter passphrase for /home/user/.ssh/id_ed25519:
Identity added: /home/user/.ssh/id_ed25519 (your_email@example.com)
```

Now you can use the key without entering the passphrase again in this session.

### Listing Keys in ssh-agent

```bash
ssh-add -l
```

Output shows loaded keys:
```
256 SHA256:abcd1234efgh5678... your_email@example.com (ED25519)
```

### Removing Keys from ssh-agent

Remove a specific key:
```bash
ssh-add -d ~/.ssh/id_ed25519
```

Remove all keys:
```bash
ssh-add -D
```

## Platform-Specific Passphrase Management

### macOS Keychain Integration

macOS can store your passphrase in the system Keychain.

#### Configure SSH to Use Keychain

Edit `~/.ssh/config`:
```
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
```

#### Add Key with Keychain
```bash
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
```

On older macOS versions:
```bash
ssh-add -K ~/.ssh/id_ed25519
```

**Benefits:**
- Passphrase stored securely in Keychain
- Automatically loaded on restart
- Protected by macOS security

### Linux with GNOME Keyring

If using GNOME desktop environment:

#### Install seahorse (GUI keyring manager)
```bash
# Ubuntu/Debian
sudo apt-get install seahorse

# Fedora
sudo dnf install seahorse
```

#### Enable ssh-agent integration
Add to `~/.bashrc` or `~/.zshrc`:
```bash
if [ -n "$DESKTOP_SESSION" ]; then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi
```

### Windows

#### Git Bash
ssh-agent runs in Git Bash session:
```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

#### PowerShell
Start ssh-agent service:
```powershell
Get-Service ssh-agent | Set-Service -StartupType Automatic
Start-Service ssh-agent
ssh-add ~\.ssh\id_ed25519
```

## Automatic ssh-agent Startup

### macOS/Linux

Add to `~/.bashrc`, `~/.zshrc`, or `~/.bash_profile`:

```bash
# Start ssh-agent if not running
if [ -z "$SSH_AUTH_SOCK" ] ; then
    eval "$(ssh-agent -s)" > /dev/null
fi

# Auto-add key if not already added
if ! ssh-add -l | grep -q "your_email@example.com"; then
    ssh-add ~/.ssh/id_ed25519 2>/dev/null
fi
```

For macOS with Keychain:
```bash
# macOS: Use Keychain
ssh-add --apple-load-keychain 2>/dev/null
```

## Security Best Practices

### 1. Always Use a Passphrase

**Do:**
- Use strong passphrases on personal machines
- Use passphrases for any key that could be stolen
- Use passphrases for keys with broad access

**Don't:**
- Leave keys without passphrases on laptops
- Use weak or common passphrases
- Share your passphrase with anyone

### 2. Use ssh-agent

**Benefits:**
- Convenience without sacrificing security
- Passphrase entered once per session
- Keys stored in memory, not on disk

### 3. Lock Your Screen

Since ssh-agent holds decrypted keys in memory:
- Lock your screen when away
- Use automatic screen locking
- Log out of ssh sessions when finished

### 4. Use Different Passphrases

- Don't reuse passphrases across different SSH keys
- Don't use the same passphrase as your login password
- Each key should have a unique passphrase

### 5. Secure Passphrase Storage

If you must write down passphrases:
- Use a password manager (1Password, Bitwarden, LastPass)
- Never store in plain text files
- Never commit passphrases to repositories
- Never send via email or messaging

## Recovering from Lost Passphrase

**Important**: If you lose your passphrase, **you cannot recover it**. The private key is encrypted with your passphrase.

### If You Forget Your Passphrase

1. **Generate a new SSH key pair**:
   ```bash
   ssh-keygen -t ed25519 -C "your_email@example.com" -f ~/.ssh/id_ed25519_new
   ```

2. **Add the new public key to GitHub**:
   ```bash
   cat ~/.ssh/id_ed25519_new.pub
   ```
   Copy and add to [github.com/settings/keys](https://github.com/settings/keys)

3. **Remove the old key from GitHub**
   - Go to Settings → SSH and GPG keys
   - Delete the old key

4. **Update ssh-agent**:
   ```bash
   ssh-add ~/.ssh/id_ed25519_new
   ```

5. **Optional: Remove old key files**:
   ```bash
   rm ~/.ssh/id_ed25519 ~/.ssh/id_ed25519.pub
   mv ~/.ssh/id_ed25519_new ~/.ssh/id_ed25519
   mv ~/.ssh/id_ed25519_new.pub ~/.ssh/id_ed25519.pub
   ```

## Troubleshooting Passphrase Issues

### Issue: Passphrase Prompt Every Time

**Cause**: Key not added to ssh-agent

**Solution**:
```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

### Issue: "Bad passphrase"

**Cause**: Incorrect passphrase entered

**Solutions**:
1. Try entering carefully (check Caps Lock)
2. Try copying and pasting if you have it stored
3. If forgotten, generate a new key

### Issue: ssh-agent Doesn't Persist

**macOS**: Use Keychain integration (see above)

**Linux**: Add to startup scripts (see above)

**Windows**: Set ssh-agent to start automatically

### Issue: Multiple Passphrase Prompts

**Cause**: Multiple keys, each with different passphrases

**Solution**:
```bash
# Add all keys to agent
ssh-add ~/.ssh/id_ed25519
ssh-add ~/.ssh/id_ed25519_work
ssh-add ~/.ssh/id_rsa

# Or use config to specify which key for which host
```

### Issue: Can't Remember Which Key Has Passphrase

**Check which keys have passphrases**:
```bash
ssh-keygen -y -f ~/.ssh/id_ed25519
```

If it prompts for passphrase, the key is encrypted.
If it displays the public key immediately, there's no passphrase.

## Advanced: Passphrase-less Keys for Automation

For automated systems (CI/CD, servers), you have options:

### Option 1: Deploy Keys (Recommended)
- Repository-specific access
- No user account required
- Easy to rotate
- See [Managing Deploy Keys](./managing-deploy-keys.md)

### Option 2: Passphrase-less Key with Restricted Access
```bash
# Generate key without passphrase
ssh-keygen -t ed25519 -C "ci-bot@example.com" -N "" -f ~/.ssh/id_ed25519_ci

# Add to GitHub with minimal permissions
# Use only for CI/CD purposes
# Store securely (secrets management)
```

### Option 3: SSH Certificates
- Short-lived credentials
- Centralized management
- Advanced setup
- Requires certificate authority

## Testing Passphrase Protection

Verify your key has a passphrase:

```bash
ssh-keygen -y -f ~/.ssh/id_ed25519
```

**If protected**: Prompts for passphrase
**If not protected**: Immediately displays public key

## Next Steps

- [Test your SSH connection](./testing-ssh-connection.md)
- [Learn about SSH agent forwarding](./ssh-agent-forwarding.md)
- [Set up deploy keys for servers](./managing-deploy-keys.md)

## Additional Resources

- [GitHub: Working with SSH Key Passphrases](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/working-with-ssh-key-passphrases)
- [SSH Academy: SSH Key Passphrases](https://www.ssh.com/academy/ssh/passphrase)
- [OpenSSH Manual: ssh-keygen](https://man.openbsd.org/ssh-keygen)
- [OpenSSH Manual: ssh-add](https://man.openbsd.org/ssh-add)
