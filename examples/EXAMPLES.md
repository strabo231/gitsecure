# GitSecure Detection Examples

This directory contains example files that demonstrate what GitSecure can detect.

## ⚠️ IMPORTANT
**These are EXAMPLE/FAKE secrets for demonstration only!**
- All tokens are invalid and will not work
- Never commit real secrets, even as examples
- These patterns are detected by GitSecure

---

## Examples by Category

### 1. AWS Credentials (HIGH Confidence)
```python
# config.py - DETECTED
AWS_ACCESS_KEY_ID = "AKIAIOSFODNN7EXAMPLE"  # EXAMPLE ONLY - NOT REAL
AWS_SECRET_ACCESS_KEY = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"  # EXAMPLE
```

### 2. GitHub Tokens (HIGH Confidence)
```javascript
// app.js - DETECTED
const githubToken = "ghp_ExampleToken1234567890abcdefghijklmnop";  // FAKE
const personalAccessToken = "github_pat_EXAMPLE00000000000000000000000000000000000000000000";  // FAKE
```

### 3. Stripe API Keys (HIGH Confidence)
```env
# .env - DETECTED
STRIPE_SECRET_KEY=sk_test_ExampleKey1234567890abcde  # TEST KEY EXAMPLE
STRIPE_PUBLISHABLE_KEY=pk_test_Example9876543210zyxwvu  # TEST KEY EXAMPLE
```

### 4. Database Connection Strings (HIGH Confidence)
```yaml
# config.yml - DETECTED
database:
  url: "postgresql://exampleuser:ExamplePass123@db.example.com:5432/testdb"  # FAKE
  mongodb: "mongodb://testuser:testpass123@mongo.example.com:27017/testdb"  # FAKE
```

### 5. Private Keys (HIGH Confidence)
```
# id_rsa - DETECTED (filename and content)
-----BEGIN RSA PRIVATE KEY-----
EXAMPLE_KEY_DATA_NOT_A_REAL_KEY_1234567890
-----END RSA PRIVATE KEY-----
```

### 6. Slack Tokens (HIGH Confidence)
```javascript
// slack.js - DETECTED
const slackToken = "xoxb-000000000000-000000000000-ExampleTokenNotReal1234";  // FAKE
const webhookUrl = "https://hooks.slack.com/services/T00000000/B00000000/ExampleWebhookNotReal123456";  // FAKE
```

### 7. JWT Tokens (MEDIUM Confidence)
```javascript
// auth.js - DETECTED
// This is a REAL JWT structure but with fake payload - for demo only
const jwt = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJleGFtcGxlIiwibmFtZSI6IlRlc3QgVXNlciIsImlhdCI6MTUxNjIzOTAyMn0.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c";
```

### 8. Generic API Keys (MEDIUM Confidence)
```python
# settings.py - DETECTED
API_KEY = "example_key_1234567890abcdefghijklmnop"  # FAKE
api_secret = "example_secret_zyxwvutsrqponmlkjihgfedcba"  # FAKE
```

### 9. Passwords in Code (MEDIUM Confidence)
```javascript
// db.js - DETECTED
const config = {
    password: "ExamplePassword123!",  // NEVER DO THIS - EXAMPLE ONLY
    adminPassword: "TestP@ssw0rd2024"  // FAKE EXAMPLE
};
```

### 10. Cloud Provider Keys
```json
// azure-config.json - DETECTED
{
    "azure": {
        "connectionString": "DefaultEndpointsProtocol=https;AccountName=example;AccountKey=ExampleKeyABCDEF1234567890==;EndpointSuffix=core.windows.net"
    }
}
```

---

## Safe Examples (NOT Detected)

### ✅ Environment Variable Usage
```javascript
// Good - uses environment variables
const apiKey = process.env.API_KEY;
const dbPassword = process.env.DATABASE_PASSWORD;
```

### ✅ Example/Template Files
```env
# .env.example - Safe
API_KEY=your_api_key_here
DATABASE_URL=postgresql://user:password@localhost:5432/db
```

### ✅ Configuration References
```yaml
# config.yml - Safe
database:
  url: ${DATABASE_URL}
api:
  key: ${API_KEY}
```

---

## Testing GitSecure

Try scanning these examples:

```bash
# Check a specific file
gitsecure check examples/bad-config.py

# Stage a file and scan
git add examples/bad-secrets.js
gitsecure scan

# Audit all examples
gitsecure audit
```

---

## Best Practices

1. ✅ Use environment variables
2. ✅ Use secret management tools (Vault, AWS Secrets Manager)
3. ✅ Add `.env` files to `.gitignore`
4. ✅ Install pre-commit hooks
5. ✅ Rotate secrets immediately if exposed
6. ❌ Never commit secrets, even in private repos
7. ❌ Don't rely on deleting commits - secrets remain in history

---

**Note:** All examples above are fake/invalid credentials for demonstration purposes only.