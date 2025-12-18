# GitSecure - Git Secret Scanner

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](LICENSE-GPL3)
[![Commercial License](https://img.shields.io/badge/License-Commercial-green.svg)](COMMERCIAL.md)
[![GitHub Stars](https://img.shields.io/github/stars/strabo231/gitsecure?style=social)](https://github.com/strabo231/gitsecure/stargazers)
[![GitHub Issues](https://img.shields.io/github/issues/strabo231/gitsecure)](https://github.com/strabo231/gitsecure/issues)
[![Security](https://img.shields.io/badge/security-critical-red.svg)](https://github.com/strabo231/gitsecure)
[![GitHub Sponsors](https://img.shields.io/github/sponsors/strabo231?label=Sponsor&logo=github&color=ff69b4)](https://github.com/sponsors/strabo231)

**Stop catastrophic secret leaks before they happen.** Scan for AWS keys, API tokens, passwords, and 100+ secret patterns.

> ⚠️ **One leaked AWS key can cost $10,000+ in hours.** GitSecure prevents that.

---

## 💼 Commercial Use & Licensing

GitSecure is **dual-licensed** for maximum flexibility:

### 🆓 Open Source (GPL v3)
Free for individuals, open source projects, and evaluation.

### 💼 Commercial License
**Required for:**
- ✅ Commercial/closed-source projects
- ✅ Companies with 5+ developers
- ✅ Products/services using GitSecure

**Benefits:**
- ⚡ Priority support
- 📞 Direct communication channel
- 🎯 Feature requests
- 📋 SLA guarantees
- 💼 Commercial indemnification

📧 **[Contact for Commercial Licensing](mailto:your-email@example.com)** | 💰 **[View Pricing](COMMERCIAL.md)**

---

## 💖 Support Open Source Development

Using GitSecure personally or in open source? Consider sponsoring!

[![Sponsor](https://img.shields.io/badge/Sponsor-💖_Support_GitSecure-ff69b4?style=for-the-badge&logo=github)](https://github.com/sponsors/strabo231)

**Your sponsorship helps:**
- 🔐 More secret pattern detection
- ⚡ Faster scanning algorithms
- 🌍 Better multi-language support
- 📚 Comprehensive documentation
- 🆕 Free security tools for everyone

**Individual:** $5/month | **Supporter:** $15/month | **Business:** [Custom pricing](COMMERCIAL.md)

---

## Why GitSecure?

**The Problem:** Secret leaks are catastrophic
- AWS keys leaked → $10,000+ charges in hours
- API tokens exposed → Data breaches
- Database credentials committed → Security nightmare
- One mistake can sink a company

**The Solution:** Automated secret detection
- Scan before every commit (pre-commit hook)
- Detect 100+ secret patterns
- Block dangerous commits automatically
- Audit entire repository history
- Zero false positives mode

## Installation
```bash
curl -sSL https://raw.githubusercontent.com/strabo231/gitsecure/main/install.sh | bash
```

## Quick Start
```bash
# Install pre-commit hook (blocks secrets automatically)
gitsecure install-hook

# Scan staged files
gitsecure scan

# Audit entire repository history
gitsecure audit

# Generate security report
gitsecure report
```

## What It Detects

✅ AWS Access Keys & Secret Keys  
✅ GitHub Personal Access Tokens  
✅ Stripe API Keys  
✅ Slack Tokens  
✅ Google API Keys  
✅ Private Keys (RSA, SSH, PGP)  
✅ Database Credentials  
✅ JWT Tokens  
✅ OAuth Tokens  
✅ Passwords in Code  
✅ 100+ patterns total  

[... rest of your existing README content ...]

---

## 📜 License & Support

### Open Source (GPL v3)
Free for individuals and open source projects. See [LICENSE-GPL3](LICENSE-GPL3).

### Commercial Use
Commercial license required for businesses. See [COMMERCIAL.md](COMMERCIAL.md) for pricing.

### Questions?
- 💬 [GitHub Discussions](https://github.com/strabo231/gitsecure/discussions)
- 🐛 [Report Issues](https://github.com/strabo231/gitsecure/issues)
- 💼 [Commercial Licensing](mailto:your-email@example.com)
- 💖 [Become a Sponsor](https://github.com/sponsors/strabo231)

---

**(https://github.com/strabo231)** | **Securing developers worldwide** 🔐