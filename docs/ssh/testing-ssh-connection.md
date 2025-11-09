# Testing Your SSH Connection

After setting up your SSH keys, it's important to test the connection to ensure everything is working correctly before attempting to clone, push, or pull from repositories.

## Prerequisites

- [Generated an SSH key](./generating-a-new-ssh-key.md)
- [Added the SSH key to your GitHub account](./adding-ssh-key-to-github.md)
- SSH key added to your ssh-agent

## Quick Test

The simplest way to test your SSH connection to GitHub:

```bash
ssh -T git@github.com
```

## Expected Results

### Successful Connection

If everything is set up correctly, you'll see:

```
Hi username! You've successfully authenticated, but GitHub does not provide shell access.
```

**What this means:**
- ✅ SSH connection is working
- ✅ Your key is properly configured
- ✅ GitHub recognizes your account
- ✅ You can now use Git with SSH

The message "does not provide shell access" is normal - GitHub doesn't allow interactive SSH sessions, only Git operations.

### First-Time Connection

On your first connection, you'll see a warning about host authenticity:

```
The authenticity of host 'github.com (140.82.121.4)' can't be established.
ED25519 key fingerprint is SHA256:+DiY3wvvV6TuJJhbpZisF/zLDA0zPMSvHdkr4UvCOqU.
This key fingerprint is SHA256:+DiY3wvvV6TuJJhbpZisF/zLDA0zPMSvHdkr4UvCOqU.
Are you sure you want to continue connecting (yes/no/[fingerprint])?
```

**What to do:**
1. **Verify the fingerprint** matches [GitHub's SSH key fingerprints](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints)
2. **Type `yes`** and press Enter
3. The host will be added to your `~/.ssh/known_hosts` file

GitHub's official Ed25519 fingerprint:
```
SHA256:+DiY3wvvV6TuJJhbpZisF/zLDA0zPMSvHdkr4UvCOqU
```

## Common Issues and Solutions

### Issue 1: Permission Denied (publickey)

```
git@github.com: Permission denied (publickey).
```

**Possible causes and solutions:**

#### 1. SSH key not added to GitHub

**Check**: Go to [github.com/settings/keys](https://github.com/settings/keys)

**Solution**: [Add your SSH key to GitHub](./adding-ssh-key-to-github.md)

#### 2. SSH key not added to ssh-agent

**Check**:
```bash
ssh-add -l
```

If you see "The agent has no identities", your key isn't loaded.

**Solution**:
```bash
ssh-add ~/.ssh/id_ed25519
```

#### 3. Wrong key being used

**Check which key SSH is trying to use**:
```bash
ssh -vT git@github.com
```

Look for lines like:
```
Offering public key: /home/user/.ssh/id_rsa
```

**Solution**: Specify the correct key:
```bash
ssh -i ~/.ssh/id_ed25519 -T git@github.com
```

Or configure `~/.ssh/config`:
```
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519
```

#### 4. Incorrect file permissions

**Check permissions**:
```bash
ls -la ~/.ssh/
```

Private key should be `-rw-------` (600)
Public key should be `-rw-r--r--` (644)

**Solution**:
```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
```

#### 5. SSH key added to wrong GitHub account

If you have multiple GitHub accounts, you might have added the key to the wrong one.

**Solution**:
- Remove the key from the incorrect account
- Add it to the correct account
- Or generate a new key for the second account

### Issue 2: Connection Timeout

```
ssh: connect to host github.com port 22: Connection timed out
```

**Possible causes:**
- Firewall blocking port 22
- Network restrictions
- ISP blocking SSH

**Solution**: Use GitHub's SSH over HTTPS port:

Edit `~/.ssh/config`:
```
Host github.com
  Hostname ssh.github.com
  Port 443
  User git
```

Test again:
```bash
ssh -T git@github.com
```

Or test the alternate port directly:
```bash
ssh -T -p 443 git@ssh.github.com
```

### Issue 3: Host Key Verification Failed

```
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
```

**Cause**: GitHub's host key has changed in your `known_hosts` file

**Solution**:
1. **Remove the old entry**:
   ```bash
   ssh-keygen -R github.com
   ```

2. **Connect again** and verify the fingerprint:
   ```bash
   ssh -T git@github.com
   ```

### Issue 4: No Route to Host

```
ssh: connect to host github.com port 22: No route to host
```

**Possible causes:**
- No internet connection
- DNS resolution issues
- Network firewall

**Solutions**:
1. **Check internet connection**:
   ```bash
   ping github.com
   ```

2. **Check DNS**:
   ```bash
   nslookup github.com
   ```

3. **Try using IP directly**:
   ```bash
   ssh -T git@140.82.121.3
   ```

### Issue 5: "Are you sure you want to continue connecting?"

This appears on first connection and is **normal**.

**Solution**: Type `yes` (not just `y`) and press Enter

## Verbose Testing

For detailed debugging information, use verbose mode:

```bash
ssh -vT git@github.com
```

### Understanding Verbose Output

**Key sections to look for:**

#### 1. SSH Keys Being Tried
```
debug1: Offering public key: /home/user/.ssh/id_ed25519 ED25519
debug1: Server accepts key: /home/user/.ssh/id_ed25519 ED25519
debug1: Authentication succeeded (publickey).
```

#### 2. Connection Details
```
debug1: Connecting to github.com [140.82.121.3] port 22.
debug1: Connection established.
```

#### 3. Authentication Success
```
debug1: Authentication succeeded (publickey).
Authenticated to github.com ([140.82.121.3]:22).
```

### Even More Verbose

For extreme debugging:
```bash
ssh -vvv -T git@github.com
```

This provides extensive details about:
- Key exchange
- Cipher negotiation
- Authentication attempts
- Configuration file parsing

## Testing with Specific Keys

If you have multiple SSH keys, test with a specific one:

```bash
ssh -i ~/.ssh/id_ed25519 -T git@github.com
```

Or for work keys:
```bash
ssh -i ~/.ssh/id_ed25519_work -T git@github-work
```

## Testing Multiple GitHub Accounts

If you use SSH config for multiple accounts:

### Personal Account
```bash
ssh -T git@github.com
```

Expected:
```
Hi personal-username! You've successfully authenticated...
```

### Work Account
```bash
ssh -T git@github-work
```

Expected:
```
Hi work-username! You've successfully authenticated...
```

## Verifying SSH Config

Display your SSH configuration:

```bash
ssh -G git@github.com
```

This shows the exact configuration SSH will use, including:
- Hostname
- Port
- User
- IdentityFile
- Other settings

## Testing Cloning

After successful SSH test, try cloning a repository:

```bash
git clone git@github.com:username/repository.git
```

### Switching from HTTPS to SSH

If you have an existing repository using HTTPS, switch to SSH:

#### Check Current Remote
```bash
git remote -v
```

You'll see:
```
origin  https://github.com/username/repository.git (fetch)
origin  https://github.com/username/repository.git (push)
```

#### Switch to SSH
```bash
git remote set-url origin git@github.com:username/repository.git
```

#### Verify
```bash
git remote -v
```

Now you'll see:
```
origin  git@github.com:username/repository.git (fetch)
origin  git@github.com:username/repository.git (push)
```

#### Test
```bash
git fetch
```

## Platform-Specific Issues

### macOS

**Issue**: ssh-agent not persisting keys after restart

**Solution**: Configure SSH to use macOS Keychain:

Edit `~/.ssh/config`:
```
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
```

### Windows (Git Bash)

**Issue**: ssh-agent not running

**Solution**:
```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

### Linux

**Issue**: ssh-agent not starting automatically

**Solution**: Add to `~/.bashrc` or `~/.zshrc`:
```bash
if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519
fi
```

## Security Verification

### Verify GitHub's SSH Key Fingerprints

Always verify you're connecting to the real GitHub:

**Official GitHub SSH key fingerprints:**

- **RSA**: `SHA256:nThbg6kXUpJWGl7E1IGOCspRomTxdCARLviKw6E5SY8`
- **Ed25519**: `SHA256:+DiY3wvvV6TuJJhbpZisF/zLDA0zPMSvHdkr4UvCOqU`
- **ECDSA**: `SHA256:p2QAMXNIC1TJYWeIOttrVc98/R1BUFWu3/LiyKgUfQM`

Check the fingerprint:
```bash
ssh-keyscan github.com | ssh-keygen -lf -
```

### Monitor for Suspicious Activity

Regularly check:
1. [GitHub SSH keys](https://github.com/settings/keys) - Remove unknown keys
2. [Security log](https://github.com/settings/security-log) - Review recent activity
3. Key usage dates - Identify stale or compromised keys

## Complete Testing Checklist

Use this checklist to verify your SSH setup:

- [ ] SSH key generated
- [ ] Public key added to GitHub account
- [ ] Private key added to ssh-agent
- [ ] `ssh -T git@github.com` succeeds
- [ ] Correct GitHub username appears in message
- [ ] Can clone a test repository
- [ ] Can push to a repository
- [ ] Can pull from a repository
- [ ] SSH config file configured (if using multiple keys)
- [ ] File permissions are correct (600 for private key)

## Next Steps

Once your SSH connection is working:

1. Start using SSH URLs for Git operations
2. Learn about [SSH key passphrases](./ssh-key-passphrases.md)
3. Explore [SSH agent forwarding](./ssh-agent-forwarding.md) for advanced use cases
4. Set up [deploy keys](./managing-deploy-keys.md) for servers

## Additional Resources

- [GitHub SSH Key Fingerprints](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints)
- [GitHub Documentation: Testing SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/testing-your-ssh-connection)
- [Troubleshooting SSH](https://docs.github.com/en/authentication/troubleshooting-ssh)
- [Using SSH over HTTPS port](https://docs.github.com/en/authentication/troubleshooting-ssh/using-ssh-over-the-https-port)
