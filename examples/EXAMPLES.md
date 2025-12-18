# GitSecure Detection Examples

This directory contains example files that demonstrate what GitSecure can detect.

## ⚠️ WARNING
These are EXAMPLE secrets only - never commit real secrets!

## Examples by Category

### 1. AWS Credentials (HIGH Confidence)
```python
# config.py - DETECTED
AWS_ACCESS_KEY_ID = "AKIAIOSFODNN7EXAMPLE"
AWS_SECRET_ACCESS_KEY = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
```

### 2. GitHub Tokens (HIGH Confidence)
```javascript
// app.js - DETECTED
const githubToken = "ghp_1234567890abcdefghijklmnopqrstuvwxyzAB";
const personalAccessToken = "github_pat_11AAAAAA00000000000000000000000000000000000000000000000000000000000000000000000000";
```

### 3. Stripe API Keys (HIGH Confidence)
```env
# .env - DETECTED
STRIPE_SECRET_KEY=sk_live_1234567890abcdefghijklmnop
STRIPE_PUBLISHABLE_KEY=pk_live_9876543210zyxwvutsrqponmlkj
```

### 4. Database Connection Strings (HIGH Confidence)
```yaml
# config.yml - DETECTED
database:
  url: "postgresql://admin:SuperSecret123@db.example.com:5432/production"
  mongodb: "mongodb://root:password123@mongo.example.com:27017/mydb"
```

### 5. Private Keys (HIGH Confidence)
```
# id_rsa - DETECTED (filename and content)
-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEA1234567890...
-----END RSA PRIVATE KEY-----
```

### 6. Slack Tokens (HIGH Confidence)
```javascript
// slack.js - DETECTED
const slackToken = "xoxb-1234567890123-1234567890123-abcdefghijklmnopqrstuvwx";
const webhookUrl = "https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX";
```

### 7. JWT Tokens (MEDIUM Confidence)
```javascript
// auth.js - DETECTED
const jwt = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c";
```

### 8. Generic API Keys (MEDIUM Confidence)
```python
# settings.py - DETECTED
API_KEY = "1234567890abcdefghijklmnopqrstuvwxyz"
api_secret = "zyxwvutsrqponmlkjihgfedcba0987654321"
```

### 9. Passwords in Code (MEDIUM Confidence)
```javascript
// db.js - DETECTED
const config = {
    password: "SuperSecret123!",
    adminPassword: "P@ssw0rd2024"
};
```

### 10. Cloud Provider Keys
```json
// azure-config.json - DETECTED
{
    "azure": {
        "connectionString": "DefaultEndpointsProtocol=https;AccountName=myaccount;AccountKey=abcdefghij1234567890ABCDEFGHIJ1234567890abcdefghij1234567890ABCDEFGHIJ1234567890abcdefghij==;EndpointSuffix=core.windows.net"
    }
}
```

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

## Best Practices

1. ✅ Use environment variables
2. ✅ Use secret management tools (Vault, AWS Secrets Manager)
3. ✅ Add `.env` files to `.gitignore`
4. ✅ Install pre-commit hooks
5. ✅ Rotate secrets immediately if exposed
6. ❌ Never commit secrets, even in private repos
7. ❌ Don't rely on deleting commits - secrets remain in history
