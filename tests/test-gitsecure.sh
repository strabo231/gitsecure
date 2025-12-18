#!/bin/bash

# GitSecure Test Suite
# Tests all secret patterns and scanning functionality

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GITSECURE="$SCRIPT_DIR/../gitsecure"
TEST_DIR="/tmp/gitsecure-test-$$"

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

PASSED=0
FAILED=0

print_test() {
    echo -e "${BLUE}▶ TEST:${NC} $1"
}

print_pass() {
    echo -e "${GREEN}  ✓ PASS:${NC} $1"
    ((PASSED++))
}

print_fail() {
    echo -e "${RED}  ✗ FAIL:${NC} $1"
    ((FAILED++))
}

print_section() {
    echo ""
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${YELLOW}$1${NC}"
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

# Check if gitsecure exists
if [ ! -f "$GITSECURE" ]; then
    echo -e "${RED}Error: gitsecure script not found at $GITSECURE${NC}"
    exit 1
fi

# Make sure it's executable
chmod +x "$GITSECURE"

# Setup test directory
setup() {
    echo -e "${BLUE}Setting up test environment...${NC}"
    mkdir -p "$TEST_DIR"
    cd "$TEST_DIR" || exit 1
    git init -q
    git config user.email "test@example.com"
    git config user.name "Test User"
}

# Cleanup
cleanup() {
    echo -e "${BLUE}Cleaning up...${NC}"
    cd / || exit 1
    rm -rf "$TEST_DIR"
}

# Test AWS keys
test_aws_keys() {
    print_test "AWS Access Key detection"
    
    cat > test-aws.conf << 'EOF'
[default]
aws_access_key_id = AKIAIOSFODNN7EXAMPLE
aws_secret_access_key = wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
EOF
    
    if "$GITSECURE" check test-aws.conf 2>&1 | grep -qi "AWS\|secret"; then
        print_pass "Detected AWS credentials"
    else
        print_fail "Failed to detect AWS credentials"
        echo "  Debug output:"
        "$GITSECURE" check test-aws.conf 2>&1 | head -5 | sed 's/^/    /'
    fi
    
    rm -f test-aws.conf
}

# Test GitHub tokens
test_github_tokens() {
    print_test "GitHub Token detection"
    
    cat > .env << 'EOF'
GITHUB_TOKEN=ghp_1234567890abcdefghijklmnopqrstuvwxyzAB
GITHUB_PAT=github_pat_11AAAAAA0000000000000000000000000000000000000000000000000000000000000000000000000000
EOF
    
    if "$GITSECURE" check .env 2>&1 | grep -qi "github\|token\|sensitive"; then
        print_pass "Detected GitHub Token or .env file"
    else
        print_fail "Failed to detect GitHub Token"
        echo "  Debug output:"
        "$GITSECURE" check .env 2>&1 | head -5 | sed 's/^/    /'
    fi
    
    rm -f .env
}

# Test private keys
test_private_keys() {
    print_test "Private Key detection"
    
    cat > id_rsa << 'EOF'
-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEA1234567890abcdefghijklmnopqrstuvwxyz
AAAABBBBCCCCDDDDEEEEFFFFGGGGHHHHIIIIJJJJKKKKLLLLMMMM
-----END RSA PRIVATE KEY-----
EOF
    
    if "$GITSECURE" check id_rsa 2>&1 | grep -qi "private key\|sensitive\|rsa"; then
        print_pass "Detected Private Key"
    else
        print_fail "Failed to detect Private Key"
        echo "  Debug output:"
        "$GITSECURE" check id_rsa 2>&1 | head -5 | sed 's/^/    /'
    fi
    
    rm -f id_rsa
}

# Test database URLs
test_database_urls() {
    print_test "Database URL detection"
    
    cat > config.py << 'EOF'
# Database configuration
DATABASE_URL = "postgresql://dbuser:SecretPass123@db.example.com:5432/mydb"
MONGO_URI = "mongodb://admin:Password456@mongo.example.com:27017/production"
EOF
    
    if "$GITSECURE" check config.py 2>&1 | grep -qi "database\|postgresql\|mongodb\|url"; then
        print_pass "Detected Database URL"
    else
        print_fail "Failed to detect Database URL"
        echo "  Debug output:"
        "$GITSECURE" check config.py 2>&1 | head -5 | sed 's/^/    /'
    fi
    
    rm -f config.py
}

# Test Stripe keys
test_stripe_keys() {
    print_test "Stripe Key detection"
    
    cat > payments.js << 'EOF'
const stripe = require('stripe');
const STRIPE_SECRET_KEY = "sk_live_1234567890abcdefghijklmnop";
const client = stripe(STRIPE_SECRET_KEY);
EOF
    
    if "$GITSECURE" check payments.js 2>&1 | grep -qi "stripe\|api\|key"; then
        print_pass "Detected Stripe Key"
    else
        print_fail "Failed to detect Stripe Key"
        echo "  Debug output:"
        "$GITSECURE" check payments.js 2>&1 | head -5 | sed 's/^/    /'
    fi
    
    rm -f payments.js
}

# Test JWT tokens
test_jwt_tokens() {
    print_test "JWT Token detection"
    
    cat > auth.js << 'EOF'
const jwt = require('jsonwebtoken');
const token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c";
EOF
    
    if "$GITSECURE" check auth.js 2>&1 | grep -qi "jwt\|token"; then
        print_pass "Detected JWT Token"
    else
        print_fail "Failed to detect JWT Token"
        echo "  Debug output:"
        "$GITSECURE" check auth.js 2>&1 | head -5 | sed 's/^/    /'
    fi
    
    rm -f auth.js
}

# Test .env file detection
test_env_files() {
    print_test "Environment file detection"
    
    cat > .env.production << 'EOF'
API_KEY=1234567890abcdefghijklmnop
SECRET_KEY=mysecret123456789
DATABASE_PASSWORD=SuperSecret123!
EOF
    
    if "$GITSECURE" check .env.production 2>&1 | grep -qi "sensitive\|\.env\|api\|secret\|password"; then
        print_pass "Detected .env file or secrets within"
    else
        print_fail "Failed to detect .env file"
        echo "  Debug output:"
        "$GITSECURE" check .env.production 2>&1 | head -5 | sed 's/^/    /'
    fi
    
    rm -f .env.production
}

# Test clean file (should pass)
test_clean_file() {
    print_test "Clean file (should have no secrets)"
    
    cat > clean.js << 'EOF'
const config = {
    appName: "MyApp",
    version: "1.0.0",
    features: ["auth", "api", "dashboard"],
    port: 3000,
    environment: process.env.NODE_ENV || "development"
};

function greet(name) {
    return `Hello, ${name}!`;
}

module.exports = { config, greet };
EOF
    
    if "$GITSECURE" check clean.js 2>&1 | grep -qi "no secrets detected\|appears safe"; then
        print_pass "Clean file passed correctly"
    else
        print_fail "Clean file incorrectly flagged"
        echo "  Debug output:"
        "$GITSECURE" check clean.js 2>&1 | head -10 | sed 's/^/    /'
    fi
    
    rm -f clean.js
}

# Test pre-commit hook installation
test_hook_installation() {
    print_test "Pre-commit hook installation"
    
    "$GITSECURE" install-hook > /dev/null 2>&1
    
    if [ -f ".git/hooks/pre-commit" ] && [ -x ".git/hooks/pre-commit" ]; then
        if grep -q "GitSecure" ".git/hooks/pre-commit"; then
            print_pass "Pre-commit hook installed correctly"
        else
            print_fail "Pre-commit hook exists but doesn't contain GitSecure"
        fi
    else
        print_fail "Pre-commit hook installation failed"
        echo "  Debug: Check if .git/hooks/pre-commit exists and is executable"
    fi
}

# Test .gitignore protection
test_gitignore_protection() {
    print_test ".gitignore protection generation"
    
    "$GITSECURE" protect > /dev/null 2>&1
    
    if [ -f ".gitignore" ] && grep -q "GitSecure" .gitignore; then
        if grep -q ".env" .gitignore && grep -q "*.pem" .gitignore; then
            print_pass ".gitignore protection added correctly"
        else
            print_fail ".gitignore missing expected patterns"
        fi
    else
        print_fail ".gitignore protection failed"
        echo "  Debug: .gitignore not created or doesn't contain GitSecure marker"
    fi
}

# Test scan command
test_scan_command() {
    print_test "Scan staged files command"
    
    cat > bad-config.json << 'EOF'
{
    "aws_access_key": "AKIAIOSFODNN7EXAMPLE",
    "api_key": "1234567890abcdefghijklmnop"
}
EOF
    
    git add bad-config.json 2>/dev/null
    
    if "$GITSECURE" scan 2>&1 | grep -qi "potential secret\|found\|detected"; then
        print_pass "Scan detected secrets in staged files"
    else
        print_fail "Scan failed to detect secrets"
        echo "  Debug output:"
        "$GITSECURE" scan 2>&1 | head -10 | sed 's/^/    /'
    fi
    
    git reset > /dev/null 2>&1
    rm -f bad-config.json
}

# Test version command
test_version() {
    print_test "Version command"
    
    if "$GITSECURE" --version 2>&1 | grep -qi "2.0"; then
        print_pass "Version command works"
    else
        print_fail "Version command failed"
    fi
}

# Test patterns command
test_patterns_command() {
    print_test "Patterns listing command"
    
    if "$GITSECURE" patterns 2>&1 | grep -qi "aws\|github\|stripe"; then
        print_pass "Patterns command works"
    else
        print_fail "Patterns command failed"
    fi
}

# Run all tests
echo ""
echo "═══════════════════════════════════════════════════════════════"
echo "              GitSecure v2.0 Test Suite"
echo "═══════════════════════════════════════════════════════════════"
echo ""

setup

print_section "Testing Secret Detection"
test_aws_keys
test_github_tokens
test_private_keys
test_database_urls
test_stripe_keys
test_jwt_tokens
test_env_files
test_clean_file

print_section "Testing Commands & Features"
test_version
test_patterns_command
test_hook_installation
test_gitignore_protection
test_scan_command

cleanup

echo ""
echo "═══════════════════════════════════════════════════════════════"
echo "                    Test Results Summary"
echo "═══════════════════════════════════════════════════════════════"
echo ""
echo -e "${GREEN}✓ Passed: $PASSED${NC}"
echo -e "${RED}✗ Failed: $FAILED${NC}"
echo ""

TOTAL=$((PASSED + FAILED))
PERCENTAGE=$((PASSED * 100 / TOTAL))

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}🎉 All tests passed! GitSecure is working perfectly! 🎉${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    exit 0
else
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${YELLOW}⚠️  Some tests failed ($PERCENTAGE% pass rate)${NC}"
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo "Debug: Run individual tests to investigate failures"
    echo "The 'Debug output' lines above show what GitSecure actually returned"
    exit 1
fi
