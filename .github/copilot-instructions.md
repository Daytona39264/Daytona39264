# Copilot Instructions for Daytona39264

## Repository Overview
This is a personal GitHub profile repository showcasing professional information, skills, and projects. The primary content is the README.md file displayed on the GitHub profile page. Additionally, it serves as a central hub for developer documentation, tools, and project artifacts including comprehensive guides for SSH setup, JetBrains IDE installation, Claude Code integration, and a git submodule containing the Dingo API Wiki.

## Purpose and Goals
- Maintain an up-to-date professional profile
- Showcase skills, projects, and experience
- Provide contact information and social links
- Present a polished, professional image
- Serve as a documentation repository for developer tools and workflows
- Host installation scripts and guides for common development tools

## Project Architecture
This repository has evolved into a multi-purpose workspace:
- **Profile Component**: GitHub profile README with dynamic badges and stats
- **Documentation Hub**: Organized guides in `docs/` subdirectories (ssh/, jetbrains/, claude-code/)
- **Tool Scripts**: Executable bash scripts in root for tool installation
- **Project Artifacts**: Summary files and manifests from completed development projects
- **External Content**: Git submodule (`dingo-api-wiki/`) for Laravel API documentation

Key architectural decisions:
- Flat structure for easy navigation and GitHub rendering
- Tool-specific documentation organized by category
- Scripts in root for discoverability and direct execution
- Submodule for external documentation to avoid duplication

## Code Style and Conventions

### Markdown Standards
- Use proper heading hierarchy (# for main title, ## for sections)
- Keep line lengths readable (preferably under 120 characters where possible)
- Use blank lines to separate sections for clarity
- Employ consistent formatting for links and badges

### Content Guidelines
- Keep information accurate and current
- Use professional, clear language
- Maintain consistency across all sections
- Ensure all links are functional and point to correct destinations

### Documentation Patterns
- Structure guides with Quick Start (5-minute setup) followed by comprehensive guides
- Include code blocks for commands with bash syntax highlighting
- Use relative links for internal navigation (e.g., `./SETUP.md`)
- Provide multiple installation methods with clear recommendations
- Include troubleshooting sections with common issues and solutions

### Script Conventions
- Use bash with `set -e` for strict error handling
- Include color-coded logging functions (log_info, log_warn, log_error)
- Implement cleanup traps for temporary files
- Check dependencies before execution
- Use descriptive variable names and comments
- Follow POSIX-compliant syntax for cross-platform compatibility

### Badges and Visual Elements
- Use shields.io or similar services for consistent badge styling
- Ensure badges are functional and display correctly
- Maintain consistent styling for dark/light theme support with `<picture>` elements

## File Structure
```
.
├── README.md                    # Main profile content and documentation index
├── .github/
│   ├── workflows/               # GitHub Actions workflows
│   ├── agents/                  # Custom agent configurations
│   └── copilot-instructions.md  # This file
├── docs/
│   ├── ssh/                     # SSH connection and key management guides
│   ├── jetbrains/               # JetBrains IDE installation and setup
│   └── claude-code/             # Claude Code AI integration guides
├── dingo-api-wiki/              # Git submodule for Laravel API documentation
├── install-*.sh                 # Tool installation scripts
└── *-SUMMARY.md                 # Project completion summaries and manifests
```

## Development Practices

### Making Changes to README.md
1. **Preserve structure**: Maintain the existing sections and organization
2. **Verify links**: Test all URLs before committing
3. **Check badges**: Ensure badges render correctly
3. **Review formatting**: Preview markdown rendering
4. **Validate syntax**: Use markdown linters when available

### Adding Documentation
1. Create category directory under `docs/` if new tool/area
2. Include both quick start and comprehensive guides
3. Add navigation links in main README.md
4. Test all code examples and commands
5. Update any related installation scripts

### Script Development
1. Include error handling and dependency checks
2. Add color-coded output for user feedback
3. Implement cleanup for temporary files
4. Test on target platforms before committing
5. Document usage in corresponding markdown guides

### GitHub Actions
- Keep workflows simple and well-documented
- Use latest stable action versions (e.g., `actions/checkout@v4`)
- Include comments explaining workflow purpose

## Testing and Validation

### Manual Checks
- Preview README.md changes locally or on GitHub
- Verify all external links are accessible
- Ensure badges display correctly
- Check responsive design on different screen sizes
- Test installation scripts on clean environments
- Validate documentation examples work as described

### Automated Checks
- GitHub's markdown renderer validates syntax automatically
- CI workflows (if added) should pass before merging
- Shell scripts should be tested with `shellcheck` for linting

## Important Considerations

### What to Update
- Professional information (role, bio, skills)
- Project descriptions and links
- Social media links and contact information
- Technology stack and tools
- Fun facts and personal interests
- Documentation content and examples
- Installation scripts for new tool versions

### What NOT to Change
- Overall structure and organization (unless explicitly requested)
- Existing working workflows or configurations
- File naming conventions
- Working installation scripts without testing

### Security and Privacy
- Never commit sensitive information (API keys, passwords, etc.)
- Keep email addresses and contact info current but safe
- Review all changes for potential privacy concerns
- Ensure external links are safe and reputable
- Validate script downloads use HTTPS and trusted sources

## Common Tasks

### Updating Skills Section
When adding new skills or technologies:
- Group by category (Languages, Frontend, Backend, etc.)
- Keep descriptions concise
- Maintain alphabetical or importance-based ordering

### Adding New Projects
For new project entries:
- Include project name and brief description
- Add repository link (if public)
- List key technologies used
- Highlight notable features or achievements

### Updating Social Links
When modifying social links:
- Verify URLs are correct and accessible
- Update corresponding badges if needed
- Ensure consistency between badge and text links

### Adding Tool Documentation
When creating new documentation:
- Follow the established pattern: README.md hub, QUICK-START.md, detailed guides
- Include practical examples and code snippets
- Add installation scripts if applicable
- Update main README.md navigation

## Best Practices for Copilot Agent

### Issue Assignment
- Assign well-defined tasks (e.g., "Update skills section to include Rust")
- Provide clear acceptance criteria
- Specify which sections need changes

### Changes to Make
- Content updates (text, links, information)
- Adding new sections or projects
- Updating badges and visual elements
- Improving formatting and readability
- Adding new documentation guides
- Updating installation scripts

### Changes to Avoid
- Don't remove working content without explicit instruction
- Don't change the overall structure dramatically
- Don't add unverified or placeholder information
- Don't break existing links or badges
- Don't modify scripts without testing

## Quality Standards
- All content should be accurate and up-to-date
- Links must be functional
- Markdown must render correctly on GitHub
- Maintain professional tone and presentation
- Ensure accessibility (alt text for images, clear link text)
- Scripts must be executable and well-tested
- Documentation should be comprehensive yet concise

## Collaboration
- Use clear, descriptive commit messages
- Create focused pull requests for specific changes
- Respond to review feedback promptly
- Test changes before marking as complete

## Resources
- [GitHub Profile README Guide](https://docs.github.com/en/account-and-profile/setting-up-and-managing-your-github-profile/customizing-your-profile/managing-your-profile-readme)
- [Shields.io Badge Service](https://shields.io/)
- [GitHub Readme Stats](https://github.com/anuraghazra/github-readme-stats)
- [Markdown Guide](https://www.markdownguide.org/)
- [ShellCheck](https://github.com/koalaman/shellcheck) for script linting
