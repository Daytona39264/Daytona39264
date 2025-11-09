# Adding a New SSH Key to Your GitHub Account

After generating an SSH key, you need to add the public key to your GitHub account to enable SSH access for Git operations.

## Prerequisites

- [Generated an SSH key pair](./generating-a-new-ssh-key.md)
- A GitHub account
- Access to your public key file (e.g., `~/.ssh/id_ed25519.pub`)

## Quick Overview

1. Copy your public SSH key to your clipboard
2. Navigate to GitHub SSH settings
3. Add the new SSH key
4. Test your connection

## Step 1: Copy Your SSH Public Key

### macOS

```bash
pbcopy < ~/.ssh/id_ed25519.pub
```

This copies the contents directly to your clipboard.

If `pbcopy` isn't available, display the key and copy it manually:
```bash
cat ~/.ssh/id_ed25519.pub
```

### Linux

#### Using xclip (X11)
```bash
xclip -sel clip < ~/.ssh/id_ed25519.pub
```

If `xclip` isn't installed:
```bash
# Debian/Ubuntu
sudo apt-get install xclip

# Fedora
sudo dnf install xclip

# Arch
sudo pacman -S xclip
```

#### Using wl-clipboard (Wayland)
```bash
wl-copy < ~/.ssh/id_ed25519.pub
```

#### Manual Copy
```bash
cat ~/.ssh/id_ed25519.pub
```
Then select and copy the output.

### Windows

#### Git Bash
```bash
clip < ~/.ssh/id_ed25519.pub
```

#### PowerShell
```powershell
Get-Content ~\.ssh\id_ed25519.pub | Set-Clipboard
```

#### Manual Copy
```bash
cat ~/.ssh/id_ed25519.pub
```
Then select and copy the output.

### What Your Public Key Looks Like

Your public key should look something like this:

```
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl your_email@example.com
```

Or for RSA:

```
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC9Qn... your_email@example.com
```

**Important**: Copy the entire line, including:
- The key type (`ssh-ed25519` or `ssh-rsa`)
- The key data (long string of characters)
- The comment/email at the end

## Step 2: Navigate to GitHub SSH Settings

### Via Web Interface

1. **Log in to GitHub** at [github.com](https://github.com)

2. **Click your profile photo** in the upper-right corner

3. **Click Settings**

4. **In the left sidebar**, click **SSH and GPG keys**

5. **Click New SSH key** or **Add SSH key**

### Direct Link

You can also navigate directly to: [github.com/settings/ssh/new](https://github.com/settings/ssh/new)

## Step 3: Add Your SSH Key

On the SSH key form:

### Title Field

Enter a descriptive title that helps you identify this key:

**Good examples:**
- "Personal MacBook Pro"
- "Work Laptop - Ubuntu"
- "Home Desktop - Windows"
- "CI/CD Server"

**Why this matters:**
- Helps you identify which key is which
- Makes it easier to manage and remove old keys
- Useful when you have multiple devices

### Key Type

Select the appropriate key type:
- **Authentication Key** (default) - For normal Git operations
- **Signing Key** - For commit/tag signing (advanced)

For most users, choose **Authentication Key**.

### Key Field

1. **Paste your public key** into the "Key" field
2. The key should start with `ssh-ed25519` or `ssh-rsa`
3. Make sure there are no extra spaces or line breaks

### Example

```
Title: Personal MacBook Pro
Key type: Authentication Key
Key: ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl your_email@example.com
```

## Step 4: Save the Key

1. **Click Add SSH key**

2. **Confirm your GitHub password** if prompted

3. You should see a success message: "Key is now being used by your account"

## Step 5: Verify the Key Was Added

Your new key should now appear in the list of SSH keys with:
- The title you provided
- The key fingerprint (e.g., `SHA256:abcd1234...`)
- The date it was added
- "Never used" status (will change after first use)

## Managing Multiple SSH Keys on GitHub

You can add multiple SSH keys to your GitHub account:

- Different keys for different computers
- Separate keys for work and personal projects
- Backup keys in case you lose access to one

### Adding Additional Keys

Repeat the process above for each new key:
1. Generate a new key (or use an existing one)
2. Copy the public key
3. Add it to GitHub with a descriptive title

### Example Key Organization

```
Personal MacBook Pro (Added Nov 9, 2024)
└─ ssh-ed25519 SHA256:abcd...

Work Laptop Ubuntu (Added Nov 1, 2024)
└─ ssh-ed25519 SHA256:efgh...

Home Desktop Windows (Added Oct 15, 2024)
└─ ssh-rsa SHA256:ijkl...

CI/CD Server (Added Sep 1, 2024)
└─ ssh-ed25519 SHA256:mnop...
```

## Security Best Practices

### Regular Key Audits

Periodically review your SSH keys:
1. Go to [github.com/settings/keys](https://github.com/settings/keys)
2. Remove keys you no longer use
3. Remove keys for devices you no longer own

### When to Remove Keys

Remove SSH keys when:
- You no longer use a device
- You've sold or given away a computer
- A device has been lost or stolen
- You suspect a key has been compromised
- You're replacing an old key with a new one

### How to Remove a Key

1. Go to [github.com/settings/keys](https://github.com/settings/keys)
2. Find the key you want to remove
3. Click **Delete**
4. Confirm the deletion

## Using Different GitHub Accounts

If you have multiple GitHub accounts (personal and work), you'll need:

### 1. Different SSH Keys

Generate separate keys:
```bash
ssh-keygen -t ed25519 -C "personal@example.com" -f ~/.ssh/id_ed25519_personal
ssh-keygen -t ed25519 -C "work@company.com" -f ~/.ssh/id_ed25519_work
```

### 2. Add Each Key to the Respective Account

- Log in to personal account → Add personal key
- Log in to work account → Add work key

### 3. Configure SSH Config

Edit `~/.ssh/config`:

```
# Personal GitHub
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_personal

# Work GitHub
Host github-work
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_work
```

### 4. Clone Using Different Hosts

Personal repositories:
```bash
git clone git@github.com:personal-username/repo.git
```

Work repositories:
```bash
git clone git@github-work:company/repo.git
```

## Troubleshooting

### "Key is already in use"

This error means:
- The key is already added to this account, OR
- The key is added to a different GitHub account

**Solution**:
- Generate a new SSH key
- Use a different existing key
- Remove the key from the other account (if you own it)

### "Key is invalid"

Common causes:
- Missing the key type prefix (`ssh-ed25519` or `ssh-rsa`)
- Extra whitespace or line breaks
- Copied the private key instead of public key
- Corrupted key file

**Solution**:
1. Display the public key again:
   ```bash
   cat ~/.ssh/id_ed25519.pub
   ```
2. Ensure you copy the entire line
3. Make sure it starts with `ssh-ed25519` or `ssh-rsa`

### Can't Find the Public Key File

If `cat ~/.ssh/id_ed25519.pub` shows "No such file":
1. Check for RSA keys: `cat ~/.ssh/id_rsa.pub`
2. List all SSH keys: `ls -la ~/.ssh/`
3. If no keys exist, [generate a new SSH key](./generating-a-new-ssh-key.md)

### Copied Private Key by Mistake

If you accidentally pasted your **private key** (the one WITHOUT `.pub`):
- **Delete it immediately** from GitHub
- **Never share your private key**
- The private key starts with `-----BEGIN OPENSSH PRIVATE KEY-----`
- The public key starts with `ssh-ed25519` or `ssh-rsa`

If you think your private key was exposed:
1. Remove the compromised key from GitHub
2. Generate a new SSH key pair
3. Add the new public key to GitHub

## Common Use Cases

### For Personal Projects

```bash
# 1. Generate key
ssh-keygen -t ed25519 -C "your_email@example.com"

# 2. Copy public key
cat ~/.ssh/id_ed25519.pub

# 3. Add to GitHub (via web interface)
# 4. Test connection
ssh -T git@github.com
```

### For Organization/Work Projects

```bash
# 1. Generate work-specific key
ssh-keygen -t ed25519 -C "work@company.com" -f ~/.ssh/id_ed25519_work

# 2. Add to ssh-agent
ssh-add ~/.ssh/id_ed25519_work

# 3. Copy and add to work GitHub account
cat ~/.ssh/id_ed25519_work.pub

# 4. Configure SSH config for work repos
# 5. Test connection
ssh -T git@github-work
```

### For CI/CD or Deploy Keys

For automated systems, consider using [Deploy Keys](./managing-deploy-keys.md) instead of personal SSH keys for:
- Better security (repository-specific access)
- Easier key rotation
- Clear audit trail

## Viewing Key Usage

GitHub shows when each key was last used:

1. Go to [github.com/settings/keys](https://github.com/settings/keys)
2. Each key shows:
   - **Never used** - Key hasn't been used yet
   - **Last used within the last week** - Recently active
   - **Last used within the last month** - Occasionally used
   - Specific date for older usage

This helps identify:
- Keys that are actively being used
- Stale keys that can be removed
- Suspicious activity if a key is used from an unknown location

## Next Steps

After adding your SSH key to GitHub:

1. [Test your SSH connection](./testing-ssh-connection.md) to verify everything works
2. Start using SSH URLs for Git operations:
   ```bash
   git clone git@github.com:username/repository.git
   ```
3. Learn about [SSH key passphrases](./ssh-key-passphrases.md) for enhanced security

## Additional Resources

- [GitHub Documentation: Adding SSH Key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)
- [GitHub Settings - SSH Keys](https://github.com/settings/keys)
- [GitHub Security Best Practices](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure)
