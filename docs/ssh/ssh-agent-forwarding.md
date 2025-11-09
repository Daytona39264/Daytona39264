# Using SSH Agent Forwarding

SSH agent forwarding allows you to use your local SSH keys on a remote server without copying your private keys to that server. This is useful when you need to access Git repositories from a remote server.

## What is SSH Agent Forwarding?

SSH agent forwarding securely forwards your local SSH authentication to a remote server, allowing the remote server to use your local SSH keys for authentication to other services.

### How It Works

1. **You connect** to a remote server via SSH
2. **Agent forwarding is enabled** during the connection
3. **Remote server can use** your local SSH keys (without having access to the private keys themselves)
4. **You can interact** with Git repositories from the remote server using your local credentials

### Example Scenario

```
Your Local Machine → Remote Server → GitHub
   (has SSH key)    (agent forward)   (authenticates)
```

You can clone/push/pull from GitHub on the remote server using your local SSH key, without copying your private key to the server.

## When to Use Agent Forwarding

### Good Use Cases

✅ **Deploying from a bastion/jump host**
- Access GitHub from a server behind a firewall
- Deploy code from a staging/build server

✅ **Temporary access on trusted servers**
- Your own VPS or cloud instance
- Company-owned development servers

✅ **Development environments**
- Remote development setups
- Cloud-based IDEs

### When NOT to Use Agent Forwarding

❌ **Shared or untrusted servers**
- Anyone with root access on the remote server can use your forwarded credentials
- Multi-tenant systems
- Servers you don't fully control

❌ **Production servers**
- Use [deploy keys](./managing-deploy-keys.md) instead
- More secure and auditable

❌ **Long-running processes**
- Agent forwarding only works while you're connected
- Use deploy keys for continuous deployment

## Security Considerations

### Risks

1. **Root access vulnerability**: Anyone with root/sudo on the remote server can hijack your agent socket
2. **Session hijacking**: While connected, others could potentially use your forwarded credentials
3. **No audit trail**: Actions appear to come from your account but from the remote server

### Mitigation Strategies

1. **Only use on trusted servers you control**
2. **Disconnect when not actively using**
3. **Use time-limited agent forwarding**
4. **Prefer deploy keys for automated tasks**
5. **Monitor your GitHub security log**

### Safer Alternatives

- **Deploy Keys**: Repository-specific, read-only or read-write access
- **SSH Certificates**: Short-lived, auditable credentials
- **HTTPS with Personal Access Tokens**: Can be scoped and revoked easily

## Enabling SSH Agent Forwarding

### Method 1: Command Line Flag

Enable forwarding for a single connection:

```bash
ssh -A user@remote-server.com
```

**Parameters:**
- `-A`: Enable agent forwarding for this connection

### Method 2: SSH Config File

Enable for specific hosts in `~/.ssh/config`:

```
Host trusted-server
    HostName server.example.com
    User username
    ForwardAgent yes

Host github.com
    ForwardAgent no
```

**Best practice**: Only enable for specific, trusted hosts, not globally.

### Method 3: Global (Not Recommended)

Enable for all connections (insecure):

```
Host *
    ForwardAgent yes
```

**Warning**: This forwards your agent to every SSH connection. Only use if you understand the risks.

## Testing Agent Forwarding

### Step 1: Verify Local ssh-agent

On your local machine:

```bash
ssh-add -l
```

You should see your SSH key listed:
```
256 SHA256:abcd1234... your_email@example.com (ED25519)
```

### Step 2: Connect with Forwarding

```bash
ssh -A user@remote-server.com
```

### Step 3: Verify on Remote Server

Once connected to the remote server:

```bash
ssh-add -l
```

You should see the same key from your local machine.

### Step 4: Test GitHub Connection

On the remote server:

```bash
ssh -T git@github.com
```

You should see:
```
Hi your-username! You've successfully authenticated, but GitHub does not provide shell access.
```

## Practical Example

### Scenario: Deploying Code from a Remote Server

#### Setup

**Local machine** (`~/.ssh/config`):
```
Host deploy-server
    HostName deploy.example.com
    User deployer
    ForwardAgent yes
    IdentityFile ~/.ssh/id_ed25519
```

#### Workflow

1. **Connect to remote server**:
   ```bash
   ssh deploy-server
   ```

2. **On remote server, clone repository**:
   ```bash
   git clone git@github.com:username/private-repo.git
   ```

3. **Make changes and push**:
   ```bash
   cd private-repo
   # make changes
   git add .
   git commit -m "Update deployment"
   git push origin main
   ```

All Git operations use your local SSH key via agent forwarding.

## Using with Multiple Keys

If you have multiple SSH keys for different GitHub accounts:

### Local Configuration

`~/.ssh/config`:
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

# Deploy Server
Host deploy-server
    HostName deploy.example.com
    User deployer
    ForwardAgent yes
```

### Remote Server Configuration

On the remote server, create `~/.ssh/config`:

```
# Personal repos
Host github.com
    HostName github.com
    User git

# Work repos
Host github-work
    HostName github.com
    User git
```

### Usage

For personal repos:
```bash
git clone git@github.com:personal-user/repo.git
```

For work repos:
```bash
git clone git@github-work:company/repo.git
```

## Troubleshooting

### Issue: "Permission denied (publickey)" on Remote Server

**Diagnosis**:
```bash
# On remote server
echo $SSH_AUTH_SOCK
ssh-add -l
```

**If `SSH_AUTH_SOCK` is empty**:
- Agent forwarding is not enabled
- Use `ssh -A` or configure `~/.ssh/config`

**If `ssh-add -l` shows "Could not open connection"**:
- ssh-agent is not running locally
- Start it: `eval "$(ssh-agent -s)"`
- Add key: `ssh-add ~/.ssh/id_ed25519`

### Issue: Agent Forwarding Works Initially but Stops

**Cause**: SSH connection dropped or you disconnected

**Solution**: Agent forwarding only works while connected. Reconnect:
```bash
ssh -A user@remote-server.com
```

### Issue: "WARNING: Agent forwarding is disabled"

**Cause**: Server's SSH configuration doesn't allow agent forwarding

**Solution**: Server admin must enable it in `/etc/ssh/sshd_config`:
```
AllowAgentForwarding yes
```

Then restart SSH service:
```bash
sudo systemctl restart sshd
```

### Issue: Multiple Keys, Wrong One Being Used

**Check which keys are available**:
```bash
ssh-add -l
```

**Force specific key**:
```bash
# On local machine
ssh-add -D  # Remove all keys
ssh-add ~/.ssh/id_ed25519_work  # Add only the one you need
ssh -A user@remote-server.com
```

### Issue: Agent Forwarding Security Warning

Modern SSH may show warnings about agent forwarding security.

**Acknowledge the risk** and only use on trusted servers, or:

**Use ProxyJump instead** (more secure):
```
Host github-via-jumphost
    HostName github.com
    User git
    ProxyJump user@jumphost.example.com
    IdentityFile ~/.ssh/id_ed25519
```

## Advanced: Agent Forwarding with tmux/screen

When using terminal multiplexers, agent forwarding can break when you detach/reattach.

### Problem

1. Connect with agent forwarding: `ssh -A user@server`
2. Start tmux: `tmux`
3. Detach: `Ctrl-b d`
4. Reconnect: `ssh -A user@server`
5. Reattach: `tmux attach`
6. `$SSH_AUTH_SOCK` is now stale

### Solution: Update SSH_AUTH_SOCK

Add to `~/.bashrc` or `~/.zshrc`:

```bash
# Update SSH_AUTH_SOCK for tmux
if [ -n "$TMUX" ]; then
    function refresh_auth_sock() {
        local old_sock=$SSH_AUTH_SOCK
        export SSH_AUTH_SOCK=$(tmux show-environment | grep '^SSH_AUTH_SOCK' | cut -d= -f2)
        if [ -z "$SSH_AUTH_SOCK" ]; then
            export SSH_AUTH_SOCK=$old_sock
        fi
    }
else
    function refresh_auth_sock() {
        :
    }
fi

# Call before SSH/Git operations
alias ssh='refresh_auth_sock; command ssh'
alias git='refresh_auth_sock; command git'
```

Or use a helper script:

```bash
# ~/.tmux.conf
set -g update-environment "SSH_AUTH_SOCK SSH_CONNECTION"
```

## Alternatives to Agent Forwarding

### 1. Deploy Keys (Recommended for Servers)

**Pros:**
- Repository-specific access
- No user credentials on server
- Can be read-only
- Better audit trail

**Cons:**
- Need separate key per repository
- Manual setup required

**Setup**: See [Managing Deploy Keys](./managing-deploy-keys.md)

### 2. ProxyJump (Recommended for Jump Hosts)

More secure than agent forwarding for bastion hosts:

`~/.ssh/config`:
```
Host private-server
    HostName 10.0.1.5
    User developer
    ProxyJump bastion.example.com
    IdentityFile ~/.ssh/id_ed25519
```

Connect directly to private server through bastion:
```bash
ssh private-server
```

### 3. Personal Access Tokens (HTTPS)

For temporary access:

```bash
# Clone with HTTPS
git clone https://github.com/username/repo.git

# Use token instead of password
Username: your-username
Password: ghp_yourPersonalAccessToken
```

**Pros:**
- Can be scoped (read-only, specific repos)
- Easy to revoke
- No SSH setup needed

**Cons:**
- Token must be stored or cached
- HTTPS instead of SSH

## SSH Agent Forwarding Checklist

Before using agent forwarding:

- [ ] Do you trust the remote server completely?
- [ ] Do you have root/admin access to the server?
- [ ] Is this a temporary connection (not automated)?
- [ ] Have you considered deploy keys or other alternatives?
- [ ] Is agent forwarding enabled in your SSH config?
- [ ] Have you tested the connection?
- [ ] Will you disconnect when finished?

If you answered "yes" to all questions, agent forwarding might be appropriate.

## Best Practices

1. **Selective Forwarding**: Only enable for specific trusted hosts
2. **Time-Limited Sessions**: Disconnect when not actively using
3. **Monitor Usage**: Check GitHub security logs for unexpected activity
4. **Use Deploy Keys**: For production servers and automated deployments
5. **Principle of Least Privilege**: Only forward when necessary
6. **Audit Regularly**: Review which servers have access via your keys

## Monitoring and Auditing

### Check GitHub Security Log

Visit [github.com/settings/security-log](https://github.com/settings/security-log) to see:
- Git operations performed
- IP addresses used
- Timestamps

Look for:
- Unexpected IP addresses
- Operations you didn't perform
- Activity during times you weren't connected

### Check SSH Key Usage

Visit [github.com/settings/keys](https://github.com/settings/keys) to see:
- When each key was last used
- Which keys haven't been used recently

## Example: Bastion Host Setup

Common pattern for accessing private networks:

### Architecture

```
Local Machine → Bastion Host → Private Server → GitHub
```

### Configuration

`~/.ssh/config`:
```
# Bastion host
Host bastion
    HostName bastion.example.com
    User admin
    IdentityFile ~/.ssh/id_ed25519_bastion

# Private server via bastion
Host private-server
    HostName 10.0.1.5
    User developer
    ProxyJump bastion
    ForwardAgent yes
    IdentityFile ~/.ssh/id_ed25519
```

### Usage

```bash
# Connect to private server through bastion
ssh private-server

# Now on private server, access GitHub
git clone git@github.com:company/private-repo.git
```

## Next Steps

- Learn about [Managing Deploy Keys](./managing-deploy-keys.md) for server-based Git access
- Review [SSH Key Passphrases](./ssh-key-passphrases.md) for additional security
- Explore [Testing Your SSH Connection](./testing-ssh-connection.md) for troubleshooting

## Additional Resources

- [GitHub: SSH Agent Forwarding](https://docs.github.com/en/developers/overview/using-ssh-agent-forwarding)
- [SSH Academy: Agent Forwarding](https://www.ssh.com/academy/ssh/agent)
- [OpenSSH Manual: SSH Config](https://man.openbsd.org/ssh_config)
- [ProxyJump Documentation](https://man.openbsd.org/ssh_config#ProxyJump)
