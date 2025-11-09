# Generating a New SSH Key and Adding It to the SSH Agent

This guide walks you through generating a new SSH key and adding it to your SSH agent for secure authentication with GitHub.

## Prerequisites

- A terminal or command line interface
- SSH client installed (comes pre-installed on macOS, Linux, and Windows 10+)
- [Checked for existing SSH keys](./checking-for-existing-ssh-keys.md)

## Step 1: Generate Your SSH Key

### Recommended: Ed25519 Algorithm

Generate a new SSH key using the Ed25519 algorithm:

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

**Parameters explained:**
- `-t ed25519`: Specifies the Ed25519 algorithm (recommended)
- `-C "your_email@example.com"`: Adds a label/comment (use your GitHub email)

### Alternative: RSA Algorithm

If your system doesn't support Ed25519 (older systems), use RSA with 4096 bits:

```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

**Parameters explained:**
- `-t rsa`: Specifies the RSA algorithm
- `-b 4096`: Sets the key length to 4096 bits
- `-C "your_email@example.com"`: Adds a label/comment

## Step 2: Choose a File Location

After running the command, you'll see:

```
Generating public/private ed25519 key pair.
Enter file in which to save the key (/home/user/.ssh/id_ed25519):
```

**Options:**
1. **Press Enter** to accept the default location (`~/.ssh/id_ed25519`)
2. **Type a custom path** if you want to use a different location or manage multiple keys

### Default Locations

- Ed25519: `~/.ssh/id_ed25519`
- RSA: `~/.ssh/id_rsa`

### Custom Location Example

If you want multiple keys (e.g., for work and personal):

```
Enter file in which to save the key (/home/user/.ssh/id_ed25519): /home/user/.ssh/id_ed25519_work
```

## Step 3: Enter a Secure Passphrase

You'll be prompted to enter a passphrase:

```
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
```

### Why Use a Passphrase?

- **Security Layer**: Even if someone steals your private key file, they can't use it without the passphrase
- **Best Practice**: Always use a strong passphrase
- **ssh-agent**: You only need to enter it once per session when using ssh-agent

### Passphrase Best Practices

✅ **Good passphrases:**
- At least 12-16 characters
- Mix of letters, numbers, and symbols
- Memorable but not easily guessable
- Example: "MyC@t!sN4medWh1skers2024"

❌ **Avoid:**
- Leaving it empty (not recommended)
- Dictionary words
- Personal information (birthdate, name, etc.)
- Short passphrases (less than 8 characters)

## Step 4: Verify Key Generation

After entering your passphrase, you should see output like:

```
Your identification has been saved in /home/user/.ssh/id_ed25519
Your public key has been saved in /home/user/.ssh/id_ed25519.pub
The key fingerprint is:
SHA256:abcd1234efgh5678ijkl9012mnop3456qrst7890uvwx your_email@example.com
The key's randomart image is:
+--[ED25519 256]--+
|    .o.          |
|   .  o          |
|  . .. .         |
| . o. o          |
|  +.o.o S        |
| ..=.= + .       |
|  o.B.* o        |
| . *oB.=         |
|  E.=*B+.        |
+----[SHA256]-----+
```

You now have two files:
- **Private key**: `~/.ssh/id_ed25519` (keep this secret!)
- **Public key**: `~/.ssh/id_ed25519.pub` (this is what you share)

## Step 5: Add Your SSH Key to the SSH Agent

The SSH agent manages your SSH keys and remembers your passphrase so you don't have to enter it repeatedly.

### macOS

#### Start the SSH Agent

```bash
eval "$(ssh-agent -s)"
```

You should see output like:
```
Agent pid 12345
```

#### Configure SSH to Use Keychain (macOS 10.12+)

First, check if `~/.ssh/config` exists:

```bash
ls ~/.ssh/config
```

If it doesn't exist, create it:

```bash
touch ~/.ssh/config
```

Add this configuration:

```bash
cat >> ~/.ssh/config << EOF
Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
EOF
```

**Note**: If you're not using macOS Sierra 10.12.2 or later, omit the `UseKeychain yes` line.

#### Add Your SSH Key

```bash
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
```

On older macOS versions, use:
```bash
ssh-add -K ~/.ssh/id_ed25519
```

If you didn't use the default filename:
```bash
ssh-add --apple-use-keychain ~/.ssh/id_ed25519_work
```

### Linux

#### Start the SSH Agent

```bash
eval "$(ssh-agent -s)"
```

You should see:
```
Agent pid 12345
```

#### Add Your SSH Key

```bash
ssh-add ~/.ssh/id_ed25519
```

If you used a custom filename:
```bash
ssh-add ~/.ssh/id_ed25519_work
```

### Windows (Git Bash or PowerShell)

#### Git Bash

Start the SSH agent:
```bash
eval "$(ssh-agent -s)"
```

Add your key:
```bash
ssh-add ~/.ssh/id_ed25519
```

#### PowerShell

Start the SSH agent (run as Administrator):
```powershell
Get-Service -Name ssh-agent | Set-Service -StartupType Automatic
Start-Service ssh-agent
```

Add your key:
```powershell
ssh-add ~\.ssh\id_ed25519
```

## Step 6: Verify the Key Was Added

List all keys currently managed by the SSH agent:

```bash
ssh-add -l
```

You should see output like:
```
256 SHA256:abcd1234efgh5678ijkl9012mnop3456qrst7890uvwx your_email@example.com (ED25519)
```

## Complete Example Workflow

Here's a complete example from start to finish:

```bash
# 1. Generate the key
ssh-keygen -t ed25519 -C "your_email@example.com"

# 2. Press Enter to accept default location
# 3. Enter a strong passphrase (twice)

# 4. Start SSH agent
eval "$(ssh-agent -s)"

# 5. Add key to agent
ssh-add ~/.ssh/id_ed25519

# 6. Display your public key to copy it
cat ~/.ssh/id_ed25519.pub
```

## Managing Multiple SSH Keys

If you need multiple keys (for different accounts or services):

### Generate with Different Names

```bash
# Personal GitHub
ssh-keygen -t ed25519 -C "personal@example.com" -f ~/.ssh/id_ed25519_personal

# Work GitHub
ssh-keygen -t ed25519 -C "work@company.com" -f ~/.ssh/id_ed25519_work
```

### Configure SSH Config

Edit `~/.ssh/config`:

```
# Personal GitHub
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_personal
  AddKeysToAgent yes

# Work GitHub
Host github-work
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_work
  AddKeysToAgent yes
```

### Add All Keys to Agent

```bash
ssh-add ~/.ssh/id_ed25519_personal
ssh-add ~/.ssh/id_ed25519_work
```

## Common Issues and Solutions

### Issue: "Could not open a connection to your authentication agent"

**Solution**: Start the SSH agent first:
```bash
eval "$(ssh-agent -s)"
```

### Issue: "Permission denied (publickey)"

**Causes**:
1. Key not added to agent
2. Wrong permissions on SSH files
3. Key not added to GitHub account

**Solutions**:
```bash
# Add key to agent
ssh-add ~/.ssh/id_ed25519

# Fix permissions
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub

# Verify key is loaded
ssh-add -l
```

### Issue: "Bad passphrase" or can't remember passphrase

If you forgot your passphrase, you cannot recover it. You'll need to:
1. Generate a new SSH key pair
2. Add the new public key to GitHub
3. Remove the old key from GitHub

### Issue: ssh-add: illegal option -- K

On newer macOS versions, use `--apple-use-keychain` instead of `-K`:
```bash
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
```

## Security Best Practices

1. **Always use a passphrase** to protect your private key
2. **Never share your private key** (`id_ed25519` or `id_rsa`)
3. **Keep backups** of your keys in a secure location (encrypted storage)
4. **Use different keys** for different security contexts
5. **Set proper file permissions**:
   ```bash
   chmod 700 ~/.ssh
   chmod 600 ~/.ssh/id_ed25519
   chmod 644 ~/.ssh/id_ed25519.pub
   ```

## What's in Your Public Key?

Your public key file (`id_ed25519.pub`) contains:
```
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGhvbWVicmV3L2FkbWluIHBhc3N3b3JkIG5vdCBleHBvc2Vk your_email@example.com
```

Parts:
1. **Algorithm**: `ssh-ed25519`
2. **Key data**: `AAAAC3NzaC1lZDI1NTE5...` (the actual public key)
3. **Comment**: `your_email@example.com` (identifier/label)

## Next Steps

Now that you've generated your SSH key and added it to the SSH agent:

1. [Add your SSH key to your GitHub account](./adding-ssh-key-to-github.md)
2. [Test your SSH connection](./testing-ssh-connection.md)
3. Learn about [Working with SSH key passphrases](./ssh-key-passphrases.md)

## Additional Resources

- [GitHub Documentation: Generating a New SSH Key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
- [OpenSSH Manual: ssh-keygen](https://man.openbsd.org/ssh-keygen)
- [SSH Academy: SSH Keys](https://www.ssh.com/academy/ssh-keys)
