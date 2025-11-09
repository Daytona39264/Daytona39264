# Claude Code Setup Guide

This guide will help you set up Claude Code in your repository to use AI-powered assistance in your Pull Requests and Issues.

## Quick Setup (5 minutes)

### Step 1: Files Already Included

This repository includes the necessary files:

```
.github/
├── workflows/
│   └── claude-code.yml          # GitHub Actions workflow
└── scripts/
    └── claude-code-handler.js   # Handler script
```

### Step 2: Add Your Anthropic API Key

1. Get an API key from [Anthropic Console](https://console.anthropic.com)

2. Add it to your repository secrets:
   - Go to **Settings** → **Secrets and variables** → **Actions**
   - Click **New repository secret**
   - Name: `ANTHROPIC_API_KEY`
   - Value: Your API key
   - Click **Add secret**

### Step 3: Create the claude-code Label (Optional)

1. Go to **Issues** → **Labels**
2. Click **New label**
3. Name: `claude-code`
4. Description: "Trigger Claude Code assistance"
5. Color: Choose any color
6. Click **Create label**

### Step 4: Test It!

That's it! Claude Code is now active. Try it with any of the three trigger methods:

## Usage: Three Ways to Trigger Claude Code

### Method 1: Comment Trigger (Recommended)

Comment on any PR or Issue with `@claude-code` followed by your instruction:

**Examples:**

```
@claude-code Fix the failing TypeScript errors in the build
```

```
@claude-code This function is too complex. Can you refactor it into smaller functions?
```

```
@claude-code Add input validation for the email field with proper error messages
```

```
@claude-code The tests are failing. Please investigate and fix them.
```

**How it works:**
- Comment on any PR (in the main conversation or on specific code lines)
- Include `@claude-code` in your comment
- Claude Code will analyze the PR and make the requested changes
- Changes are committed and pushed automatically
- You'll get a comment notification when done

### Method 2: Label Trigger

Add the `claude-code` label to any PR:

1. Open a Pull Request
2. Add the label `claude-code`
3. Claude Code will automatically review and improve the code

**What Claude Code does when triggered by label:**
- Reviews code quality
- Improves error handling
- Adds missing documentation
- Suggests optimizations
- Adds test coverage

### Method 3: Automated CI Failure (Optional)

Automatically trigger when CI fails:

**Setup:**
The workflow is already configured to respond to CI failures. When a build fails, Claude Code will:
- Analyze the error logs
- Identify the root cause
- Apply fixes
- Push the changes

**Note:** This feature is disabled by default. To enable it, uncomment the `check_run` section in `.github/workflows/claude-code.yml`.

## Example Workflows

### Fix TypeScript Errors

**Comment:**
```
@claude-code The TypeScript build is failing with these errors:
- src/utils/helpers.ts:15 - Property 'foo' does not exist on type 'Bar'
- src/components/Button.tsx:42 - Type 'string' is not assignable to type 'number'
```

**Result:**
- Claude Code analyzes the TypeScript errors
- Fixes type definitions
- Adds proper type annotations
- Commits and pushes fixes

### Address Code Review Feedback

**Comment:**
```
@claude-code Can you address the reviewer's feedback about adding error handling
to the async functions?
```

**Result:**
- Claude Code reads the PR context
- Adds try-catch blocks
- Implements proper error handling
- Commits improvements

### Refactor Complex Code

**Comment:**
```
@claude-code The calculateTotal function in src/utils/pricing.ts is too complex.
Please refactor it following these principles:
- Break into smaller functions
- Add JSDoc comments
- Improve variable names
```

**Result:**
- Claude Code refactors the function
- Creates helper functions
- Adds documentation
- Improves readability

### Implement Feature from Issue

**On an Issue:**
```
@claude-code Please implement this feature:

Add user input validation for the registration form:
- Email must be valid format
- Password must be at least 8 characters
- Password must contain uppercase, lowercase, and numbers
- Show appropriate error messages
```

**Result:**
- Claude Code implements the validation
- Adds error messages
- Updates tests
- Documents the changes

## Configuration

### Customizing the Workflow

Edit `.github/workflows/claude-code.yml` to customize behavior:

#### Change the Model

```yaml
model: 'claude-sonnet-4-5-20250929'  # Default (balanced)
# model: 'claude-opus-4-5-20250929'  # More powerful, slower
# model: 'claude-haiku-4-5-20250929' # Faster, cheaper
```

#### Adjust Token Limits

```yaml
max_tokens: 8096  # Default
# max_tokens: 4096  # For simple tasks
# max_tokens: 16384 # For complex refactoring
```

#### Enable/Disable Auto-Commit

```yaml
# In the "Commit and Push Changes" step
if: success()  # Always commit
# if: false    # Never auto-commit (manual review required)
```

### Customizing the Handler

Edit `.github/scripts/claude-code-handler.js` to:

- Add custom tools
- Modify context building
- Change instruction processing
- Add additional validation

## Security Best Practices

### 1. API Key Protection

✅ **Do:**
- Store API key in GitHub Secrets
- Rotate keys regularly
- Use separate keys for different environments

❌ **Don't:**
- Commit API keys to repository
- Share API keys
- Use production keys for testing

### 2. Code Review

✅ **Always:**
- Review AI-generated changes before merging
- Test the changes locally
- Verify the logic is correct

❌ **Never:**
- Auto-merge Claude Code changes
- Skip code review
- Merge without testing

### 3. Permissions

The workflow uses minimal required permissions:

```yaml
permissions:
  contents: write        # To commit changes
  pull-requests: write   # To comment on PRs
  issues: write          # To comment on issues
  checks: read           # To read CI status
```

### 4. Rate Limiting

To prevent abuse, consider:

```yaml
# Limit to specific users
if: contains(['approved-user1', 'approved-user2'], github.event.sender.login)

# Limit to team members
if: github.event.sender.type == 'User'
```

## Monitoring and Costs

### Viewing Usage

1. **Workflow Runs:** Actions tab → claude-code.yml
2. **API Usage:** [Anthropic Console](https://console.anthropic.com)
3. **Costs:** Anthropic Console → Usage & Billing

### Estimated Costs

Costs depend on usage patterns:

**Typical PR review (Sonnet):**
- Input: ~5,000 tokens ($0.015)
- Output: ~2,000 tokens ($0.030)
- **Total: ~$0.045 per request**

**Cost optimization tips:**
- Use Haiku for simple tasks ($0.006/request)
- Limit context size
- Review before triggering
- Set monthly budget alerts

## Troubleshooting

### Issue: Workflow Not Triggering

**Check:**
1. Workflow file is in `.github/workflows/`
2. ANTHROPIC_API_KEY secret is set
3. Comment includes `@claude-code` (case-sensitive)
4. PR is open (not draft)

**Solution:**
```bash
# View workflow runs
gh run list --workflow=claude-code.yml

# Check recent workflow
gh run view --log
```

### Issue: Permission Denied

**Cause:** Insufficient permissions

**Solution:**
Verify workflow permissions in `.github/workflows/claude-code.yml`:
```yaml
permissions:
  contents: write
  pull-requests: write
  issues: write
```

### Issue: API Key Invalid

**Check:**
1. Secret name is exactly `ANTHROPIC_API_KEY`
2. API key is valid (test in Anthropic Console)
3. API key has sufficient credits

**Solution:**
Regenerate API key and update secret.

### Issue: No Changes Committed

**Possible reasons:**
1. Claude Code determined no changes needed
2. Error occurred before changes could be made
3. Git configuration issue

**Debug:**
Check workflow logs:
```bash
gh run view <run-id> --log
```

### Issue: Changes Are Incorrect

**Prevention:**
- Provide clear, specific instructions
- Include relevant context
- Review before merging

**Solution:**
- Revert the commit
- Provide more detailed instructions
- Try again with clearer context

## Advanced Usage

### Multiple Sequential Requests

Make multiple requests in order:

```
@claude-code First, fix the TypeScript errors
```

*Wait for completion*

```
@claude-code Now add unit tests for the fixed functions
```

*Wait for completion*

```
@claude-code Finally, update the documentation
```

### Complex Refactoring

For large refactoring, break into steps:

```
@claude-code Step 1: Extract the business logic from UserController into a UserService

After this is complete, I'll ask for step 2.
```

### Custom Instructions Template

Create issue templates with Claude Code instructions:

`.github/ISSUE_TEMPLATE/bug_fix.md`:
```markdown
---
name: Bug Fix with Claude Code
about: Report a bug and have Claude Code attempt to fix it
---

## Bug Description
[Describe the bug]

## Steps to Reproduce
1.
2.
3.

## Expected Behavior
[What should happen]

## Claude Code Instructions
@claude-code Please investigate and fix this bug. Look in the following areas:
- [File/module to check]
- [Another area to investigate]

Focus on:
- Root cause analysis
- Minimal fix
- Adding test coverage
```

## Examples Repository

For more examples, see:
- [Example PRs](../examples/claude-code-prs/)
- [Example Issues](../examples/claude-code-issues/)
- [Integration Patterns](./github-integration.md#usage-examples)

## Getting Help

**Documentation:**
- [GitHub Integration Guide](./github-integration.md)
- [Claude Code Overview](./README.md)

**Support:**
- [GitHub Discussions](https://github.com/Daytona39264/Daytona39264/discussions)
- [Anthropic Discord](https://discord.gg/anthropic)
- [Report an Issue](https://github.com/Daytona39264/Daytona39264/issues)

---

**You're all set!** Try commenting `@claude-code Hello! Please introduce yourself.` on a test PR to see it in action.
