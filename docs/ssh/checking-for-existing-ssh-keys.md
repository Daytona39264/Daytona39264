# Checking for Existing SSH Keys

Before you generate a new SSH key, you should check to see if you already have SSH keys on your computer. You can use existing keys instead of creating new ones.

## Why Check First?

- You may already have SSH keys from previous setups
- Avoid creating duplicate keys
- Reuse existing keys if they're secure and up-to-date

## Checking for SSH Keys

### Step 1: Open a Terminal

- **macOS**: Open Terminal (Applications > Utilities > Terminal)
- **Windows**: Open Git Bash or PowerShell
- **Linux**: Open your preferred terminal application

### Step 2: List SSH Keys

Enter the following command to see if existing SSH keys are present:

```bash
ls -al ~/.ssh
```

This lists the files in your `.ssh` directory, if they exist.

### Step 3: Check the Directory Listing

Look for files with these names:

**Ed25519 keys (recommended):**
- `id_ed25519` (private key)
- `id_ed25519.pub` (public key)

**RSA keys:**
- `id_rsa` (private key)
- `id_rsa.pub` (public key)

**ECDSA keys:**
- `id_ecdsa` (private key)
- `id_ecdsa.pub` (public key)

**DSA keys (deprecated):**
- `id_dsa` (private key)
- `id_dsa.pub` (public key)

### Example Output

If you have existing keys, you might see output like:

```
total 24
drwx------   5 user  staff   160 Nov  9 10:00 .
drwxr-xr-x+ 45 user  staff  1440 Nov  9 09:00 ..
-rw-------   1 user  staff   411 Nov  8 12:00 id_ed25519
-rw-r--r--   1 user  staff   103 Nov  8 12:00 id_ed25519.pub
-rw-------   1 user  staff  1876 Nov  7 15:00 known_hosts
```

If you don't see any key files, you'll see an error like:

```
ls: /Users/user/.ssh: No such file or directory
```

This means you don't have any SSH keys yet and need to [generate a new SSH key](./generating-a-new-ssh-key.md).

## Understanding Your Keys

### Private Keys (No .pub Extension)

These are your **secret** keys and should never be shared:
- `id_ed25519`
- `id_rsa`
- `id_ecdsa`

**Important**:
- Keep these files secure
- Never commit them to a repository
- Never send them via email or messaging apps
- They should have restrictive permissions (600 or 400)

### Public Keys (.pub Extension)

These are **safe to share** and are what you add to GitHub:
- `id_ed25519.pub`
- `id_rsa.pub`
- `id_ecdsa.pub`

You'll copy the contents of your public key file to GitHub.

## What to Do If You Find Existing Keys

### Option 1: Use Your Existing Key

If you found an existing key and want to use it:

1. **Display the public key**:
   ```bash
   cat ~/.ssh/id_ed25519.pub
   # or
   cat ~/.ssh/id_rsa.pub
   ```

2. **Copy the output** (the entire contents starting with `ssh-ed25519` or `ssh-rsa`)

3. **Add it to GitHub** following the [Adding a New SSH Key to Your GitHub Account](./adding-ssh-key-to-github.md) guide

### Option 2: Generate a New Key

If you want to generate a new key (perhaps the existing one is old or uses an outdated algorithm):

1. **Back up your existing keys** (optional):
   ```bash
   mkdir ~/ssh_backup
   cp ~/.ssh/id_* ~/ssh_backup/
   ```

2. Follow the [Generating a New SSH Key](./generating-a-new-ssh-key.md) guide

### Option 3: Use Multiple Keys

You can have multiple SSH keys for different purposes:

- Different keys for personal and work accounts
- Different keys for different organizations
- Separate keys for different security levels

To use multiple keys, you'll need to configure your SSH config file. See the [Using Multiple SSH Keys](#using-multiple-ssh-keys) section below.

## Checking Key Permissions

SSH keys require specific file permissions for security. Check your key permissions:

```bash
ls -l ~/.ssh/id_ed25519
```

The private key should have permissions `-rw-------` (600):
- Owner can read and write
- No permissions for group or others

If permissions are incorrect, fix them:

```bash
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
```

## Verifying Key Algorithm

If you have an existing key but want to check what algorithm it uses:

```bash
ssh-keygen -l -f ~/.ssh/id_ed25519.pub
```

Output will show:
```
256 SHA256:abcd1234efgh5678ijkl9012mnop3456qrst7890uvwx1234yz your_email@example.com (ED25519)
```

The last part in parentheses shows the algorithm (ED25519, RSA, ECDSA, etc.).

For RSA keys, also check the bit length (first number). RSA keys should be at least 2048 bits, preferably 4096 bits.

## Using Multiple SSH Keys

If you need to use multiple SSH keys (for example, one for personal projects and one for work), you can configure SSH to use the right key for each host.

### Create SSH Config File

Create or edit `~/.ssh/config`:

```bash
nano ~/.ssh/config
```

### Add Host Configurations

```
# Personal GitHub account
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519

# Work GitHub account
Host github-work
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519_work

# GitLab account
Host gitlab.com
    HostName gitlab.com
    User git
    IdentityFile ~/.ssh/id_ed25519_gitlab
```

### Use Different Hosts in Git Commands

For work repositories:
```bash
git clone git@github-work:company/repository.git
```

For personal repositories:
```bash
git clone git@github.com:username/repository.git
```

## Common Issues

### No .ssh Directory

If `~/.ssh` doesn't exist, it means:
- SSH has never been set up on this computer
- You need to [generate a new SSH key](./generating-a-new-ssh-key.md)

You can create the directory manually:
```bash
mkdir -p ~/.ssh
chmod 700 ~/.ssh
```

### Permission Denied Errors

If you see "WARNING: UNPROTECTED PRIVATE KEY FILE!" or similar:
```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
```

### Multiple Keys with Same Name

If you have both `id_rsa` and `id_ed25519`, SSH will try them in order. You can specify which key to use with the `-i` flag:

```bash
ssh -i ~/.ssh/id_ed25519 -T git@github.com
```

## Next Steps

Depending on what you found:

1. **If you have existing keys**: [Add your SSH key to GitHub](./adding-ssh-key-to-github.md)
2. **If you don't have keys**: [Generate a new SSH key](./generating-a-new-ssh-key.md)
3. **If you want to test**: [Test your SSH connection](./testing-ssh-connection.md)

## Additional Resources

- [GitHub Documentation: Checking for Existing SSH Keys](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/checking-for-existing-ssh-keys)
- [SSH File Permissions](https://www.ssh.com/academy/ssh/config#file-permissions)
