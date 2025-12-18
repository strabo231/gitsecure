# GitSecure v2.0 - Enterprise Git Secret Scanner 🔒

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](LICENSE-GPL3)
[![Commercial License](https://img.shields.io/badge/License-Commercial-green.svg)](COMMERCIAL.md)
[![Version](https://img.shields.io/badge/version-2.0.0-brightgreen.svg)](https://github.com/strabo231/gitsecure)
[![Security](https://img.shields.io/badge/security-critical-red.svg)](https://github.com/strabo231/gitsecure)

**Stop catastrophic secret leaks before they happen.** Professional-grade secret scanner that detects AWS keys, API tokens, passwords, and 50+ secret patterns with high accuracy.

> ⚠️ **One leaked AWS key can cost $10,000+ in hours.** GitSecure prevents that.

---

## 🚀 What's New in v2.0

- ✨ **50+ High-Confidence Patterns** - AWS, GitHub, Stripe, Slack, and more
- 🧠 **Entropy Analysis** - Detect generic secrets by randomness
- 📊 **HTML Security Reports** - Beautiful, shareable reports
- 🎯 **Confidence Levels** - HIGH/MEDIUM classification
- ⚡ **Faster Scanning** - Optimized pattern matching
- 📈 **Repository Statistics** - Detailed repo insights
- 🛡️ **Enhanced .gitignore** - Comprehensive protection rules

---

## 💼 Commercial Use & Licensing

GitSecure is **dual-licensed** for maximum flexibility:

### 🆓 Open Source (GPL v3)
Free for individuals, open source projects, and evaluation. Perfect for:
- Personal projects
- Open source contributions
- Learning and testing
- Non-commercial use

### 💼 Commercial License
**Required for:**
- ✅ Commercial/closed-source projects
- ✅ Companies with 5+ developers  
- ✅ Products/services using GitSecure
- ✅ Enterprise deployments

**Benefits:**
- ⚡ Priority support & SLA guarantees
- 📞 Direct communication channel
- 🎯 Feature requests & custom integrations
- 📋 Compliance assistance
- 💼 Commercial indemnification
- 🔒 Advanced features (team dashboard, SSO, audit trails)

📧 **[Contact for Commercial Licensing](mailto:aibackuppro@gmail.com)** | 💰 **[View Pricing](COMMERCIAL.md)**

---

## 💖 Support Open Source Development

Using GitSecure personally or in open source? Consider sponsoring!

[![Sponsor](https://img.shields.io/badge/Sponsor-💖_Support_GitSecure-ff69b4?style=for-the-badge&logo=github)](https://github.com/sponsors/strabo231)

**Your sponsorship helps:**
- 🔍 More secret pattern detection
- ⚡ Faster scanning algorithms  
- 🌍 Better multi-language support
- 📚 Comprehensive documentation
- 🆕 Free security tools for everyone

**Tiers:** Individual $5/mo | Supporter $15/mo | Business [Custom](COMMERCIAL.md)

---

## 🎯 Why GitSecure?

### The Problem
Secret leaks are **catastrophic and expensive**:
- 💸 **AWS keys leaked** → $10,000+ charges in hours
- 🔓 **API tokens exposed** → Data breaches & compliance violations
- 🗄️ **Database credentials committed** → Complete security compromise
- 💔 **One mistake can destroy a company**

### The Solution
**GitSecure provides automated, professional-grade secret detection:**
- 🛡️ Scan before every commit (pre-commit hook)
- 🎯 Detect 50+ specific secret patterns with high accuracy
- 🧠 Entropy analysis for generic secrets
- 🚫 Block dangerous commits automatically  
- 📊 Audit entire repository history
- 📈 Generate beautiful HTML reports
- ⚡ Zero false positives on well-tuned patterns

---

## 📦 Installation

### Quick Install (Recommended)
```bash
curl -sSL https://raw.githubusercontent.com/strabo231/gitsecure/main/install.sh | bash
```

### Manual Install
```bash
# Download
curl -O https://raw.githubusercontent.com/strabo231/gitsecure/main/gitsecure
chmod +x gitsecure

# Move to PATH
sudo mv gitsecure /usr/local/bin/
# or for user install
mkdir -p ~/.local/bin && mv gitsecure ~/.local/bin/
```

### Verify Installation
```bash
gitsecure --version
# Should output: gitsecure version 2.0.0
```

---

## 🚀 Quick Start

### 1. Install Pre-Commit Hook (Recommended)
```bash
cd your-repo
gitsecure install-hook
```
Now **every commit is automatically scanned** for secrets! 🔒

### 2. Scan Staged Files
```bash
# Make changes
git add .

# Scan before commit
gitsecure scan
```

### 3. Audit Entire Repository
```bash
# Check all tracked files for secrets
gitsecure audit
```

### 4. Generate Security Report
```bash
# Create beautiful HTML report
gitsecure report

# Opens automatically in browser
```

---

## 🔍 What Gets Detected

### High Confidence Patterns (50+)
- ✅ **AWS** - Access Keys, Secret Keys, Session Tokens
- ✅ **GitHub** - PAT, OAuth, App Tokens, Refresh Tokens
- ✅ **Stripe** - Live Keys, Secret Keys, Restricted Keys
- ✅ **Google Cloud** - API Keys, OAuth Tokens, Service Accounts
- ✅ **Slack** - Bot Tokens, Webhooks, Legacy Tokens
- ✅ **Private Keys** - RSA, SSH, EC, PGP, DSA
- ✅ **Database URLs** - PostgreSQL, MySQL, MongoDB, Redis
- ✅ **Twilio** - API Keys, Account SIDs
- ✅ **SendGrid** - API Keys
- ✅ **Discord** - Bot Tokens, Webhooks
- ✅ **Telegram** - Bot Tokens
- ✅ **DigitalOcean** - Personal Access Tokens
- ✅ **Heroku** - API Keys
- ✅ **Azure** - Storage Keys, Connection Strings

### Medium Confidence Patterns
- ⚠️ JWT Tokens
- ⚠️ Generic API Keys
- ⚠️ Generic Secrets & Tokens
- ⚠️ Bearer Tokens
- ⚠️ Passwords in Code

### Sensitive Files
- 🔒 `.env`, `.env.*` files
- 🔒 Private key files (`.pem`, `.key`, `id_rsa`)
- 🔒 Certificate files (`.p12`, `.pfx`)
- 🔒 Config files (`credentials.json`, `secrets.json`)

### Advanced Features
- 🧠 **Entropy Analysis** - Detects high-randomness strings (likely secrets)
- 📁 **Smart File Filtering** - Ignores binary/minified files
- 🎯 **Context-Aware** - Understands code structure

---

## 📖 Usage Guide

### Commands

#### `scan` - Scan Staged Files
Scans files staged for commit. **Perfect for pre-commit hooks.**
```bash
gitsecure scan
```

#### `audit` - Full Repository Audit
Scans all tracked files in the repository.
```bash
gitsecure audit
```

#### `check <file>` - Check Specific File
Scan a single file with detailed output.
```bash
gitsecure check config.json
gitsecure check .env.production
```

#### `patterns` - Show Detection Patterns
List all secret patterns GitSecure can detect.
```bash
gitsecure patterns
```

#### `protect` - Generate Secure .gitignore
Adds comprehensive secret protection rules to `.gitignore`.
```bash
gitsecure protect
```

#### `install-hook` - Install Pre-Commit Hook
Installs automatic scanning on every commit.
```bash
gitsecure install-hook
```

#### `uninstall-hook` - Remove Pre-Commit Hook
Removes the pre-commit hook.
```bash
gitsecure uninstall-hook
```

#### `report` - Generate HTML Report
Creates a beautiful, shareable security report.
```bash
gitsecure report
# Opens in browser automatically
```

#### `stats` - Repository Statistics
Show repository metrics and security status.
```bash
gitsecure stats
```

---

## 🛡️ Pre-Commit Hook

The pre-commit hook is the **most powerful feature** - it automatically scans every commit and blocks secrets from entering your repository.

### Install
```bash
cd your-repository
gitsecure install-hook
```

### How It Works
1. You stage files with `git add`
2. You run `git commit`
3. **GitSecure automatically scans** staged files
4. If secrets found → **commit is blocked** ❌
5. If clean → **commit proceeds** ✅

### Example Output
```bash
$ git commit -m "Add config"
🔍 GitSecure: Scanning for secrets...

═══════════════════════════════════════════════════════════════
              🔍 SCANNING STAGED FILES FOR SECRETS
═══════════════════════════════════════════════════════════════

🚨 AWS Access Key detected: config.py
  → Line 5: [REDACTED for security]

═══════════════════════════════════════════════════════════════
                        📊 SCAN RESULTS
═══════════════════════════════════════════════════════════════

🚨 Found 1 potential secret(s) in staged files
🛑 COMMIT BLOCKED - DO NOT COMMIT!

🔧 Recommended Actions:
  → 1. Remove secrets from files
  → 2. Use environment variables instead
  → 3. Add sensitive files to .gitignore
```

### Bypass (Not Recommended)
```bash
# Only if you're absolutely sure
git commit --no-verify
```

---

## 📊 HTML Reports

Generate professional security reports perfect for:
- 📋 Compliance audits
- 👥 Team reviews  
- 📈 Security tracking
- 🗂️ Documentation

```bash
gitsecure report
```

**Features:**
- 🎨 Beautiful, modern design
- 📊 Visual metrics & statistics
- 🔍 Detailed scan results
- 💡 Actionable recommendations
- 📤 Easy sharing & archiving

---

## 🎯 Best Practices

### ✅ DO
1. **Install pre-commit hook** - Prevent secrets from entering repo
2. **Use environment variables** - Never hardcode secrets
3. **Use secret management** - Vault, AWS Secrets Manager, Doppler
4. **Generate .gitignore protection** - Run `gitsecure protect`
5. **Regular audits** - Run `gitsecure audit` monthly
6. **Rotate exposed secrets immediately** - Assume compromised

### ❌ DON'T
1. **Don't commit secrets** - Even in private repos
2. **Don't rely on deleting commits** - Secrets remain in history
3. **Don't store secrets in code** - Use environment variables
4. **Don't ignore warnings** - Every detection matters
5. **Don't use `--no-verify`** - Defeats the purpose

---

## 🔧 Advanced Configuration

### Entropy Threshold
Default: 4.5 (detects high-randomness strings)
```bash
# Edit in gitsecure script
ENTROPY_THRESHOLD=4.5
```

### Minimum Secret Length
Default: 20 characters
```bash
# Edit in gitsecure script
MIN_SECRET_LENGTH=20
```

### Custom Patterns
Add custom patterns by editing the `SECRET_PATTERNS` array in the script.

---

## 🆚 Comparison with Other Tools

| Feature | GitSecure | git-secrets | gitleaks | truffleHog |
|---------|-----------|-------------|----------|------------|
| **Easy Install** | ✅ One-liner | ⚠️ Complex | ✅ Go binary | ⚠️ Python |
| **Pre-commit Hook** | ✅ Auto-install | ✅ Manual | ✅ Manual | ❌ No |
| **Pattern Count** | ✅ 50+ | ⚠️ Basic | ✅ 50+ | ✅ Many |
| **Entropy Detection** | ✅ Yes | ❌ No | ✅ Yes | ✅ Yes |
| **HTML Reports** | ✅ Yes | ❌ No | ⚠️ JSON | ⚠️ JSON |
| **Zero Config** | ✅ Yes | ❌ No | ⚠️ Some | ❌ No |
| **Speed** | ✅ Fast (Bash) | ✅ Fast | ✅ Fast (Go) | ⚠️ Slow |
| **Commercial Support** | ✅ Available | ❌ No | ✅ Yes | ❌ No |

---

## 🧪 Testing

Run the comprehensive test suite:
```bash
./test-gitsecure.sh
```

Tests cover:
- ✅ All secret pattern detection
- ✅ File scanning accuracy  
- ✅ Pre-commit hook functionality
- ✅ .gitignore generation
- ✅ Clean file handling (no false positives)

---

## 🤝 Contributing

We welcome contributions! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

**Areas we need help:**
- 🔍 Additional secret patterns
- 🌍 Language-specific patterns
- ⚡ Performance improvements
- 📚 Documentation
- 🧪 More test cases

---

## 📜 License & Support

### Open Source (GPL v3)
Free for individuals and open source projects. See [LICENSE-GPL3](LICENSE-GPL3).

### Commercial Use
Commercial license required for businesses. See [COMMERCIAL.md](COMMERCIAL.md) for pricing.

### Get Help
- 💬 [GitHub Discussions](https://github.com/strabo231/gitsecure/discussions)
- 🐛 [Report Issues](https://github.com/strabo231/gitsecure/issues)
- 💼 [Commercial Licensing](mailto:aibackuppro@gmail.com)
- 💖 [Become a Sponsor](https://github.com/sponsors/strabo231)

---

## 🌟 Star Us!

If GitSecure saved you from a secret leak, please star the repository!

[![GitHub Stars](https://img.shields.io/github/stars/strabo231/gitsecure?style=social)](https://github.com/strabo231/gitsecure/stargazers)

---

## 📈 Statistics

- **50+ Secret Patterns** detected
- **Zero Configuration** required
- **One-Line Install** in seconds
- **100% Bash** - No dependencies
- **Used by 1000+** developers worldwide (growing!)

---

## 🎓 Learn More

- 📖 [Pattern Examples](EXAMPLES.md) - See what gets detected
- 🔧 [Best Practices Guide](docs/best-practices.md)
- 🏢 [Enterprise Guide](docs/enterprise.md)
- 🔌 [CI/CD Integration](docs/ci-cd-integration.md)

---

**Built with ❤️ by [strabo231](https://github.com/strabo231)** | **Securing developers worldwide** 🔒

*Remember: The best secret is the one that never gets committed.*
