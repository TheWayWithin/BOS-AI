# Getting Started with BOS-AI

Welcome to BOS-AI! This guide walks you through installation, first commands, and core concepts in under 10 minutes.

## Prerequisites

Before starting, ensure you have:
- **Claude Code** installed and running
- **Terminal access** (Mac Terminal, Linux Terminal, or Windows WSL)
- **5 minutes** for installation

## Installation (2 minutes)

### Quick Install - Starter Pack
```bash
# Navigate to your project
cd ~/my-business-project

# Install BOS-AI starter pack (5 essential agents)
curl -fsSL https://raw.githubusercontent.com/TheWayWithin/BOS-AI/main/deployment/scripts/install.sh | bash -s starter
```

The installer creates:
- `.claude/` - BOS-AI system files
- `documents/` - Business document structure
- `assets/` - Reports and generated content

## First Commands (3 minutes)

### 1. Test Your Installation
Open Claude Code in your project:
```bash
claude code .
```

Type your first command:
```
/coord optimize
```

This analyzes your business using the Business Chassis formula and identifies growth bottlenecks.

### 2. Consult an Agent
Ask specific agents for help:
```
/meeting @revenue-optimization "help me price my SaaS product"
```

### 3. Run a Mission
Execute pre-built workflows:
```
/coord project-setup
```

## Core Concepts (5 minutes)

### The Business Chassis Formula
Your profit multiplies six factors:
```
Profit = Prospects × Lead% × Client% × Spend × Frequency × Margin
```

**Key insight**: 10% improvement in each = 77% profit increase!

### Agent Types

**Starter Pack (5 agents)**:
- `@chassis-intelligence` - Central coordinator
- `@multiplication-engine` - Business optimization
- `@revenue-optimization` - Revenue growth
- `@pipeline-management` - Sales pipeline
- `@customer-success` - Customer satisfaction

### Command Types

**`/coord` - Orchestration Mode**
- Activates strategic coordinator
- Manages multi-agent workflows
- Runs business missions

**`/meeting` - Consultation Mode**
- Direct agent discussion
- Focused expertise
- Specific problem solving

## Your First Project

### Step 1: Analyze Your Business
```
/coord optimize
```
The system will:
1. Evaluate your Business Chassis
2. Identify weakest multiplier
3. Propose improvement strategy

### Step 2: Fix Biggest Issue
Based on analysis, consult the relevant agent:
```
/meeting @pipeline-management "improve lead conversion from 10% to 20%"
```

### Step 3: Implement Solution
Follow the agent's recommendations to:
- Create action plans
- Build necessary assets
- Track improvements

## Common Workflows

### Daily Business Review
```
/coord daily-review
```
Reviews metrics, identifies issues, plans day.

### Launch New Product
```
/coord product-launch "AI automation tool"
```
Coordinates market research, pricing, go-to-market.

### Improve Customer Retention
```
/meeting @customer-success "reduce churn rate"
```
Analyzes causes, creates retention strategy.

## Upgrading Your Installation

### Add More Agents
```bash
# Business tier (15 agents)
curl -fsSL https://raw.githubusercontent.com/TheWayWithin/BOS-AI/main/deployment/scripts/install.sh | bash -s business

# Full suite (30 agents)
curl -fsSL https://raw.githubusercontent.com/TheWayWithin/BOS-AI/main/deployment/scripts/install.sh | bash -s full
```

### Check Installed Agents
```bash
ls .claude/agents/
```

## Next Steps

1. **Read CLAUDE.md** - Complete command reference
2. **Explore Missions** - Check `.claude/missions/` for workflows
3. **Join Community** - Share experiences and get help
4. **Track Results** - Monitor Business Chassis improvements

## Quick Reference Card

| Command | Purpose | Example |
|---------|---------|---------|
| `/coord` | Run missions | `/coord optimize` |
| `/coord [mission]` | Specific mission | `/coord product-launch` |
| `/meeting @[agent]` | Consult agent | `/meeting @revenue-optimization "pricing"` |
| `@[agent]` | Reference in chat | "Ask @customer-success about retention" |

## Troubleshooting

**Agents not appearing?**
```bash
ls .claude/agents/  # Should show .md files
```

**Commands not working?**
- Ensure you're in Claude Code
- Check installation completed successfully
- Re-run installer if needed

## Getting Help

- **Documentation**: See [CLAUDE.md](../../CLAUDE.md)
- **Issues**: Report at [GitHub Issues](https://github.com/TheWayWithin/BOS-AI/issues)
- **Community**: Join discussions in [GitHub Discussions](https://github.com/TheWayWithin/BOS-AI/discussions)

---

*Ready to transform your business? You're all set! Start with `/coord optimize` and let BOS-AI guide your growth.*