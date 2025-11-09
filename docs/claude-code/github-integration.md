# Claude Code GitHub Integration

Run Claude Code directly from your GitHub Pull Requests and Issues to respond to reviewer feedback, fix CI errors, or modify code, turning it into a virtual teammate that works alongside your development pipelines.

## Overview

Claude Code's GitHub integration allows you to leverage AI-powered code assistance directly within your GitHub workflow. Built on the publicly available [Claude Code SDK](https://github.com/anthropics/anthropic-sdk-typescript), this integration enables automated responses to common development tasks.

### What Can Claude Code Do?

- **Respond to PR feedback** - Automatically address reviewer comments and suggestions
- **Fix CI/CD failures** - Analyze and resolve failing tests and build errors
- **Implement requested changes** - Make code modifications based on issue descriptions
- **Refactor code** - Apply improvements suggested in code reviews
- **Generate documentation** - Create or update docs based on PR context
- **Answer questions** - Provide explanations about code changes in PRs

## How It Works

```
GitHub PR/Issue → Claude Code Agent → Code Analysis → Changes → Commit & Push
```

1. **Trigger**: A comment, label, or event triggers Claude Code
2. **Context Gathering**: Claude Code reads the PR/issue, code diff, and CI logs
3. **Analysis**: AI analyzes the request and determines necessary changes
4. **Execution**: Code changes are made using the Claude Code SDK
5. **Response**: Changes are committed and pushed, with explanations provided

## Prerequisites

- GitHub repository with code
- Claude Code SDK installed and configured
- GitHub Actions or similar CI/CD pipeline
- API access to Claude (Anthropic API key)

## Setup

### Method 1: GitHub Actions (Recommended)

#### Step 1: Create GitHub Actions Workflow

Create `.github/workflows/claude-code.yml`:

```yaml
name: Claude Code Assistant

on:
  issue_comment:
    types: [created]
  pull_request_review_comment:
    types: [created]
  pull_request:
    types: [opened, synchronize]

jobs:
  claude-code:
    runs-on: ubuntu-latest
    # Only run on specific triggers
    if: |
      (github.event_name == 'issue_comment' && contains(github.event.comment.body, '@claude-code')) ||
      (github.event_name == 'pull_request_review_comment' && contains(github.event.comment.body, '@claude-code')) ||
      (github.event_name == 'pull_request' && contains(github.event.pull_request.labels.*.name, 'claude-code'))

    permissions:
      contents: write
      pull-requests: write
      issues: write

    steps:
      - name: Checkout code
        uses: actions/checkout@v4
        with:
          ref: ${{ github.event.pull_request.head.ref || github.ref }}
          token: ${{ secrets.GITHUB_TOKEN }}

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'

      - name: Install Claude Code SDK
        run: |
          npm install -g @anthropic-ai/sdk
          npm install -g @anthropic-ai/claude-code

      - name: Run Claude Code
        env:
          ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          PR_NUMBER: ${{ github.event.pull_request.number || github.event.issue.number }}
          COMMENT_BODY: ${{ github.event.comment.body || '' }}
        run: |
          node .github/scripts/claude-code-handler.js

      - name: Commit and Push Changes
        if: success()
        run: |
          git config user.name "Claude Code Bot"
          git config user.email "claude-code-bot@users.noreply.github.com"

          if [[ -n $(git status -s) ]]; then
            git add .
            git commit -m "Claude Code: Apply requested changes

            Triggered by: ${{ github.event_name }}
            PR/Issue: #${{ github.event.pull_request.number || github.event.issue.number }}
            "
            git push
          fi
```

#### Step 2: Create Handler Script

Create `.github/scripts/claude-code-handler.js`:

```javascript
#!/usr/bin/env node

const { Anthropic } = require('@anthropic-ai/sdk');
const { execSync } = require('child_process');
const fs = require('fs');

const anthropic = new Anthropic({
  apiKey: process.env.ANTHROPIC_API_KEY,
});

async function main() {
  const prNumber = process.env.PR_NUMBER;
  const commentBody = process.env.COMMENT_BODY;

  // Fetch PR details
  const prInfo = JSON.parse(
    execSync(`gh pr view ${prNumber} --json title,body,files,reviews,comments`, {
      encoding: 'utf-8'
    })
  );

  // Check CI status
  const ciStatus = execSync('gh pr checks', { encoding: 'utf-8' });

  // Build context
  const context = `
# Pull Request Context

**Title**: ${prInfo.title}

**Description**:
${prInfo.body}

**Recent Comment**:
${commentBody}

**CI Status**:
${ciStatus}

**Files Changed**:
${prInfo.files.map(f => `- ${f.path}`).join('\n')}

**Task**: Please analyze the request and make the necessary code changes.
`;

  // Call Claude Code
  const message = await anthropic.messages.create({
    model: 'claude-sonnet-4-5-20250929',
    max_tokens: 8096,
    messages: [{
      role: 'user',
      content: context
    }],
    tools: [
      // Define tools for file operations
      {
        name: 'read_file',
        description: 'Read a file from the repository',
        input_schema: {
          type: 'object',
          properties: {
            path: { type: 'string', description: 'File path' }
          },
          required: ['path']
        }
      },
      {
        name: 'write_file',
        description: 'Write content to a file',
        input_schema: {
          type: 'object',
          properties: {
            path: { type: 'string', description: 'File path' },
            content: { type: 'string', description: 'File content' }
          },
          required: ['path', 'content']
        }
      }
    ]
  });

  // Process tool calls and execute changes
  // (Implementation depends on your specific needs)

  console.log('Claude Code execution completed');
}

main().catch(console.error);
```

#### Step 3: Add Secrets

1. Go to repository **Settings** → **Secrets and variables** → **Actions**
2. Add secret: `ANTHROPIC_API_KEY` with your Claude API key
3. `GITHUB_TOKEN` is automatically provided

#### Step 4: Install GitHub CLI in Workflow

The script uses `gh` CLI, which is pre-installed in GitHub Actions runners.

### Method 2: Self-Hosted Integration

For self-hosted setups or custom integrations:

#### Install Claude Code SDK

```bash
npm install -g @anthropic-ai/sdk
# or
pip install anthropic
```

#### Create Integration Script

```python
#!/usr/bin/env python3

import os
import anthropic
import subprocess
import json

def handle_pr_comment(pr_number, comment):
    """Handle a PR comment requesting Claude Code assistance"""

    client = anthropic.Anthropic(
        api_key=os.environ.get("ANTHROPIC_API_KEY")
    )

    # Get PR context
    pr_info = subprocess.check_output(
        f"gh pr view {pr_number} --json title,body,files,reviews",
        shell=True
    ).decode('utf-8')

    pr_data = json.loads(pr_info)

    # Get diff
    diff = subprocess.check_output(
        f"gh pr diff {pr_number}",
        shell=True
    ).decode('utf-8')

    # Build prompt
    prompt = f"""
You are Claude Code, an AI assistant integrated into a GitHub workflow.

PR #{pr_number}: {pr_data['title']}

Description:
{pr_data['body']}

Comment requesting assistance:
{comment}

Code changes:
{diff}

Please analyze the request and provide the necessary code changes.
"""

    message = client.messages.create(
        model="claude-sonnet-4-5-20250929",
        max_tokens=8096,
        messages=[{
            "role": "user",
            "content": prompt
        }]
    )

    # Process response and make changes
    # ... (implement based on your needs)

    return message

if __name__ == "__main__":
    pr_number = os.environ.get("PR_NUMBER")
    comment = os.environ.get("COMMENT_BODY")

    handle_pr_comment(pr_number, comment)
```

## Usage Examples

### Example 1: Fixing CI Failures

**PR Comment**:
```
@claude-code The tests are failing. Can you fix the TypeScript errors?
```

**Claude Code Response**:
1. Analyzes CI logs
2. Identifies TypeScript type errors
3. Fixes type definitions
4. Commits changes with descriptive message
5. Responds with explanation

### Example 2: Addressing Review Feedback

**Reviewer Comment**:
```
@claude-code This function is too complex. Can you refactor it to be more readable?
```

**Claude Code Actions**:
1. Reads the function in question
2. Breaks it into smaller, focused functions
3. Adds descriptive comments
4. Updates tests if needed
5. Commits refactored code

### Example 3: Implementing Feature Requests

**Issue Description**:
```
Add input validation to the user registration form

@claude-code Please add email and password validation:
- Email must be valid format
- Password must be at least 8 characters
- Password must contain uppercase, lowercase, and numbers
```

**Claude Code Implementation**:
1. Locates registration form code
2. Adds validation logic
3. Adds error messages
4. Writes unit tests
5. Updates documentation
6. Commits with detailed message

### Example 4: Fixing Merge Conflicts

**PR Comment**:
```
@claude-code Can you resolve the merge conflicts with main?
```

**Claude Code Resolution**:
1. Fetches latest main branch
2. Analyzes conflicts
3. Intelligently merges changes
4. Runs tests to verify
5. Commits resolution

## Trigger Methods

### 1. Comment Triggers

Trigger Claude Code with specific mentions:

```
@claude-code [instruction]
```

**Examples**:
- `@claude-code Fix the failing tests`
- `@claude-code Refactor this function`
- `@claude-code Add error handling`
- `@claude-code Update the documentation`

### 2. Label Triggers

Add labels to PRs to trigger Claude Code:

- `claude-code` - General assistance
- `claude-code:fix-ci` - Fix CI failures
- `claude-code:review` - Address review comments
- `claude-code:refactor` - Refactor code

### 3. Automated Triggers

Set up automatic triggers for common scenarios:

```yaml
# Trigger on CI failure
on:
  check_run:
    types: [completed]

jobs:
  auto-fix:
    if: github.event.check_run.conclusion == 'failure'
    # ... Claude Code job
```

## Best Practices

### 1. Clear Instructions

**Good**:
```
@claude-code The `calculateTotal` function in src/utils/math.ts has a bug
when handling negative numbers. Please fix it and add test cases.
```

**Less Effective**:
```
@claude-code fix the bug
```

### 2. Provide Context

Include relevant information:
- Specific file paths
- Error messages
- Expected behavior
- Related issues or PRs

### 3. Review Changes

Always review Claude Code's changes before merging:
- Check the diff
- Run tests locally
- Verify the logic
- Ensure code style compliance

### 4. Iterative Feedback

Provide feedback for improvements:
```
@claude-code Thanks! Can you also add JSDoc comments to the new functions?
```

### 5. Use Appropriate Models

- **Claude Sonnet**: General purpose, balanced speed and capability
- **Claude Opus**: Complex refactoring, architectural changes
- **Claude Haiku**: Simple fixes, quick responses

## Security Considerations

### 1. API Key Protection

- Store `ANTHROPIC_API_KEY` as GitHub secret
- Never commit API keys to repository
- Rotate keys regularly
- Use separate keys for different environments

### 2. Permission Scoping

Limit GitHub Actions permissions:

```yaml
permissions:
  contents: write        # Only if commits are needed
  pull-requests: write   # For PR comments
  issues: write          # For issue comments
  # Don't grant unnecessary permissions
```

### 3. Code Review

- Always review AI-generated changes
- Don't auto-merge Claude Code PRs
- Require human approval for production code
- Use branch protection rules

### 4. Rate Limiting

Implement rate limits to prevent abuse:

```yaml
# Limit to specific users or teams
if: contains(github.event.comment.user.login, 'approved-users')

# Limit frequency
# Use GitHub Actions concurrency controls
concurrency:
  group: claude-code-${{ github.event.pull_request.number }}
  cancel-in-progress: false
```

### 5. Input Validation

Sanitize inputs before passing to Claude:
- Validate comment content
- Check file paths
- Verify PR/issue numbers
- Prevent code injection

## Advanced Features

### Multi-Agent Workflows

Combine multiple Claude Code agents for complex tasks:

```yaml
jobs:
  analyze:
    # Agent 1: Analyze the issue

  implement:
    needs: analyze
    # Agent 2: Implement changes

  test:
    needs: implement
    # Agent 3: Write tests

  document:
    needs: test
    # Agent 4: Update documentation
```

### Custom Tools

Provide Claude Code with custom tools:

```javascript
const tools = [
  {
    name: 'run_tests',
    description: 'Run the test suite',
    input_schema: {
      type: 'object',
      properties: {
        test_path: { type: 'string' }
      }
    }
  },
  {
    name: 'lint_code',
    description: 'Run linter on code',
    input_schema: {
      type: 'object',
      properties: {
        files: { type: 'array', items: { type: 'string' } }
      }
    }
  }
];
```

### Integration with Other Tools

Combine Claude Code with:
- **Codecov**: Analyze coverage reports
- **SonarQube**: Fix code quality issues
- **Dependabot**: Update dependencies
- **Snyk**: Address security vulnerabilities

### Customizing Behavior

Configure Claude Code's behavior:

```yaml
env:
  CLAUDE_MODEL: "claude-sonnet-4-5-20250929"
  CLAUDE_MAX_TOKENS: 8096
  CLAUDE_TEMPERATURE: 0.7
  AUTO_COMMIT: "true"
  COMMIT_MESSAGE_PREFIX: "[Claude Code]"
```

## Monitoring and Logging

### Track Usage

Monitor Claude Code activity:

```javascript
// Log to analytics
analytics.track('claude-code-invocation', {
  pr_number: prNumber,
  action: action,
  timestamp: Date.now(),
  user: github.event.sender.login
});
```

### GitHub Actions Logs

View execution logs:
1. Go to **Actions** tab
2. Select the workflow run
3. View detailed logs for each step

### Cost Tracking

Monitor API usage:
- Track token consumption
- Set budget alerts
- Analyze usage patterns
- Optimize prompt efficiency

## Troubleshooting

### Issue: Claude Code Not Responding

**Check**:
1. Workflow is triggering correctly
2. API key is valid
3. GitHub token has correct permissions
4. No rate limiting

**Debug**:
```bash
# Check workflow runs
gh run list --workflow=claude-code.yml

# View specific run
gh run view <run-id> --log
```

### Issue: Changes Not Being Committed

**Causes**:
- No changes detected
- Git configuration missing
- Permission issues

**Solution**:
```yaml
- name: Debug Git Status
  run: |
    git status
    git diff

- name: Configure Git
  run: |
    git config user.name "Claude Code Bot"
    git config user.email "bot@example.com"
```

### Issue: API Rate Limits

**Solution**:
- Implement caching
- Use smaller models for simple tasks
- Add delay between requests
- Use streaming for long responses

### Issue: Incorrect Changes

**Prevention**:
- Provide clear, specific instructions
- Include relevant context
- Review changes before merging
- Use branch protection

## Cost Optimization

### 1. Use Appropriate Models

```javascript
// Simple fixes - use Haiku (faster, cheaper)
if (isSimpleFix(comment)) {
  model = 'claude-haiku-20250305';
}

// Complex refactoring - use Sonnet/Opus
if (isComplexTask(comment)) {
  model = 'claude-sonnet-4-5-20250929';
}
```

### 2. Limit Context Size

Only include relevant information:
- Don't send entire codebase
- Filter to changed files
- Summarize large diffs
- Truncate very long logs

### 3. Cache Results

Cache common responses:
```javascript
const cache = new Map();
const cacheKey = `${action}-${fileHash}`;

if (cache.has(cacheKey)) {
  return cache.get(cacheKey);
}
```

### 4. Set Token Limits

```javascript
max_tokens: calculateTokenLimit(taskComplexity)
```

## Examples Repository

Full working examples available at:
```
https://github.com/anthropics/claude-code-examples
```

Includes:
- Complete GitHub Actions workflows
- Handler scripts in multiple languages
- Custom tool implementations
- Integration patterns
- Best practices

## Resources

### Documentation
- [Claude Code SDK](https://github.com/anthropics/anthropic-sdk-typescript)
- [Anthropic API Documentation](https://docs.anthropic.com)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)

### Community
- [Claude Code Discord](https://discord.gg/anthropic)
- [GitHub Discussions](https://github.com/anthropics/claude-code/discussions)
- [Stack Overflow Tag: claude-code](https://stackoverflow.com/questions/tagged/claude-code)

### Tools
- [GitHub CLI (`gh`)](https://cli.github.com/)
- [Claude API Playground](https://console.anthropic.com)
- [GitHub Actions Toolkit](https://github.com/actions/toolkit)

## Support

For issues and questions:
1. Check [troubleshooting section](#troubleshooting)
2. Search [existing issues](https://github.com/anthropics/claude-code/issues)
3. Join the [Discord community](https://discord.gg/anthropic)
4. Create a [new issue](https://github.com/anthropics/claude-code/issues/new)

---

**Ready to get started?** Set up the GitHub Actions workflow and start using Claude Code as your virtual teammate!
