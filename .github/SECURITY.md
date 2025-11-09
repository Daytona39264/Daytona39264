# Security Policy

## Supported Versions

We release patches for security vulnerabilities in the following versions:

| Version | Supported          |
| ------- | ------------------ |
| 1.x.x   | :white_check_mark: |

## Reporting a Vulnerability

If you discover a security vulnerability, please report it by emailing **security@daytona.dev** instead of using the public issue tracker.

Please include the following information in your report:

- Type of vulnerability
- Full paths of source file(s) related to the vulnerability
- Location of the affected source code (tag/branch/commit or direct URL)
- Step-by-step instructions to reproduce the issue
- Proof-of-concept or exploit code (if possible)
- Impact of the vulnerability, including how an attacker might exploit it

### What to Expect

- **Acknowledgment**: We will acknowledge receipt of your vulnerability report within 48 hours
- **Communication**: We will keep you informed about our progress toward a fix
- **Credit**: We will credit you in the security advisory (unless you prefer to remain anonymous)

### Security Updates

Security updates will be released as soon as possible after a vulnerability is confirmed. We will notify users through:

- GitHub Security Advisories
- Release notes
- Repository README updates

## Security Best Practices

When using this repository:

1. **Keep dependencies up to date**: Regularly update to the latest versions
2. **Protect secrets**: Never commit API keys, tokens, or credentials
3. **Use environment variables**: Store sensitive configuration in `.env` files
4. **Review permissions**: Ensure GitHub Actions have minimal required permissions

## Disclosure Policy

We follow responsible disclosure principles:

- Security issues are patched before public disclosure
- Public disclosure happens only after fixes are available
- Credit is given to security researchers who report vulnerabilities responsibly

Thank you for helping keep this project and our users safe!
