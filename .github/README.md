# GitHub Configuration

This directory contains GitHub-specific configurations for the repository.

## Structure

```
.github/
├── workflows/           # GitHub Actions workflows
│   ├── claude-code.yml  # Claude Code AI assistant
│   └── codeql.yml       # Code security scanning
├── scripts/             # Automation scripts
│   └── claude-code-handler.js  # Claude Code handler
├── ISSUE_TEMPLATE/      # Issue templates
├── agents/              # Custom agent templates
├── CONTRIBUTING.md      # Contribution guidelines
├── ISSUES.md           # Issue management guide
└── PERFORMANCE.md      # Performance guidelines
```

## Workflows

### Claude Code (`claude-code.yml`)
AI-powered code assistance for Pull Requests and Issues.

**Triggers:**
- Comment with `@claude-code [instruction]` on any PR
- Add `claude-code` label to a PR
- Automatically on CI failures (optional)

**Setup:**
1. Add `ANTHROPIC_API_KEY` to repository secrets
2. See [docs/claude-code/SETUP.md](../docs/claude-code/SETUP.md) for details

**Examples:**
```
@claude-code Fix the failing TypeScript errors
@claude-code Refactor this function to improve readability
@claude-code Add input validation with error messages
```

### CodeQL (`codeql.yml`)
Automated security scanning for vulnerabilities.

## Scripts

### claude-code-handler.js
Node.js handler that processes Claude Code requests:
- Gathers PR context (diff, files, CI status)
- Calls Anthropic API with appropriate context
- Executes file operations via tool use
- Commits and pushes changes
- Posts status updates on PRs

**Requirements:**
- Node.js 18+
- `@anthropic-ai/sdk` package
- GitHub CLI (`gh`)

## Templates

### Issue Templates
Pre-configured templates for:
- Bug reports
- Feature requests
- Questions

### Agent Templates
Custom templates for GitHub Copilot agents.

## Documentation

For more information, see:
- [Claude Code Documentation](../docs/claude-code/)
- [SSH Setup Guide](../docs/ssh/)
- [Contributing Guidelines](CONTRIBUTING.md)

## Security

**Important:**
- Never commit API keys or secrets to this directory
- Use GitHub Secrets for sensitive data
- Review all workflow changes carefully
- Follow security best practices in [CONTRIBUTING.md](CONTRIBUTING.md)
