# Issue Guidelines

Thank you for your interest in contributing to this repository! To help maintain a clear and organized issue tracker, please follow these guidelines when creating new issues.

## Before Creating an Issue

1. **Search existing issues** - Check if your issue has already been reported
2. **Verify it's a real issue** - Make sure you have a clear problem, bug, or feature request
3. **Gather information** - Collect relevant details, error messages, screenshots, or examples

## How to Create a Good Issue

### Title
- **Be specific and descriptive** - Use clear, concise language that summarizes the issue
- **Include context** - Mention the component, feature, or area affected
- **Avoid vague titles** - Don't use titles like "issue", "problem", "help", or "question"

**Good Examples:**
- ✅ "Add TypeScript support to project configuration"
- ✅ "README.md social links return 404 errors"
- ✅ "Feature Request: Add dark mode toggle to profile"

**Bad Examples:**
- ❌ "issue"
- ❌ "Daytona39264"
- ❌ "help"
- ❌ "problem with thing"

### Description

A good issue description should include the following elements based on the type of issue:

#### For Bug Reports:
1. **What happened** - Clear description of the bug
2. **Expected behavior** - What you expected to happen
3. **Steps to reproduce** - Detailed steps to recreate the issue
4. **Environment** - Browser, OS, versions, etc. (if relevant)
5. **Screenshots/logs** - Visual proof or error messages (if applicable)

**Example:**
```markdown
## Description
The LinkedIn badge in README.md returns a 404 error when clicked.

## Expected Behavior
Clicking the LinkedIn badge should navigate to the LinkedIn profile.

## Steps to Reproduce
1. Open README.md on GitHub
2. Click the LinkedIn badge in the header
3. Observe 404 error page

## Environment
- Browser: Chrome 119
- Date: 2025-11-05
```

#### For Feature Requests:
1. **Problem statement** - What problem does this solve?
2. **Proposed solution** - How would you like it to work?
3. **Alternatives considered** - Other approaches you've thought about
4. **Additional context** - Any relevant information, mockups, or examples

**Example:**
```markdown
## Problem
Currently, the README doesn't showcase my most recent projects.

## Proposed Solution
Add a "Recent Projects" section that displays the 3 most recently updated repositories using GitHub's API.

## Alternatives Considered
- Manual updates (too time-consuming)
- Static list (becomes outdated quickly)

## Additional Context
Similar to: https://github.com/anuraghazra/github-readme-stats
```

#### For Questions:
1. **Clear question** - State your question explicitly
2. **Context** - Explain why you're asking and what you're trying to achieve
3. **What you've tried** - Show research or attempted solutions

**Example:**
```markdown
## Question
How should I update the project URLs in the README to point to my actual repositories?

## Context
I've forked this profile repository and want to customize it with my real projects.

## What I've Tried
- Searched for documentation in the repository
- Read the README instructions
```

## Using Labels

If you have permissions, apply appropriate labels to help categorize your issue. Otherwise, suggest labels in your issue description to help maintainers categorize it:

- **bug** - Something isn't working correctly
- **documentation** - Improvements or additions to documentation
- **duplicate** - This issue already exists (reference the original)
- **enhancement** - New feature or request
- **good first issue** - Suitable for newcomers
- **help wanted** - Extra attention needed
- **invalid** - Issue doesn't seem right or is not actionable
- **question** - Requesting information or clarification
- **wontfix** - Will not be worked on (maintainer use)

## What NOT to Include

❌ **Don't paste clipboard content or UI text** - Avoid accidentally pasting copied interface text or selections into the issue body
❌ **Don't create empty issues** - Always provide a description
❌ **Don't use all caps** - Write in normal sentence case
❌ **Don't be vague** - Provide specific, actionable information
❌ **Don't submit test issues** - Use a personal repository for testing

## Issue Templates

For common issue types, consider using these templates:

### Bug Report Template
```markdown
**Describe the bug**
A clear description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:
1. Go to '...'
2. Click on '...'
3. Scroll down to '...'
4. See error

**Expected behavior**
What you expected to happen.

**Screenshots**
If applicable, add screenshots.

**Environment:**
- OS: [e.g. macOS, Windows, Linux]
- Browser: [e.g. chrome, safari]
- Version: [e.g. 22]
```

### Feature Request Template
```markdown
**Is your feature request related to a problem?**
A clear description of the problem. Ex. I'm frustrated when [...]

**Describe the solution you'd like**
A clear description of what you want to happen.

**Describe alternatives you've considered**
Alternative solutions or features you've considered.

**Additional context**
Any other context, screenshots, or examples.
```

### Question Template
```markdown
**Question**
What would you like to know?

**Context**
Why are you asking? What are you trying to accomplish?

**Research**
What have you already tried or looked at?
```

## After Creating an Issue

1. **Monitor responses** - Check back for questions or requests for more information
2. **Provide updates** - If you discover new information, add it to the issue
3. **Close if resolved** - If you fix the issue yourself, document the solution and close it
4. **Be patient and respectful** - Maintainers are often volunteers

## Examples of Issues to Avoid

Based on actual issues in this repository, here are examples of what NOT to do:

❌ **Issue #8**: Title "issue" with no description
- Problem: Completely unclear what the issue is about
- Fix: Use a descriptive title and provide details

❌ **Issue #9**: Title "Daytona39264" with selected UI text in body
- Problem: Appears to be accidentally created with clipboard content
- Fix: Write a clear problem statement, not UI text

## Need Help?

If you're unsure how to create an issue:
1. Look at well-written existing issues for examples
2. Start with the templates above
3. Ask in the issue description if you need help clarifying something
4. It's okay to ask questions - just make them clear and specific!

---

**Thank you for taking the time to create quality issues!** Good issues help maintainers understand problems quickly and lead to faster resolutions.
