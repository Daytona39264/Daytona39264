# Managing Deploy Keys

Deploy keys are SSH keys that grant access to a single GitHub repository. They're ideal for automated deployments, CI/CD pipelines, and server-based operations.

## What are Deploy Keys?

Deploy keys are SSH keys associated with a specific repository rather than a user account. They provide repository-level access control and are commonly used for:

- Automated deployments
- CI/CD systems
- Build servers
- Production servers pulling code

### Deploy Keys vs Personal SSH Keys

| Feature | Personal SSH Keys | Deploy Keys |
|---------|------------------|-------------|
| **Scope** | All accessible repositories | Single repository |
| **Account** | Tied to user account | Tied to repository |
| **Access** | Based on user permissions | Read-only or read-write |
| **Best For** | Personal development | Automation, servers |
| **Rotation** | Affects all repos | Only one repository |
| **Audit Trail** | User's actions | Repository-specific |

## When to Use Deploy Keys

### Good Use Cases

✅ **Production/Staging Servers**
- Server needs to pull code from a specific repository
- Limited scope reduces security risk

✅ **CI/CD Pipelines**
- GitHub Actions, Jenkins, GitLab CI, CircleCI
- Automated testing and deployment

✅ **Automated Deployment Systems**
- Deployment scripts
- Configuration management (Ansible, Chef, Puppet)

✅ **Multiple Servers, Same Repository**
- Each server gets its own deploy key
- Easy to revoke access for specific servers

### When NOT to Use Deploy Keys

❌ **Personal Development**
- Use personal SSH keys instead
- More flexible for multiple repositories

❌ **Multiple Repositories**
- One deploy key per repository
- Use personal keys or machine users for multi-repo access

❌ **User-Based Operations**
- Commits should be associated with users
- Use personal keys for development

## Creating a Deploy Key

### Step 1: Generate a New SSH Key

On the server that needs access:

```bash
ssh-keygen -t ed25519 -C "deploy-key-production-server" -f ~/.ssh/deploy_key_ed25519
```

**Parameters:**
- `-t ed25519`: Key type (recommended)
- `-C "description"`: Label for the key
- `-f filename`: Specific filename for the key

**Important**: Don't use a passphrase for deploy keys (press Enter twice when prompted), since automated systems can't enter passphrases.

### Step 2: Copy the Public Key

```bash
cat ~/.ssh/deploy_key_ed25519.pub
```

Copy the entire output (starts with `ssh-ed25519`).

### Step 3: Add Deploy Key to Repository

1. **Navigate to your repository** on GitHub
2. **Click Settings** (repository settings, not your profile)
3. **Click Deploy keys** in the left sidebar
4. **Click Add deploy key**
5. **Fill in the form**:
   - **Title**: Descriptive name (e.g., "Production Server", "CI/CD Pipeline")
   - **Key**: Paste the public key
   - **Allow write access**: Check if the key needs to push code (optional)
6. **Click Add key**

### Step 4: Test the Deploy Key

On the server:

```bash
ssh -T -i ~/.ssh/deploy_key_ed25519 git@github.com
```

You should see:
```
Hi username/repository! You've successfully authenticated, but GitHub does not provide shell access.
```

Note: It shows the repository name, not your username.

### Step 5: Configure Git to Use Deploy Key

On the server, configure Git to use this key:

#### Option 1: SSH Config (Recommended)

Edit `~/.ssh/config`:

```
Host github.com-myrepo
    HostName github.com
    User git
    IdentityFile ~/.ssh/deploy_key_ed25519
    IdentitiesOnly yes
```

Clone the repository:
```bash
git clone git@github.com-myrepo:username/repository.git
```

Or update existing repository:
```bash
cd /path/to/repository
git remote set-url origin git@github.com-myrepo:username/repository.git
```

#### Option 2: GIT_SSH_COMMAND Environment Variable

```bash
export GIT_SSH_COMMAND="ssh -i ~/.ssh/deploy_key_ed25519"
git clone git@github.com:username/repository.git
```

Add to deployment scripts or `~/.bashrc`.

#### Option 3: Core.sshCommand Git Config

```bash
git config core.sshCommand "ssh -i ~/.ssh/deploy_key_ed25519 -F /dev/null"
```

This only affects the current repository.

## Read-Only vs Read-Write Deploy Keys

### Read-Only (Default)

**Permissions:**
- Clone repository
- Pull updates
- Read repository contents

**Use cases:**
- Production servers pulling code
- Build systems
- Monitoring/backup systems

**Setup:**
- Leave "Allow write access" unchecked when adding the key

### Read-Write

**Permissions:**
- Everything read-only can do
- Push commits
- Force push (if not protected)
- Create/delete branches (if not protected)

**Use cases:**
- CI/CD systems that push artifacts
- Automated version bumping
- Automated changelog generation
- Bot accounts

**Setup:**
- Check "Allow write access" when adding the key

**Security considerations:**
- Only enable when necessary
- Protect important branches (main/master)
- Use branch protection rules

## Managing Multiple Deploy Keys

### Scenario: Multiple Servers, One Repository

Each server should have its own deploy key:

**Production Server:**
```bash
ssh-keygen -t ed25519 -C "production-server" -f ~/.ssh/deploy_key_prod
```

**Staging Server:**
```bash
ssh-keygen -t ed25519 -C "staging-server" -f ~/.ssh/deploy_key_staging
```

Add both public keys to the repository with different titles:
- "Production Server - prod01.example.com"
- "Staging Server - staging01.example.com"

**Benefits:**
- Revoke access to one server without affecting others
- Track which server accessed the repository
- Different access levels (e.g., staging can be read-write, production read-only)

### Scenario: Multiple Repositories, One Server

Create separate deploy keys for each repository:

```bash
ssh-keygen -t ed25519 -C "server-repo1" -f ~/.ssh/deploy_key_repo1
ssh-keygen -t ed25519 -C "server-repo2" -f ~/.ssh/deploy_key_repo2
```

Configure SSH to use the right key:

`~/.ssh/config`:
```
Host github.com-repo1
    HostName github.com
    User git
    IdentityFile ~/.ssh/deploy_key_repo1

Host github.com-repo2
    HostName github.com
    User git
    IdentityFile ~/.ssh/deploy_key_repo2
```

Clone repositories:
```bash
git clone git@github.com-repo1:username/repo1.git
git clone git@github.com-repo2:username/repo2.git
```

## Deploy Keys in CI/CD

### GitHub Actions

GitHub Actions has built-in authentication, but you can use deploy keys for external repositories.

#### Setup

1. **Generate deploy key** (without passphrase):
   ```bash
   ssh-keygen -t ed25519 -C "github-actions" -f deploy_key -N ""
   ```

2. **Add public key to repository** as deploy key

3. **Add private key as GitHub Secret**:
   - Repository Settings → Secrets → Actions
   - Name: `DEPLOY_KEY`
   - Value: Contents of private key file

#### Workflow Usage

`.github/workflows/deploy.yml`:
```yaml
name: Deploy

on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Setup SSH
        run: |
          mkdir -p ~/.ssh
          echo "${{ secrets.DEPLOY_KEY }}" > ~/.ssh/deploy_key
          chmod 600 ~/.ssh/deploy_key
          ssh-keyscan github.com >> ~/.ssh/known_hosts

      - name: Clone private repo
        run: |
          GIT_SSH_COMMAND="ssh -i ~/.ssh/deploy_key" git clone git@github.com:username/private-repo.git
```

### GitLab CI

`.gitlab-ci.yml`:
```yaml
before_script:
  - apt-get update -qq && apt-get install -y -qq ssh
  - mkdir -p ~/.ssh
  - echo "$DEPLOY_KEY" | base64 -d > ~/.ssh/deploy_key
  - chmod 600 ~/.ssh/deploy_key
  - ssh-keyscan github.com >> ~/.ssh/known_hosts

deploy:
  script:
    - GIT_SSH_COMMAND="ssh -i ~/.ssh/deploy_key" git clone git@github.com:username/repo.git
```

### Jenkins

1. **Install SSH Agent Plugin**

2. **Add SSH Credential**:
   - Jenkins → Credentials → System → Global credentials
   - Kind: SSH Username with private key
   - ID: `github-deploy-key`
   - Username: `git`
   - Private Key: Paste deploy key

3. **Use in Pipeline**:
   ```groovy
   pipeline {
       agent any
       stages {
           stage('Checkout') {
               steps {
                   sshagent(['github-deploy-key']) {
                       sh 'git clone git@github.com:username/repo.git'
                   }
               }
           }
       }
   }
   ```

### CircleCI

`.circleci/config.yml`:
```yaml
version: 2.1

jobs:
  deploy:
    docker:
      - image: cimg/base:stable
    steps:
      - add_ssh_keys:
          fingerprints:
            - "SO:ME:FIN:GER:PR:IN:T"
      - checkout
      - run:
          name: Deploy
          command: |
            ssh-keyscan github.com >> ~/.ssh/known_hosts
            git clone git@github.com:username/repo.git
```

## Deployment Workflow Example

### Simple Pull-Based Deployment

**Server script** (`/opt/deploy/pull_updates.sh`):
```bash
#!/bin/bash

REPO_DIR="/var/www/myapp"
SSH_KEY="/home/deployer/.ssh/deploy_key_ed25519"

cd $REPO_DIR

# Pull latest changes
GIT_SSH_COMMAND="ssh -i $SSH_KEY" git pull origin main

# Run deployment steps
npm install
npm run build
sudo systemctl restart myapp

echo "Deployment completed at $(date)"
```

**Cron job** (run every 15 minutes):
```bash
crontab -e
```

Add:
```
*/15 * * * * /opt/deploy/pull_updates.sh >> /var/log/deploy.log 2>&1
```

### Webhook-Based Deployment

**Server script** (`/opt/deploy/webhook_handler.sh`):
```bash
#!/bin/bash

REPO_DIR="/var/www/myapp"
SSH_KEY="/home/deployer/.ssh/deploy_key_ed25519"
LOCK_FILE="/tmp/deploy.lock"

# Prevent concurrent deployments
if [ -f "$LOCK_FILE" ]; then
    echo "Deployment already in progress"
    exit 1
fi

touch $LOCK_FILE

cd $REPO_DIR

# Pull and deploy
GIT_SSH_COMMAND="ssh -i $SSH_KEY" git fetch origin
GIT_SSH_COMMAND="ssh -i $SSH_KEY" git reset --hard origin/main

npm install
npm run build
sudo systemctl restart myapp

rm $LOCK_FILE
echo "Deployment completed at $(date)"
```

**Webhook receiver** (using webhook):
```bash
# Install webhook: https://github.com/adnanh/webhook
# Configure in /etc/webhook/hooks.json

[
  {
    "id": "deploy-myapp",
    "execute-command": "/opt/deploy/webhook_handler.sh",
    "command-working-directory": "/var/www/myapp",
    "trigger-rule": {
      "match": {
        "type": "payload-hash-sha256",
        "secret": "your-webhook-secret",
        "parameter": {
          "source": "header",
          "name": "X-Hub-Signature-256"
        }
      }
    }
  }
]
```

## Security Best Practices

### 1. No Passphrases for Deploy Keys

Deploy keys typically don't use passphrases because:
- Automated systems can't enter passphrases
- Keys are usually protected by file permissions and server access control

**Mitigation:**
- Strict file permissions (600)
- Server-level security
- Principle of least privilege (read-only when possible)

### 2. Least Privilege

- **Read-only by default**: Only enable write access when necessary
- **Repository-specific**: One key per repository
- **Server-specific**: Different keys for different servers

### 3. Regular Auditing

Periodically review deploy keys:
- Repository Settings → Deploy keys
- Remove keys for decommissioned servers
- Rotate keys annually

### 4. Descriptive Names

Use descriptive titles that include:
- Server name/identifier
- Purpose
- Date added

**Good examples:**
- "Production Server - prod01.example.com (Added 2024-01)"
- "CI/CD - GitHub Actions (2024-11)"
- "Staging - AWS EC2 i-1234abcd (2024-10)"

### 5. File Permissions

Protect the private key:
```bash
chmod 600 ~/.ssh/deploy_key_ed25519
chmod 644 ~/.ssh/deploy_key_ed25519.pub
chown deployer:deployer ~/.ssh/deploy_key_*
```

### 6. Use Dedicated User Accounts

Create a dedicated user for deployments:
```bash
sudo useradd -m -s /bin/bash deployer
sudo su - deployer
```

Keep deploy keys in this user's `.ssh` directory.

### 7. Enable Branch Protection

For repositories with write-access deploy keys:
- Protect main/master branch
- Require pull request reviews
- Require status checks
- Prevent force pushes

## Troubleshooting

### Issue: "Key is already in use"

**Cause**: Deploy keys must be unique across all repositories.

**Solutions:**

1. **Generate a new key** for this repository:
   ```bash
   ssh-keygen -t ed25519 -C "new-deploy-key" -f ~/.ssh/deploy_key_new
   ```

2. **Remove the key from other repository** if it's no longer needed

3. **Use a machine user** for access to multiple repositories

### Issue: "Permission denied (publickey)"

**Check:**
1. **Key added to repository?** Repository Settings → Deploy keys
2. **Correct key being used?** Verify with `ssh -vT`
3. **File permissions correct?** Should be 600
4. **SSH config correct?** Check `~/.ssh/config`

**Debug:**
```bash
ssh -vT -i ~/.ssh/deploy_key_ed25519 git@github.com
```

### Issue: Deploy Key Can't Push

**Cause**: Deploy key is read-only

**Solution:**
1. Repository Settings → Deploy keys
2. Find the key
3. Click Edit (or delete and re-add)
4. Check "Allow write access"
5. Save changes

### Issue: Multiple Keys Conflict

**Solution**: Use SSH config with `IdentitiesOnly yes`:

```
Host github.com-myrepo
    HostName github.com
    User git
    IdentityFile ~/.ssh/deploy_key_ed25519
    IdentitiesOnly yes
```

This prevents SSH from trying other keys.

## Rotating Deploy Keys

Best practice: Rotate deploy keys annually or when:
- Server is compromised
- Employee with access leaves
- Key may have been exposed
- General security audit

### Rotation Process

1. **Generate new deploy key**:
   ```bash
   ssh-keygen -t ed25519 -C "deploy-key-2025" -f ~/.ssh/deploy_key_new
   ```

2. **Add new key to repository** (don't remove old one yet)

3. **Update server configuration** to use new key

4. **Test deployment** with new key

5. **Remove old key** from repository once confirmed working

6. **Delete old key files** from server:
   ```bash
   rm ~/.ssh/deploy_key_old ~/.ssh/deploy_key_old.pub
   ```

## Machine Users (Alternative)

For access to multiple repositories, consider a **machine user**:

### What is a Machine User?

- Dedicated GitHub account for automation
- Not associated with a person
- Can access multiple repositories
- Uses personal SSH keys, not deploy keys

### When to Use

- Need access to multiple repositories
- Complex CI/CD workflows
- Organization-wide automation

### Setup

1. Create new GitHub account (e.g., `acme-bot`)
2. Generate SSH key for the machine
3. Add SSH key to machine user account
4. Invite machine user to repositories
5. Grant appropriate permissions

**Note**: GitHub Free doesn't support machine users in private repos. Consider GitHub Pro or deploy keys.

## Viewing Deploy Key Activity

### Last Used

Repository Settings → Deploy keys shows:
- When key was added
- Last used timestamp
- "Never used" if not yet used

### Audit Log (GitHub Enterprise)

Organization-level audit logs show:
- Deploy key additions/removals
- Repository access via deploy keys
- Timestamp and user who added the key

## Next Steps

- Review [SSH Agent Forwarding](./ssh-agent-forwarding.md) for alternative access patterns
- Learn about [Testing SSH Connections](./testing-ssh-connection.md)
- Explore [SSH Key Passphrases](./ssh-key-passphrases.md) for personal keys

## Additional Resources

- [GitHub: Managing Deploy Keys](https://docs.github.com/en/developers/overview/managing-deploy-keys)
- [GitHub: Machine Users](https://docs.github.com/en/developers/overview/managing-deploy-keys#machine-users)
- [CI/CD Best Practices](https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions)
