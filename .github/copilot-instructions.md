# Copilot Instructions for Daytona39264

## Repository Overview
This is a personal GitHub profile repository showcasing professional information, skills, and projects. The primary content is the README.md file displayed on the GitHub profile page.

## Purpose and Goals
- Maintain an up-to-date professional profile
- Showcase skills, projects, and experience
- Provide contact information and social links
- Present a polished, professional image

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

### Badges and Visual Elements
- Use shields.io or similar services for consistent badge styling
- Ensure badges are functional and display correctly
- Maintain consistent styling for dark/light theme support with `<picture>` elements

## File Structure
```
.
├── README.md                    # Main profile content
├── .github/
│   ├── workflows/               # GitHub Actions workflows
│   ├── agents/                  # Custom agent configurations
│   └── copilot-instructions.md  # This file
```

## Development Practices

### Making Changes to README.md
1. **Preserve structure**: Maintain the existing sections and organization
2. **Verify links**: Test all URLs before committing
3. **Check badges**: Ensure badges render correctly
4. **Review formatting**: Preview markdown rendering
5. **Validate syntax**: Use markdown linters when available

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

### Automated Checks
- GitHub's markdown renderer validates syntax automatically
- CI workflows (if added) should pass before merging

## Important Considerations

### What to Update
- Professional information (role, bio, skills)
- Project descriptions and links
- Social media links and contact information
- Technology stack and tools
- Fun facts and personal interests

### What NOT to Change
- Overall structure and organization (unless explicitly requested)
- Existing working workflows or configurations
- File naming conventions

### Security and Privacy
- Never commit sensitive information (API keys, passwords, etc.)
- Keep email addresses and contact info current but safe
- Review all changes for potential privacy concerns
- Ensure external links are safe and reputable

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

### Changes to Avoid
- Don't remove working content without explicit instruction
- Don't change the overall structure dramatically
- Don't add unverified or placeholder information
- Don't break existing links or badges

## Quality Standards
- All content should be accurate and up-to-date
- Links must be functional
- Markdown must render correctly on GitHub
- Maintain professional tone and presentation
- Ensure accessibility (alt text for images, clear link text)

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
