# Claude Code Quick Reference

Fast reference for using Claude Code in your GitHub workflow.

## 🚀 Three Ways to Trigger

### 1. Comment with @claude-code

```
@claude-code Fix the failing TypeScript errors
```

```
@claude-code Refactor this function to be more readable
```

```
@claude-code Add error handling to the async functions
```

### 2. Add Label

Add the `claude-code` label to any PR for automatic review

### 3. Auto-Trigger on CI Failure

Automatically attempts fixes when build/tests fail (if enabled)

## 💡 Common Use Cases

### Fix Errors

```
@claude-code The build is failing with error: [paste error]
Please fix it.
```

### Code Review Feedback

```
@claude-code Please address the reviewer's comments about:
- Adding input validation
- Improving error messages
- Adding tests
```

### Refactoring

```
@claude-code Refactor the [function/component name] to:
- Break into smaller functions
- Improve naming
- Add documentation
```

### Add Features

```
@claude-code Add [feature description]:
- Requirements
- Acceptance criteria
- Edge cases to handle
```

### Documentation

```
@claude-code Add JSDoc/docstrings to all functions in [file]
```

### Tests

```
@claude-code Add unit tests for [component/function]
```

## 📝 Best Practices

### ✅ Good Instructions

**Specific:**
```
@claude-code Fix the TypeScript error in src/utils/api.ts line 42
where the return type doesn't match the function signature
```

**Context-Rich:**
```
@claude-code The authentication flow is broken. Users can't log in
because the token validation fails. Check src/auth/validator.ts
```

**Actionable:**
```
@claude-code Add try-catch blocks to all async functions in
src/services/ and log errors to the console
```

### ❌ Avoid Vague Instructions

```
@claude-code fix it
```

```
@claude-code make it better
```

```
@claude-code help
```

## 🔧 Quick Troubleshooting

| Problem | Solution |
|---------|----------|
| Workflow not triggering | Check `@claude-code` is in comment |
| Permission denied | Verify ANTHROPIC_API_KEY secret is set |
| No changes made | Check workflow logs for errors |
| Wrong changes | Provide more specific instructions |

## 📊 What Claude Code Can Do

✅ **Can:**
- Fix build/test errors
- Refactor code
- Add documentation
- Improve error handling
- Add input validation
- Write unit tests
- Address code review feedback
- Implement simple features

⚠️ **Review Required:**
- Security-sensitive code
- Database migrations
- API changes
- Breaking changes
- Performance optimizations

❌ **Cannot:**
- Make architectural decisions
- Replace human code review
- Access external systems
- Deploy code
- Approve PRs

## 🎯 Example Workflows

### Workflow 1: Fix Failing Tests

```
@claude-code The tests in tests/api.test.ts are failing:
- Test "should return 200 on valid request" fails with 500 error
- Test "should validate email" fails on invalid emails

Please fix these test failures.
```

**Expected:**
- Analyzes test failures
- Fixes the code causing failures
- Verifies fix makes sense
- Commits changes

### Workflow 2: Address PR Review

**Reviewer comment:**
> This function needs better error handling

**Your response:**
```
@claude-code Please add comprehensive error handling to the
submitForm function as suggested by the reviewer
```

**Expected:**
- Adds try-catch blocks
- Handles edge cases
- Adds error logging
- Updates function signature if needed

### Workflow 3: Implement Feature

**Issue description:**
> Add email validation to registration form

**Your comment:**
```
@claude-code Please implement email validation:
- Use regex pattern for email format
- Show error message "Invalid email address"
- Validate on blur and submit
- Add test coverage
```

**Expected:**
- Adds validation logic
- Implements error display
- Writes tests
- Documents changes

## 🔒 Security Reminders

- ✅ Always review changes before merging
- ✅ Test changes locally when possible
- ✅ Use branch protection rules
- ✅ Monitor API usage and costs
- ❌ Never auto-merge Claude Code changes
- ❌ Don't expose API keys
- ❌ Don't skip code review

## 💰 Cost Management

| Task Type | Model | Approx. Cost |
|-----------|-------|--------------|
| Simple fix | Haiku | $0.006 |
| Code review | Sonnet | $0.045 |
| Refactoring | Sonnet | $0.080 |
| Complex task | Opus | $0.180 |

**Tips to reduce costs:**
- Be specific (reduces back-and-forth)
- Use Haiku for simple tasks
- Limit context size
- Review before triggering

## 🎓 Tips for Better Results

### 1. Be Specific

Instead of: "Fix the bug"
Write: "Fix the null pointer error in getUserData() when user.profile is undefined"

### 2. Provide Context

```
@claude-code The payment processing is failing for Stripe customers.
The error occurs in src/payments/stripe.ts when calling createCharge().
Recent changes to the API version might be the cause.
Please investigate and fix.
```

### 3. Set Clear Goals

```
@claude-code Refactor the UserDashboard component:
Goals:
- Split into smaller components (< 200 lines each)
- Extract business logic to custom hooks
- Improve prop types with TypeScript
- Maintain existing functionality
```

### 4. Specify Constraints

```
@claude-code Add caching to the API calls, but:
- Don't change the existing API interface
- Use localStorage, not memory cache
- Cache should expire after 5 minutes
- Add cache invalidation on user logout
```

## 📚 More Resources

- **Setup:** [SETUP.md](./SETUP.md)
- **Detailed Guide:** [github-integration.md](./github-integration.md)
- **Overview:** [README.md](./README.md)

---

**Quick Start:** Comment `@claude-code [your instruction]` on any PR to get started!
