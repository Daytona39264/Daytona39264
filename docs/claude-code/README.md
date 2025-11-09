# Claude Code Documentation

Welcome to the Claude Code documentation! This directory contains guides and resources for integrating Claude Code into your development workflow.

## What is Claude Code?

Claude Code is an AI-powered code assistant built on the publicly available [Claude Code SDK](https://github.com/anthropics/anthropic-sdk-typescript). It helps developers with:

- Code review and feedback
- Bug fixing and debugging
- Refactoring and optimization
- Test generation
- Documentation creation
- CI/CD integration

## Documentation

### [GitHub Integration](./github-integration.md)

Learn how to run Claude Code directly from your GitHub Pull Requests and Issues. This integration allows Claude Code to act as a virtual teammate that:

- Responds to reviewer feedback
- Fixes CI/CD failures automatically
- Implements feature requests from issues
- Refactors code based on comments
- Addresses merge conflicts
- Updates documentation

**Key Topics**:
- Setup with GitHub Actions
- Self-hosted integration options
- Usage examples and best practices
- Security considerations
- Troubleshooting and cost optimization

## Quick Start

### Prerequisites

- GitHub repository
- Claude API key (from [Anthropic](https://console.anthropic.com))
- Node.js 18+ or Python 3.8+

### Basic Setup

1. **Install the Claude Code SDK**:
   ```bash
   npm install -g @anthropic-ai/sdk
   # or
   pip install anthropic
   ```

2. **Configure GitHub Actions**:
   - Copy the workflow from [GitHub Integration guide](./github-integration.md#method-1-github-actions-recommended)
   - Add your `ANTHROPIC_API_KEY` to repository secrets

3. **Start Using**:
   - Comment `@claude-code [instruction]` on any PR or issue
   - Add the `claude-code` label to PRs
   - Watch Claude Code assist with your development tasks

## Use Cases

### Code Reviews
```
@claude-code This function needs better error handling. Can you add try-catch blocks
and proper error messages?
```

### CI/CD Fixes
```
@claude-code The build is failing due to TypeScript errors. Please fix them.
```

### Feature Implementation
```
@claude-code Add input validation for the email field with proper error messages
```

### Refactoring
```
@claude-code This component has too many responsibilities. Can you split it into
smaller, focused components?
```

## Integration Options

### GitHub Actions (Recommended)
- Fully automated
- Runs in GitHub's infrastructure
- Easy to set up and maintain
- See [GitHub Integration guide](./github-integration.md#method-1-github-actions-recommended)

### Self-Hosted
- Full control over execution
- Custom integrations possible
- Can integrate with internal tools
- See [GitHub Integration guide](./github-integration.md#method-2-self-hosted-integration)

### CI/CD Platforms
- Jenkins
- GitLab CI
- CircleCI
- Azure DevOps
- Custom pipelines

## Security Best Practices

1. **Protect API Keys**: Store in secrets, never commit to repository
2. **Review Changes**: Always review AI-generated code before merging
3. **Limit Permissions**: Use minimal required GitHub token permissions
4. **Rate Limiting**: Implement controls to prevent abuse
5. **Input Validation**: Sanitize inputs before processing

## Cost Management

Claude Code uses the Anthropic API, which is billed per token:

- **Model Selection**: Use appropriate models for task complexity
  - Haiku: Simple fixes, quick responses
  - Sonnet: General purpose development
  - Opus: Complex refactoring, architecture

- **Context Optimization**: Only include relevant code and information
- **Caching**: Cache common responses and patterns
- **Token Limits**: Set appropriate max_tokens for tasks

See [Cost Optimization](./github-integration.md#cost-optimization) for details.

## Community and Support

### Getting Help

- **Documentation**: Start with the guides in this directory
- **Examples**: Check the [examples repository](https://github.com/anthropics/claude-code-examples)
- **Community**: Join the [Discord server](https://discord.gg/anthropic)
- **Issues**: Report bugs on [GitHub](https://github.com/anthropics/claude-code/issues)

### Contributing

Contributions are welcome! Areas to contribute:

- Documentation improvements
- Example workflows
- Integration patterns
- Tool implementations
- Best practices

## Resources

### Official Documentation
- [Anthropic API Docs](https://docs.anthropic.com)
- [Claude Code SDK](https://github.com/anthropics/anthropic-sdk-typescript)
- [GitHub Actions Docs](https://docs.github.com/en/actions)

### Tutorials and Guides
- [Setting up GitHub Actions](./github-integration.md#setup)
- [Writing effective prompts](./github-integration.md#best-practices)
- [Troubleshooting common issues](./github-integration.md#troubleshooting)

### Tools and Utilities
- [GitHub CLI](https://cli.github.com/)
- [Claude Console](https://console.anthropic.com)
- [Actions Toolkit](https://github.com/actions/toolkit)

## Advanced Topics

- **Multi-agent workflows**: Coordinate multiple Claude agents
- **Custom tools**: Extend Claude Code with domain-specific tools
- **Integration patterns**: Connect with other development tools
- **Performance optimization**: Improve speed and reduce costs
- **Monitoring and analytics**: Track usage and effectiveness

See the [Advanced Features](./github-integration.md#advanced-features) section for more information.

## FAQ

### How much does it cost?

Costs depend on:
- API usage (tokens consumed)
- Model selection (Haiku < Sonnet < Opus)
- Frequency of use

See [Anthropic's pricing](https://www.anthropic.com/pricing) for current rates.

### Is my code secure?

- Code is sent to Anthropic's API for processing
- Anthropic has strong privacy and security practices
- For sensitive code, consider self-hosted alternatives
- Review the [security considerations](./github-integration.md#security-considerations)

### Can I use it with private repositories?

Yes! Claude Code works with both public and private repositories.

### What languages are supported?

Claude Code supports all major programming languages including:
- JavaScript/TypeScript
- Python
- Java
- Go
- Rust
- C/C++
- Ruby
- PHP
- And many more

### Can it replace code reviews?

No. Claude Code is a tool to assist developers, not replace human judgment. Always review AI-generated changes before merging.

## What's Next?

- **New to Claude Code?** Start with [GitHub Integration](./github-integration.md)
- **Ready to deploy?** Follow the [setup guide](./github-integration.md#setup)
- **Need examples?** Check the [usage examples](./github-integration.md#usage-examples)
- **Have questions?** Join the [community](https://discord.gg/anthropic)

---

Built with the [Claude Code SDK](https://github.com/anthropics/anthropic-sdk-typescript) | [Anthropic](https://www.anthropic.com)
