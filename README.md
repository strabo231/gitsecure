[![Test GitSecure](https://github.com/strabo231/gitsecure/actions/workflows/test.yml/badge.svg)](https://github.com/strabo231/gitsecure/actions/workflows/test.yml)

# GitSecure - Git Secret Scanner and Protection Tool

Don't accidentally commit secrets! GitSecure scans for API keys, passwords, tokens, and credentials BEFORE they get into your git history.

## Why GitSecure?

**One leaked secret can cost thousands:**
- AWS keys → $10,000+ surprise bills
- API keys → Unauthorized access
- Database credentials → Data breach
- Private keys → Complete compromise

**GitSecure catches secrets before commit!**

## Installation

```bash
curl -sSL https://raw.githubusercontent.com/strabo231/gitsecure/main/install.sh | bash
```

## Quick Start

```bash
# Scan before committing
gitsecure scan

# Install automatic checking
gitsecure install-hook

# Audit entire repo
gitsecure audit

# Generate secure .gitignore
gitsecure protect
```

## Commands

```
scan                     Scan staged files for secrets
audit                    Scan entire repository
check <file>             Check specific file
patterns                 Show detected patterns
protect                  Generate secure .gitignore
install-hook             Auto-scan before every commit
report                   Generate security report
```

## What Gets Detected

✅ **AWS Access Keys** (`AKIA...`)  
✅ **GitHub Tokens** (`ghp_...`, `github_pat_...`)  
✅ **API Keys** (Stripe, Slack, Google, etc.)  
✅ **Private Keys** (RSA, SSH, PGP)  
✅ **Database Credentials** (connection strings)  
✅ **Passwords in Code**  
✅ **JWT Tokens**  
✅ **OAuth Tokens**  
✅ **Bearer Tokens**  
✅ **Sensitive Files** (`.env`, `*.pem`, `*.key`)  
✅ **100+ patterns total**  

## Features

🔍 **Pre-commit scanning** - Catch secrets before they're committed  
🚨 **Real-time detection** - Immediate feedback  
📜 **History audit** - Check entire repository  
🛡️ **Auto-protect** - Generate secure .gitignore  
📊 **Security reports** - Document your security posture  
⚡ **Fast** - Scans in seconds  
🎯 **Zero false positives focus** - Smart pattern matching  

## Examples

**Scan before commit:**
```bash
git add config.json
gitsecure scan
```
```
🚨 Possible AWS Access Key found in: config.json
  Line 23: [REDACTED for security]
✗ Found 1 potential secret(s) in staged files
✗ DO NOT COMMIT!
```

**Install pre-commit hook:**
```bash
gitsecure install-hook
```
Now every `git commit` automatically scans for secrets!

**Audit repository:**
```bash
gitsecure audit
```
```
⚠ Possible API Key found in: src/api.js
⚠ Sensitive file detected: .env.backup
🚨 Found 2 potential secret(s) in files
```

**Generate secure .gitignore:**
```bash
gitsecure protect
```
Adds patterns for `.env`, `*.pem`, `*.key`, credentials, etc.

**Check specific file:**
```bash
gitsecure check config/database.yml
```

## Use Cases

**Before Every Commit:**
```bash
gitsecure scan
```
Catch secrets before they get committed!

**New Repository Setup:**
```bash
gitsecure protect          # Secure .gitignore
gitsecure install-hook     # Auto-scanning
```

**Security Audit:**
```bash
gitsecure audit
gitsecure report
```

**Team Onboarding:**
```bash
# Add to repo setup docs:
gitsecure install-hook
```

## Pre-Commit Hook

Install once, protected forever:

```bash
gitsecure install-hook
```

Now every commit is automatically scanned:
```bash
git commit -m "Add feature"
# GitSecure automatically scans...
# ✓ No secrets detected - safe to commit!
```

If secrets found:
```bash
git commit -m "Add config"
# 🚨 Possible AWS Access Key found!
# ✗ DO NOT COMMIT!
# Commit blocked for your protection
```

## Detected Patterns

### Cloud Providers
- AWS Access Keys
- AWS Secret Keys
- Azure Keys
- Google API Keys

### Version Control
- GitHub Tokens (all types)
- GitLab Tokens
- Bitbucket Tokens

### APIs & Services
- Stripe API Keys
- Slack Tokens
- Twilio Keys
- SendGrid Keys
- Mailgun Keys

### Databases
- Connection Strings
- Database URLs
- Passwords in configs

### Cryptographic Keys
- RSA Private Keys
- SSH Private Keys
- PGP Private Keys
- Certificates

### Authentication
- JWT Tokens
- OAuth Tokens
- Bearer Tokens
- Session Tokens

### Generic Patterns
- API Keys
- Secret Keys
- Auth Tokens
- Passwords in code

## Sensitive Files

GitSecure also detects sensitive filenames:
- `.env` and `.env.*`
- `*.pem`, `*.key`
- `credentials.json`
- `secrets.json`
- SSH keys (`id_rsa`, etc.)
- VPN configs
- And more...

## Best Practices

**Always:**
1. Run `gitsecure scan` before committing
2. Install the pre-commit hook
3. Use `gitsecure protect` for new repos
4. Store secrets in environment variables
5. Use `.env` files (gitignored!)
6. Rotate leaked keys immediately

**Never:**
1. Commit `.env` files
2. Hardcode credentials
3. Share secrets in code
4. Ignore warnings

## What If I Already Committed Secrets?

If secrets are in your history:

1. **Rotate the secrets immediately!**
2. Consider tools like `git-filter-repo` or `BFG Repo-Cleaner`
3. Force push cleaned history (if safe to do so)
4. Notify affected services

**Prevention is better than cleanup!**

## License

MIT License - see [LICENSE](LICENSE)

## Author

Sean - [@strabo231](https://github.com/strabo231)

---

**Protect your secrets. Protect your reputation. Use GitSecure.** 🔐

## License

GitSecure is dual-licensed:

### Open Source (GPL v3)
Free for individuals, open source projects, and non-commercial use.
See [LICENSE-GPL3](LICENSE-GPL3) for details.

### Commercial License
Required for commercial use, proprietary software, and organizations that cannot comply with GPL v3.

**Starting at $49/year per developer**

Features include:
- Use in proprietary software
- No copyleft requirements
- Premium features (team dashboard, integrations, etc.)
- Priority support
- Compliance assistance

👉 **[Learn more about commercial licensing](COMMERCIAL.md)**

---

**Questions about licensing?** Contact: [aibackuppro@gmail.com]
