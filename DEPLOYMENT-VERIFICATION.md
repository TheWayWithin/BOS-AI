# BOS-AI Deployment Verification Guide

## ⚠️ Critical: Test in Business Projects Only

**DO NOT test BOS-AI deployment in the BOS-AI development repository!**

Testing here would overwrite AGENT-11 development tools with BOS-AI business agents, breaking the development environment.

## 🧪 How to Test BOS-AI Deployment

### Option 1: Create Test Business Project

```bash
# Create a fresh test project
mkdir ~/bos-ai-test-business
cd ~/bos-ai-test-business

# Initialize as a business project
echo "# Test Business" > README.md
mkdir documents

# Run BOS-AI installation
curl -fsSL https://raw.githubusercontent.com/TheWayWithin/BOS-AI/main/deployment/scripts/install.sh | bash -s full

# Verify deployment (see checklist below)
```

### Option 2: Use Existing Business Project

```bash
# Navigate to an actual business project
cd ~/my-actual-business

# Run BOS-AI installation
curl -fsSL https://raw.githubusercontent.com/TheWayWithin/BOS-AI/main/deployment/scripts/install.sh | bash -s full

# Verify deployment (see checklist below)
```

### Option 3: Local Deployment Testing

```bash
# In a test business directory (NOT BOS-AI repo)
cd ~/test-business

# Clone BOS-AI temporarily
git clone https://github.com/TheWayWithin/BOS-AI.git /tmp/bos-ai-temp
cd /tmp/bos-ai-temp

# Run local deployment
./deployment/scripts/deploy-bos-ai.sh

# This will deploy to /tmp/bos-ai-temp/.claude/
# Verify the deployment there
```

## ✅ Deployment Verification Checklist

After running deployment, verify:

### 1. Correct CLAUDE.md Version

**Two CLAUDE.md Files Should Exist:**

```bash
# Check .claude/CLAUDE.md (BOS-AI system documentation)
head -3 .claude/CLAUDE.md

# Check root CLAUDE.md (project-specific instructions)
head -3 CLAUDE.md
```

**Expected .claude/CLAUDE.md Output:**
```
# 🚀 BOS-AI - Your AI-Powered Business Operating System

Welcome to BOS-AI - Transform your business through exponential growth via Business Chassis optimization.
```

**Expected Root CLAUDE.md Output (created on first deployment):**
```
# Project with BOS-AI

This project uses BOS-AI for business operations management.
```

**❌ Wrong if .claude/CLAUDE.md shows:**
```
# 🔧 BOS-AI Development Environment (AGENT-11)

**⚠️ CRITICAL: This is the BOS-AI DEVELOPMENT repository**
```
(This would indicate the development version was deployed instead of the business version)

**Note:** Root CLAUDE.md may be customized by users. It's protected and will NOT be overwritten on re-deployment

AGENT-11 is a framework for deploying specialized AI agents...
```

### 2. Business Agents Deployed (NOT Development Agents)
```bash
# List deployed agents
ls .claude/agents/

# Should show BOS-AI agents like:
# - chassis-intelligence.md
# - market-intelligence.md
# - revenue-optimization.md
# - pipeline-management.md
# etc.

# Should NOT show AGENT-11 agents:
# - developer.md
# - tester.md
# - architect.md
```

### 3. Business Commands Available
```bash
# Check commands
ls .claude/commands/

# Should show:
# - coord.md (business orchestration)
# - meeting.md (agent consultation)
# - report.md (business progress)
# - pmd.md (business diagnostics)
```

### 4. Business Missions Deployed
```bash
# Check missions
ls .claude/missions/

# Should show business missions:
# - marketing-system-setup.md
# - sales-bible-creation.md
# - customer-service-system-setup.md
# - finance-system-setup.md
# etc.
```

### 5. Document Library Available
```bash
# Check document templates
ls .claude/document-library/Foundation/
ls .claude/document-library/Operations/

# Should have business templates:
# - Vision and Mission.md
# - Marketing Bible.md
# - Sales Bible.md
# - Finance Bible.md
# etc.
```

### 6. Test Commands in Claude Code

Open Claude Code in the test project and try:

```bash
# 1. Test business optimization
/coord optimize

# 2. Test agent consultation
/meeting @chassis-intelligence "explain the Business Chassis formula"

# 3. Test mission execution
/coord marketing-bible-creation

# 4. Verify agents respond with BUSINESS context, not code development
```

## 🔍 Automated Verification Script

```bash
#!/bin/bash
# Run in deployed business project

echo "🔍 Verifying BOS-AI Deployment..."

# Check 1: CLAUDE.md version
if grep -q "BOS-AI.*Business Operating System" .claude/CLAUDE.md; then
    echo "✅ CLAUDE.md: BOS-AI version"
else
    echo "❌ CLAUDE.md: WRONG VERSION (AGENT-11 detected)"
    exit 1
fi

# Check 2: Business agents present
if [ -f ".claude/agents/chassis-intelligence.md" ]; then
    echo "✅ Agents: BOS-AI business agents"
else
    echo "❌ Agents: Missing business agents"
    exit 1
fi

# Check 3: No development agents
if [ -f ".claude/agents/developer.md" ]; then
    echo "❌ Agents: AGENT-11 development agents found (WRONG)"
    exit 1
else
    echo "✅ Agents: No development agents (correct)"
fi

# Check 4: Commands
if [ -f ".claude/commands/coord.md" ]; then
    echo "✅ Commands: Business commands present"
else
    echo "❌ Commands: Missing business commands"
    exit 1
fi

# Check 5: Document Library
if [ -d ".claude/document-library/Operations" ]; then
    echo "✅ Library: Document templates present"
else
    echo "❌ Library: Missing document templates"
    exit 1
fi

echo ""
echo "✅ BOS-AI Deployment Verified Successfully!"
echo ""
echo "Next steps:"
echo "1. Open Claude Code: code ."
echo "2. Try: /coord optimize"
echo "3. Try: /meeting @chassis-intelligence 'help'"
```

Save as `verify-deployment.sh` and run:
```bash
chmod +x verify-deployment.sh
./verify-deployment.sh
```

## 🚨 Common Issues

### Issue 1: AGENT-11 Version Deployed
**Symptom:** `.claude/CLAUDE.md` shows "AGENT-11 is a framework..."

**Cause:** Root `CLAUDE.md` contained AGENT-11 version

**Fix:** This should be fixed in latest version. Re-run deployment or manually:
```bash
# Download correct version
curl -o .claude/CLAUDE.md https://raw.githubusercontent.com/TheWayWithin/BOS-AI/main/CLAUDE.md
```

### Issue 2: Development Agents Present
**Symptom:** `.claude/agents/developer.md` exists

**Cause:** Wrong agent suite deployed

**Fix:** Clean and redeploy:
```bash
rm -rf .claude/agents
./deployment/scripts/deploy-bos-ai.sh
```

### Issue 3: Mixed Agent Suites
**Symptom:** Both business and development agents present

**Cause:** Previous deployment remnants

**Fix:** Complete cleanup:
```bash
rm -rf .claude
curl -fsSL https://raw.githubusercontent.com/TheWayWithin/BOS-AI/main/deployment/scripts/install.sh | bash -s full
```

## 📊 Testing Matrix

| Scenario | Expected Result | Verification Command |
|----------|----------------|---------------------|
| Fresh project installation | BOS-AI business suite | `verify-deployment.sh` |
| Upgrade existing BOS-AI | BOS-AI business suite | Check `.claude/CLAUDE.md` |
| Test in BOS-AI dev repo | ⚠️ DON'T DO THIS | Would break dev environment |
| Multiple installations | Latest version wins | Re-verify after each |

## ✅ Sign-Off Checklist

Before marking deployment as verified:

- [ ] Tested in fresh business project (not BOS-AI repo)
- [ ] CLAUDE.md shows "BOS-AI Business Operating System"
- [ ] Only business agents present (chassis-intelligence, etc.)
- [ ] No development agents (developer, tester, etc.)
- [ ] Business commands work (`/coord optimize`)
- [ ] Agents respond with business context
- [ ] Document library templates accessible
- [ ] Missions execute correctly
- [ ] No AGENT-11 references in user-facing docs

## 🔄 Post-Deployment Testing

After verification, test actual workflows:

1. **Business Optimization:**
   ```bash
   /coord optimize
   # Should analyze Business Chassis, not code
   ```

2. **Marketing Setup:**
   ```bash
   /coord marketing-system-setup
   # Should create marketing documents, not code
   ```

3. **Agent Consultation:**
   ```bash
   /meeting @revenue-optimization "pricing strategy"
   # Should discuss pricing, not implement features
   ```

4. **PRD Creation:**
   ```bash
   /meeting @solution-design "create PRD for..."
   # Should create business requirements, not code
   ```

## 📝 Reporting Results

When reporting test results, include:

1. **Environment:**
   - Project type (test/real business)
   - Installation method used
   - Tier installed (starter/business/full)

2. **Verification Results:**
   - All checklist items (✅/❌)
   - Screenshot of CLAUDE.md header
   - List of deployed agents

3. **Functional Testing:**
   - Commands tried
   - Agent responses received
   - Any unexpected behavior

4. **Issues Found:**
   - Detailed description
   - Steps to reproduce
   - Actual vs expected behavior

---

**Remember: Always test in business projects, NEVER in the BOS-AI development repository!**
