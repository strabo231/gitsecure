# GitSecure CI/CD Integration Guide

Integrate GitSecure into your CI/CD pipeline to catch secrets before they reach production.

---

## 🚀 Quick Setup

### GitHub Actions

Create `.github/workflows/gitsecure.yml`:

```yaml
name: GitSecure Scan

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  secret-scan:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v3
      with:
        fetch-depth: 0  # Full history for audit
    
    - name: Install GitSecure
      run: |
        curl -sSL https://raw.githubusercontent.com/strabo231/gitsecure/main/gitsecure -o gitsecure
        chmod +x gitsecure
        sudo mv gitsecure /usr/local/bin/
    
    - name: Scan for secrets
      run: gitsecure audit
    
    - name: Generate report
      if: always()
      run: gitsecure report
    
    - name: Upload report
      if: always()
      uses: actions/upload-artifact@v3
      with:
        name: gitsecure-report
        path: gitsecure-report-*.html
```

### GitLab CI

Add to `.gitlab-ci.yml`:

```yaml
gitsecure:
  stage: test
  image: ubuntu:latest
  
  before_script:
    - apt-get update && apt-get install -y curl git
    - curl -sSL https://raw.githubusercontent.com/strabo231/gitsecure/main/gitsecure -o /usr/local/bin/gitsecure
    - chmod +x /usr/local/bin/gitsecure
  
  script:
    - gitsecure audit
    - gitsecure report
  
  artifacts:
    when: always
    paths:
      - gitsecure-report-*.html
    expire_in: 30 days
  
  only:
    - merge_requests
    - main
    - develop
```

### CircleCI

Add to `.circleci/config.yml`:

```yaml
version: 2.1

jobs:
  secret-scan:
    docker:
      - image: cimg/base:stable
    
    steps:
      - checkout
      
      - run:
          name: Install GitSecure
          command: |
            curl -sSL https://raw.githubusercontent.com/strabo231/gitsecure/main/gitsecure -o gitsecure
            chmod +x gitsecure
            sudo mv gitsecure /usr/local/bin/
      
      - run:
          name: Scan for secrets
          command: gitsecure audit
      
      - run:
          name: Generate report
          command: gitsecure report
          when: always
      
      - store_artifacts:
          path: gitsecure-report-*.html
          destination: security-reports

workflows:
  version: 2
  build-and-scan:
    jobs:
      - secret-scan
```

### Jenkins

Add to `Jenkinsfile`:

```groovy
pipeline {
    agent any
    
    stages {
        stage('Install GitSecure') {
            steps {
                sh '''
                    curl -sSL https://raw.githubusercontent.com/strabo231/gitsecure/main/gitsecure -o gitsecure
                    chmod +x gitsecure
                    sudo mv gitsecure /usr/local/bin/
                '''
            }
        }
        
        stage('Scan for Secrets') {
            steps {
                sh 'gitsecure audit'
            }
        }
        
        stage('Generate Report') {
            steps {
                sh 'gitsecure report'
                archiveArtifacts artifacts: 'gitsecure-report-*.html', fingerprint: true
            }
        }
    }
    
    post {
        failure {
            emailext(
                subject: "🚨 Secrets detected in ${env.JOB_NAME}",
                body: "GitSecure found potential secrets in your code. Check the report.",
                to: "${env.CHANGE_AUTHOR_EMAIL}"
            )
        }
    }
}
```

### Bitbucket Pipelines

Add to `bitbucket-pipelines.yml`:

```yaml
image: atlassian/default-image:3

pipelines:
  default:
    - step:
        name: GitSecure Scan
        script:
          - curl -sSL https://raw.githubusercontent.com/strabo231/gitsecure/main/gitsecure -o gitsecure
          - chmod +x gitsecure
          - mv gitsecure /usr/local/bin/
          - gitsecure audit
          - gitsecure report
        artifacts:
          - gitsecure-report-*.html
  
  pull-requests:
    '**':
      - step:
          name: PR Secret Scan
          script:
            - curl -sSL https://raw.githubusercontent.com/strabo231/gitsecure/main/gitsecure -o gitsecure
            - chmod +x gitsecure
            - mv gitsecure /usr/local/bin/
            - gitsecure scan
```

### Travis CI

Add to `.travis.yml`:

```yaml
language: bash

before_install:
  - curl -sSL https://raw.githubusercontent.com/strabo231/gitsecure/main/gitsecure -o gitsecure
  - chmod +x gitsecure
  - sudo mv gitsecure /usr/local/bin/

script:
  - gitsecure audit

after_script:
  - gitsecure report

deploy:
  provider: pages
  skip_cleanup: true
  github_token: $GITHUB_TOKEN
  keep_history: false
  local_dir: .
  on:
    branch: main
```

---

## 🔧 Advanced Configurations

### Fail on Any Detection (Strict Mode)

```bash
# Exit with error if any secrets found
gitsecure audit
if [ $? -ne 0 ]; then
    echo "🚨 Secrets detected - build failed"
    exit 1
fi
```

### Scan Only Changed Files (PR)

```yaml
# GitHub Actions
- name: Get changed files
  id: changed-files
  uses: tj-actions/changed-files@v35

- name: Scan changed files
  run: |
    for file in ${{ steps.changed-files.outputs.all_changed_files }}; do
      gitsecure check "$file"
    done
```

### Custom Notification (Slack)

```bash
# After scanning
if gitsecure audit 2>&1 | grep -q "Found"; then
    curl -X POST -H 'Content-type: application/json' \
    --data '{"text":"🚨 Secrets detected in repository!"}' \
    $SLACK_WEBHOOK_URL
fi
```

### Scheduled Audits

```yaml
# GitHub Actions - Run daily
on:
  schedule:
    - cron: '0 2 * * *'  # 2 AM daily
  workflow_dispatch:  # Manual trigger

jobs:
  scheduled-audit:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
        with:
          fetch-depth: 0
      
      - name: Install GitSecure
        run: |
          curl -sSL https://raw.githubusercontent.com/strabo231/gitsecure/main/gitsecure -o gitsecure
          chmod +x gitsecure
          sudo mv gitsecure /usr/local/bin/
      
      - name: Full audit
        run: gitsecure audit
      
      - name: Generate report
        run: gitsecure report
      
      - name: Upload to S3
        run: |
          aws s3 cp gitsecure-report-*.html s3://security-reports/gitsecure/
```

---

## 🐳 Docker Integration

### Dockerfile

```dockerfile
FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    git \
    curl \
    bash \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sSL https://raw.githubusercontent.com/strabo231/gitsecure/main/gitsecure \
    -o /usr/local/bin/gitsecure && \
    chmod +x /usr/local/bin/gitsecure

WORKDIR /repo

ENTRYPOINT ["gitsecure"]
CMD ["audit"]
```

### Build and Run

```bash
# Build
docker build -t gitsecure .

# Run
docker run -v $(pwd):/repo gitsecure audit
docker run -v $(pwd):/repo gitsecure scan
```

### Docker Compose

```yaml
version: '3.8'

services:
  gitsecure:
    build: .
    volumes:
      - .:/repo
    command: audit
```

---

## 📊 Report Integration

### Save to Artifacts

Most CI systems support artifact storage:

**GitHub Actions:**
```yaml
- uses: actions/upload-artifact@v3
  with:
    name: security-report
    path: gitsecure-report-*.html
```

**GitLab CI:**
```yaml
artifacts:
  paths:
    - gitsecure-report-*.html
  expire_in: 1 week
```

### Email Reports

```bash
# Using sendmail
gitsecure report
cat gitsecure-report-*.html | mail -s "Security Scan Report" security@company.com

# Using AWS SES
aws ses send-email \
  --from security@company.com \
  --to team@company.com \
  --subject "GitSecure Report" \
  --html file://gitsecure-report-*.html
```

---

## 🔐 Best Practices for CI/CD

1. **Always scan on PR** - Catch secrets before merge
2. **Daily audits** - Schedule regular full scans
3. **Fail fast** - Block builds if secrets detected
4. **Archive reports** - Keep historical security data
5. **Notify on failure** - Alert security team immediately
6. **Scan infrastructure code** - Don't forget IaC files
7. **Use dedicated credentials** - CI needs minimal permissions

---

## 🚨 Handling Failures

### Strategy 1: Block Merge
```yaml
# Make scan required for merge
- name: Secret scan (required)
  run: |
    gitsecure audit
    if [ $? -ne 0 ]; then
      echo "::error::Secrets detected - merge blocked"
      exit 1
    fi
```

### Strategy 2: Warn Only (Gradual Rollout)
```yaml
- name: Secret scan (warning)
  run: |
    gitsecure audit || echo "::warning::Secrets may be present"
  continue-on-error: true
```

### Strategy 3: Create Issue
```yaml
- name: Create issue if secrets found
  if: failure()
  uses: actions/github-script@v6
  with:
    script: |
      github.rest.issues.create({
        owner: context.repo.owner,
        repo: context.repo.repo,
        title: '🚨 Secrets detected in codebase',
        body: 'GitSecure scan found potential secrets. Review immediately.',
        labels: ['security', 'urgent']
      })
```

---

## 💡 Tips for Large Repositories

```bash
# Scan only recent commits
git diff HEAD~10 --name-only | while read file; do
  gitsecure check "$file"
done

# Parallel scanning (if you have many files)
git ls-files | parallel -j4 gitsecure check {}

# Cache installation between runs
# GitHub Actions
- uses: actions/cache@v3
  with:
    path: /usr/local/bin/gitsecure
    key: gitsecure-2.0.0
```

---

## 📞 Support

Need help integrating GitSecure into your CI/CD pipeline?

- 💬 [GitHub Discussions](https://github.com/strabo231/gitsecure/discussions)
- 💼 [Enterprise Support](mailto:aibackuppro@gmail.com)
- 📖 [Full Documentation](https://github.com/strabo231/gitsecure)

---

**Secure your pipeline. Protect your secrets. Sleep better.** 🔒
