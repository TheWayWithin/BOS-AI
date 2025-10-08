# 🔧 BOS-AI Development Environment (AGENT-11)

**⚠️ CRITICAL: This is the BOS-AI DEVELOPMENT repository**

You are currently working in the **BOS-AI development repository** using **AGENT-11** agents to BUILD and MAINTAIN the BOS-AI system itself.

## 🚨 CRITICAL GUARDRAILS

### ❌ DO NOT:
1. **NEVER run BOS-AI deployment scripts in this repository**
   - Running `deploy-bos-ai.sh` here would overwrite AGENT-11 agents with BOS-AI agents
   - This would break your development environment
   - Test deployments ONLY in separate business projects

2. **NEVER edit `.claude/agents/` directly**
   - These are AGENT-11 development agents (@developer, @tester, @architect)
   - They are READ-ONLY runtime files
   - Edit source agents in `/agents/` directory instead

3. **NEVER confuse BOS-AI agents with AGENT-11 agents**
   - `.claude/agents/` = AGENT-11 development agents (for building BOS-AI)
   - `/agents/` = BOS-AI business agents (what we're building for users)

### ✅ DO:
1. **Use AGENT-11 agents for development:**
   - @developer, @tester, @architect, @designer, @operator
   - @strategist, @documenter, @analyst, @marketer, @support, @coordinator

2. **Edit BOS-AI agents in `/agents/` directory:**
   - Source files for BOS-AI business agents
   - These get DEPLOYED to user projects
   - `/agents/coordination/`, `/agents/creation/`, etc.

3. **Test deployments in separate projects:**
   - Create test business project elsewhere
   - Run deployment scripts there
   - See DEPLOYMENT-VERIFICATION.md for testing guide

## 📋 Project Overview

**What This Project Is:**
- BOS-AI development repository
- Uses AGENT-11 to build BOS-AI
- Contains source for 29 BOS-AI business agents
- Contains deployment scripts for users

**What This Project Is NOT:**
- NOT a business project using BOS-AI
- NOT a place to test BOS-AI deployments
- NOT using BOS-AI agents for development

## 🎯 Development Workflow

### Working on BOS-AI Agents

1. **Edit source agents:**
   ```bash
   # Edit BOS-AI agents in source directory
   /agents/coordination/chassis-intelligence.md
   /agents/discovery/market-intelligence.md
   /agents/marketing/brand-strategy.md
   # etc.
   ```

2. **Test locally if needed:**
   ```bash
   # Deploy to test business project
   cd ~/test-business
   /path/to/BOS-AI/deployment/scripts/deploy-bos-ai.sh
   ```

3. **Commit changes:**
   ```bash
   git add agents/
   git commit -m "Update BOS-AI agents"
   git push
   ```

### Working on Deployment Scripts

1. **Edit deployment scripts:**
   ```bash
   deployment/scripts/deploy-bos-ai.sh
   deployment/scripts/install.sh
   # etc.
   ```

2. **Test in separate business project:**
   ```bash
   # NEVER test here! Go to separate project:
   cd ~/test-business
   curl -fsSL https://raw.githubusercontent.com/USERNAME/BOS-AI/BRANCH/deployment/scripts/install.sh | bash -s full
   ```

3. **Verify using DEPLOYMENT-VERIFICATION.md**

### Working on Documentation

1. **Root CLAUDE.md** = BOS-AI business version (gets deployed to users)
2. **CLAUDE-DEVELOPMENT.md** = AGENT-11 dev reference (this document's source)
3. **.claude/CLAUDE.md** = This file (AGENT-11 for BOS-AI development)

## 🔴 Agent Directory Structure

### This Repository Has TWO Agent Systems:

```
BOS-AI Development Repository
├── .claude/agents/          ← AGENT-11 (development agents)
│   ├── developer.md         ← Use these for building BOS-AI
│   ├── tester.md
│   ├── architect.md
│   └── ... (11 AGENT-11 agents)
│
├── /agents/                 ← BOS-AI (business agents we're building)
│   ├── coordination/
│   │   ├── chassis-intelligence.md   ← Edit these source files
│   │   └── multiplication-engine.md
│   ├── discovery/
│   ├── marketing/
│   └── ... (29 BOS-AI agents)
```

### Use the Right Agents:

| Task | Use These Agents | Example |
|------|------------------|---------|
| **Building BOS-AI** | AGENT-11 (@developer, @tester) | `@developer implement new feature` |
| **Testing deployments** | BOS-AI (in test projects only) | Test in `~/test-business` |
| **Editing BOS-AI agents** | Edit files in `/agents/` | Edit source, don't run agents |

## 🎯 Available Commands (AGENT-11)

### Development Commands
```bash
/coord build requirements.md    # Build new features for BOS-AI
/coord fix bug-report.md       # Fix bugs in BOS-AI code
/coord refactor                # Refactor BOS-AI codebase
/coord document                # Document BOS-AI features
```

### Coordination
```bash
@coordinator    # Orchestrate complex development tasks
@strategist     # Plan BOS-AI features and requirements
@architect      # Design BOS-AI architecture
@developer      # Implement BOS-AI features
@tester         # Test BOS-AI functionality
@designer       # Design BOS-AI UX/documentation
@documenter     # Write BOS-AI documentation
@operator       # Deployment and CI/CD
```

## 📚 Key Files Reference

| File | Purpose | Edit? |
|------|---------|-------|
| `.claude/CLAUDE.md` | **THIS FILE** - AGENT-11 dev instructions | ❌ No (generated) |
| `.claude/agents/` | AGENT-11 development agents | ❌ No (runtime only) |
| `/agents/` | BOS-AI business agents (source) | ✅ YES (edit these) |
| `/CLAUDE.md` | BOS-AI business version (deployed to users) | ✅ YES (if needed) |
| `/CLAUDE-DEVELOPMENT.md` | AGENT-11 reference doc | ✅ YES (if needed) |
| `deployment/scripts/` | Deployment scripts for users | ✅ YES (edit these) |
| `BOUNDARIES.md` | BOS-AI vs AGENT-11 separation | 📚 Reference |

## ⚠️ Common Mistakes to Avoid

### ❌ MISTAKE 1: Testing Deployment Locally
```bash
# ❌ WRONG - DO NOT DO THIS:
cd /Users/you/DevProjects/BOS-AI
./deployment/scripts/deploy-bos-ai.sh
# This will overwrite AGENT-11 agents with BOS-AI agents!
```

```bash
# ✅ CORRECT:
cd ~/separate-business-project
curl -fsSL https://raw.githubusercontent.com/USERNAME/BOS-AI/main/deployment/scripts/install.sh | bash -s full
```

### ❌ MISTAKE 2: Editing Runtime Agents
```bash
# ❌ WRONG:
# Editing .claude/agents/chassis-intelligence.md
# This is a runtime file and will be overwritten
```

```bash
# ✅ CORRECT:
# Edit /agents/coordination/chassis-intelligence.md
# This is the source file
```

### ❌ MISTAKE 3: Using BOS-AI Commands
```bash
# ❌ WRONG - These are for users of BOS-AI:
/coord optimize
/coord marketing-system-setup
/meeting @chassis-intelligence
```

```bash
# ✅ CORRECT - Use AGENT-11 commands:
/coord build requirements.md
/coord fix bug-report.md
@developer implement feature
```

### ❌ MISTAKE 4: Confusing the Two Systems
```bash
# ❌ WRONG thinking:
"I'll use @chassis-intelligence to coordinate development"
# chassis-intelligence is a BOS-AI business agent, not available here
```

```bash
# ✅ CORRECT:
"I'll use @coordinator to orchestrate development tasks"
# @coordinator is the AGENT-11 coordination agent
```

## 🔍 How to Tell Which System You're In

### You're in BOS-AI Development (this repo) if:
- ✅ Working on BOS-AI codebase
- ✅ `.claude/agents/` contains developer.md, tester.md, architect.md
- ✅ `/agents/` contains business agents as source files
- ✅ You're using @developer, @tester, @coordinator
- ✅ Building features FOR BOS-AI users

### You're in a BOS-AI User Project if:
- ✅ Using BOS-AI for your business
- ✅ `.claude/agents/` contains chassis-intelligence.md, market-intelligence.md
- ✅ No `/agents/` source directory
- ✅ You're using @chassis-intelligence, @market-intelligence
- ✅ Running your BUSINESS operations

## 🎯 Development Best Practices

### 1. Context Preservation
- Always read agent-context.md and handoff-notes.md
- Update handoff notes after completing tasks
- Use TodoWrite for task tracking

### 2. Security-First Development
- Never compromise security for convenience
- Perform root cause analysis before fixes
- Follow Critical Software Development Principles (see CLAUDE-DEVELOPMENT.md)

### 3. Testing Protocol
- Test BOS-AI deployments in separate projects only
- Use DEPLOYMENT-VERIFICATION.md checklist
- Never run deployment scripts in this repo

### 4. Agent Development
- Edit BOS-AI agents in `/agents/` source directory
- Follow agent template structure
- Test agent behavior in deployed projects
- Document agent capabilities thoroughly

## 📖 Additional Resources

- **CLAUDE-DEVELOPMENT.md** - Comprehensive AGENT-11 development guide
- **BOUNDARIES.md** - Detailed BOS-AI vs AGENT-11 separation
- **DEPLOYMENT-VERIFICATION.md** - Testing guide for deployments
- **DEPLOYMENT-FIX-SUMMARY.md** - Recent deployment fixes
- **/agents/README.md** - BOS-AI agents overview

## 🚀 Quick Reference

### I want to... Then do this...
| Task | Action |
|------|--------|
| Build new BOS-AI feature | Use @developer, edit code/agents |
| Fix BOS-AI bug | Use @tester to verify, @developer to fix |
| Update BOS-AI agent | Edit `/agents/[category]/[agent].md` |
| Test deployment | Create separate test project, deploy there |
| Update documentation | Edit `/CLAUDE.md` (user version) or this file |
| Add new BOS-AI agent | Create in `/agents/`, add to deploy scripts |
| Review code changes | Use @tester, @architect for review |
| Plan new feature | Use @strategist for requirements |

---

## 🎖️ Remember

**You are using AGENT-11 to BUILD BOS-AI.**
- Your agents: @developer, @tester, @architect (AGENT-11)
- You're building: BOS-AI business agents (in `/agents/`)
- Never test: BOS-AI deployments in this repo
- Always edit: Source files in `/agents/`, not `.claude/agents/`

**This separation keeps the development environment stable and prevents accidents!**
