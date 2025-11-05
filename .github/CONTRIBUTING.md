# Contributing to Daytona39264

Thank you for your interest in contributing! This document provides guidelines and instructions for contributing to this GitHub profile repository.

## Table of Contents

- [Getting Started](#getting-started)
- [Development Environment Setup](#development-environment-setup)
- [Code Style and Conventions](#code-style-and-conventions)
- [Issue and Pull Request Workflow](#issue-and-pull-request-workflow)
- [Review Process](#review-process)
- [Getting Help](#getting-help)
- [Community Guidelines](#community-guidelines)

## Getting Started

This is a personal GitHub profile repository that showcases professional information, skills, and projects. The primary content is the `README.md` file displayed on the GitHub profile page.

### What Can You Contribute?

- **Bug fixes** - Corrections to broken links, formatting issues, or display problems
- **Improvements** - Better wording, additional sections, or enhanced formatting
- **Documentation** - Updates to contributing guides or issue templates
- **Suggestions** - Ideas for new sections or features (via issues)

### Before Contributing

1. **Read the documentation**
   - Review the [README.md](../README.md)
   - Read the [Issue Guidelines](ISSUES.md)
   - Check the [Copilot Instructions](copilot-instructions.md) for detailed standards

2. **Search existing issues and PRs**
   - Avoid duplicate work by checking if someone is already working on your idea

3. **Start small**
   - First-time contributors should start with minor improvements or documentation updates

## Development Environment Setup

### Prerequisites

- **Git** - For cloning and managing the repository
- **Text Editor** - VSCode, Sublime, or any markdown-capable editor
- **GitHub Account** - For creating issues and pull requests
- **Markdown Preview** - Browser extension or editor plugin for previewing changes

### Setup Steps

1. **Fork the repository**
   ```bash
   # Click the "Fork" button on GitHub, then clone your fork
   git clone https://github.com/YOUR-USERNAME/Daytona39264.git
   cd Daytona39264
   ```

2. **Add upstream remote**
   ```bash
   git remote add upstream https://github.com/Daytona39264/Daytona39264.git
   ```

3. **Create a branch for your changes**
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/your-bugfix-name
   ```

4. **Keep your fork synchronized**
   ```bash
   git fetch upstream
   git merge upstream/main
   ```

### Local Development

Since this is primarily a markdown repository, development is straightforward:

1. **Edit files** in your preferred text editor
2. **Preview markdown** using your editor's preview feature or a browser extension
3. **Validate links** by clicking them in preview mode
4. **Check formatting** to ensure consistency with existing content

### Testing Your Changes

Before submitting a pull request:

1. **Preview the README** - Ensure it renders correctly in GitHub's markdown preview
2. **Verify all links** - Click every link to ensure they work
3. **Check badges** - Ensure all badges display properly
4. **Test in both themes** - View in light and dark mode if using theme-specific elements
5. **Validate markdown** - Use a markdown linter if available

## Code Style and Conventions

This repository follows specific markdown standards and content guidelines. For complete details, see [copilot-instructions.md](copilot-instructions.md).

### Markdown Standards

- **Heading hierarchy** - Use `#` for main title, `##` for sections, `###` for subsections
- **Line length** - Keep lines under 120 characters where possible
- **Blank lines** - Separate sections with blank lines for clarity
- **Consistent formatting** - Use the same style for similar elements throughout

### Content Guidelines

- **Accuracy** - Keep all information accurate and current
- **Professional tone** - Use clear, professional language
- **Consistency** - Maintain consistency across all sections
- **Working links** - Ensure all URLs are functional and point to correct destinations

### Badges and Visual Elements

- **Consistent styling** - Use shields.io or similar services
- **Functional badges** - Ensure badges display correctly
- **Theme support** - Use `<picture>` elements for dark/light theme compatibility

### Example Formatting

```markdown
## Section Title

Brief introduction or description.

- **Item 1** - Description of item
- **Item 2** - Description of item
- **Item 3** - Description of item

### Subsection

More detailed content with [links](https://example.com) as needed.
```

## Issue and Pull Request Workflow

### Creating an Issue

1. **Choose the right template**
   - Bug Report: For reporting broken functionality
   - Feature Request: For suggesting improvements
   - Question: For asking questions

2. **Provide complete information**
   - Fill out all sections of the template
   - Include screenshots or examples when helpful
   - Be specific about the problem or suggestion

3. **Follow up**
   - Respond to questions from maintainers
   - Provide additional information if requested

### Creating a Pull Request

1. **Create a branch**
   ```bash
   git checkout -b feature/descriptive-name
   ```

2. **Make your changes**
   - Follow the code style and conventions
   - Keep changes focused and minimal
   - Update related documentation

3. **Test your changes**
   - Preview markdown rendering
   - Verify all links work
   - Check badges display correctly

4. **Commit your changes**
   ```bash
   git add .
   git commit -m "Brief description of changes"
   ```
   
   Use clear, descriptive commit messages:
   - ✅ Good: "Fix broken LinkedIn badge link"
   - ✅ Good: "Add Python to skills section"
   - ❌ Poor: "Update"
   - ❌ Poor: "Fix stuff"

5. **Push to your fork**
   ```bash
   git push origin feature/descriptive-name
   ```

6. **Open a pull request**
   - Go to the original repository on GitHub
   - Click "New Pull Request"
   - Select your branch
   - Fill out the PR template with:
     - **What changed** - Brief description of your changes
     - **Why** - Reason for the changes
     - **Testing** - How you verified the changes work
     - **Screenshots** - For visual changes

### Pull Request Guidelines

- **One change per PR** - Keep PRs focused on a single improvement
- **Descriptive title** - Clearly state what the PR does
- **Complete description** - Explain what and why
- **Link related issues** - Use "Fixes #123" or "Relates to #123"
- **Be patient** - Allow time for review
- **Be responsive** - Address feedback promptly

## Review Process

### What to Expect

1. **Initial review** - A maintainer will review your PR within a few days
2. **Feedback** - You may receive comments or change requests
3. **Iteration** - Make requested changes and push updates
4. **Approval** - Once approved, your PR will be merged
5. **Merge** - Maintainer will merge your changes

### Review Criteria

Reviewers will check:

- **Accuracy** - Information is correct and current
- **Style** - Follows markdown and content guidelines
- **Links** - All links work and point to correct destinations
- **Formatting** - Consistent with existing content
- **Scope** - Changes are focused and appropriate
- **Quality** - Professional tone and presentation

### Addressing Feedback

- **Be open to suggestions** - Reviewers want to help improve quality
- **Ask questions** - If feedback is unclear, ask for clarification
- **Make changes promptly** - Update your PR based on feedback
- **Be respectful** - Maintain a positive, collaborative attitude

## Getting Help

### Where to Get Help

- **Issue Templates** - Use the Question template for usage questions
- **Discussions** - Use GitHub Discussions for open-ended conversations
- **Documentation** - Review existing docs (README, CONTRIBUTING, copilot-instructions)
- **Examples** - Look at previous PRs for reference

### Common Questions

**Q: What should I work on?**
A: Check open issues labeled "good first issue" or "help wanted"

**Q: Can I suggest a new feature?**
A: Yes! Create an issue using the Feature Request template

**Q: How long will my PR take to review?**
A: Reviews typically happen within a few days, but may take longer depending on complexity

**Q: Can I contribute if I'm new to GitHub?**
A: Absolutely! Start with small changes like fixing typos or improving documentation

**Q: What if I make a mistake?**
A: Don't worry! PRs can be updated. Just push new commits to address any issues

## Community Guidelines

### Our Values

- **Respect** - Treat everyone with courtesy and professionalism
- **Collaboration** - Work together to improve the project
- **Quality** - Strive for excellence in all contributions
- **Inclusivity** - Welcome contributors of all backgrounds and skill levels
- **Growth** - Learn from each other and help others learn

### Expected Behavior

- Use welcoming and inclusive language
- Be respectful of differing viewpoints
- Accept constructive criticism gracefully
- Focus on what's best for the community
- Show empathy toward other contributors

### Unacceptable Behavior

- Harassment or discriminatory language
- Personal attacks or trolling
- Publishing private information
- Spam or off-topic content
- Any conduct that could be considered unprofessional

### Enforcement

Violations of community guidelines may result in:
- Warning from maintainers
- Temporary or permanent ban from the project
- Reporting to GitHub for terms of service violations

## Recognition

Contributors who make significant improvements will be:
- Thanked in commit messages
- Mentioned in release notes (if applicable)
- Welcomed as part of the community

## Questions?

If you have questions about contributing that aren't covered here:
- Create an issue using the Question template
- Review the [copilot-instructions.md](copilot-instructions.md)
- Check existing issues and discussions

Thank you for contributing to make this project better! Your time and effort are greatly appreciated.
