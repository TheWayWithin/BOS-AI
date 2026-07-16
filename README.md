# BOS-AI: Your AI-Powered Business Operating System

![BOS-AI Banner](https://img.shields.io/badge/BOS--AI-v2.0-blue?style=for-the-badge)
![Agents](https://img.shields.io/badge/Agents-30-orange?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Production-success?style=for-the-badge)

**BOS-AI runs your business. You focus on vision.**

Transform your business through the Business Chassis multiplication effect. 30 specialized AI agents handle strategy, marketing, sales, customer service, and finance—so you can focus on what matters.

---

## Quick Start

```bash
mkdir ~/my-business && cd ~/my-business && git init
curl -fsSL https://raw.githubusercontent.com/TheWayWithin/BOS-AI/main/deployment/scripts/install.sh | bash -s full
claude code .
/coord optimize
```

That's it. BOS-AI analyzes your business and identifies your biggest opportunity.

---

## Choose Your Path

### Running a Business?

You don't need technical skills. BOS-AI helps you with strategy, marketing, sales, and operations.

**Start here:** [Business Operations Guide](docs/getting-started/business-guide.md)

### Building a Product?

Create your requirements in BOS-AI, then build with AGENT-11.

**Start here:** [Product Developer Guide](docs/getting-started/developer-guide.md)

**NEW: Enhanced PRD Template** - Machine-parsable PRDs with System Skeleton (data model, UI sitemap, business rules) for seamless AGENT-11 handoff. See [PRD Template](docs/Document%20Library/Foundation/Product%20Requirements%20Document%20(PRD).md).

---

## The Business Chassis

Every business runs on six multipliers:

```
Profit = Prospects × Lead Conversion × Client Conversion × Average Spend × Transaction Frequency × Margin
```

**The Multiplication Effect:**
- 10% improvement in each = **77% more profit**
- 20% improvement in each = **299% more profit**

BOS-AI optimizes all six multipliers systematically.

**Learn more:** [Business Chassis Explained](docs/concepts/business-chassis.md)

---

## Essential Commands

| Command | What It Does |
|---------|--------------|
| `/coord optimize` | Find your biggest business opportunity |
| `/coord foundation-quick-start` | Build strategic foundation (3-4 hours) |
| `/coord marketing-system-setup` | Create complete marketing framework |
| `/coord sales-system-setup` | Create complete sales framework |
| `/meeting @agent "topic"` | Consult with specific specialist |
| `/report` | Generate progress report |
| `/dailyreport` | Turn `progress.md` into a daily report plus voice-aligned blog and social posts |
| `/blog <topic>` | Draft a voice-aligned blog post plus Twitter/X and LinkedIn versions on any topic |

`/dailyreport` and `/blog` are Claude-native — no API keys, no per-report cost. Both
commands share a single voice guide at `.claude/data/voice-guide-default.md`. Drop a
`voice-guide.md` in your project root to override with your own voice, or set
`DAILYREPORT_VOICE_GUIDE` to point anywhere.

---

## The Four Operations Systems

Build a complete business operating system in 13-17 hours:

| System | Time | What You Get | Command |
|--------|------|--------------|---------|
| **Marketing** | 4-5 hours | Bible, Plan, Calendar | `/coord marketing-system-setup` |
| **Sales** | 3-4 hours | Bible, Plan | `/coord sales-system-setup` |
| **Customer Service** | 3-4 hours | Bible, Plan | `/coord customer-service-system-setup` |
| **Finance** | 3-4 hours | Bible, Plan | `/coord finance-system-setup` |

Each system multiplies specific Business Chassis components for exponential growth.

---

## 30 Specialized Agents

BOS-AI includes 30 business intelligence agents organized by function:

| Category | Agents | Focus |
|----------|--------|-------|
| **Coordination** | 3 | Business orchestration, optimization |
| **Discovery** | 3 | Market research, opportunity validation |
| **Creation** | 3 | Solution design, value optimization |
| **Delivery** | 3 | Customer success, quality assurance |
| **Growth** | 3 | Scaling, market expansion, revenue |
| **Marketing** | 3 | Brand, campaigns, content |
| **Sales** | 3 | Pipeline, conversion, revenue ops |
| **Customer Service** | 3 | Support, satisfaction, retention |
| **Finance** | 3 | Budget, performance, investment |
| **Legal** | 3 | Compliance, risk, contracts |

**Full catalog:** [Agent Directory](docs/agents/README.md)

---

## The BOS-AI Lifecycle

```
┌──────────────┐    ┌──────────────┐    ┌──────────────┐    ┌──────────────┐
│   STAGE 1    │    │   STAGE 2    │    │   STAGE 3    │    │   STAGE 4    │
│  Foundation  │───▶│   Creation   │───▶│   Delivery   │───▶│    Growth    │
│              │    │              │    │              │    │              │
│ • Vision     │    │ • Solution   │    │ • Marketing  │    │ • Scale      │
│ • Research   │    │ • Design     │    │ • Sales      │    │ • Expand     │
│ • Strategy   │    │ • Build      │    │ • Service    │    │ • Optimize   │
└──────────────┘    └──────────────┘    └──────────────┘    └──────────────┘
        │                                                           │
        └────────────────── CONTINUOUS IMPROVEMENT ─────────────────┘
```

**Learn more:** [BOS-AI Lifecycle](docs/concepts/lifecycle.md)

---

## BOS-AI vs AGENT-11

| BOS-AI | AGENT-11 |
|--------|----------|
| Business operations | Software development |
| 30 business agents | 11 technical agents |
| Creates PRDs and strategy | Writes code and deploys |
| Defines WHAT to build | Implements HOW to build |

**They work together but are separate projects.**

When you need software built:
1. Create PRD in BOS-AI
2. Hand off to AGENT-11 project: copy the foundation documents into the dev project's `documents/foundations/` and run `/foundations init`
3. Return to BOS-AI for operations

**The handoff is a one-time release with ownership transfer.** Once foundation documents are handed to the dev project, the dev project owns the PRD and all product-shaped documents — post-handoff edits happen there, not in BOS-AI. Replace the copies in your BOS-AI workspace with a one-line pointer to the dev project. Do not maintain parallel copies or sync them back: the source of truth follows the build decisions. BOS-AI remains the home for business-side documents you continue to operate with (marketing, sales, finance). See AGENT-11's [BOS-AI Handoff Guide](https://github.com/TheWayWithin/agent-11/blob/main/project/field-manual/bos-ai-handoff.md) for the full workflow, including the lite tier for ad-hoc builds.

---

## Installation Options

### Standard Install

One command — downloads and runs the installer:

```bash
curl -fsSL https://raw.githubusercontent.com/TheWayWithin/BOS-AI/main/deployment/scripts/install.sh | bash -s full
```

You'll see progress output as it installs. When it finishes, all 30 agents are ready.

### Inspect Before Running (Optional, More Secure)

If you want to review the install script before executing it, do this in three steps:

```bash
# 1. Download the script (this command prints nothing — that's normal)
curl -fsSL https://raw.githubusercontent.com/TheWayWithin/BOS-AI/main/deployment/scripts/install.sh -o /tmp/bos-ai-install.sh

# 2. Review it (press q to exit the viewer)
less /tmp/bos-ai-install.sh

# 3. Run it
bash /tmp/bos-ai-install.sh full
```

### Pin to a Specific Version

Lock the install to a tagged release:

```bash
BOS_AI_VERSION=v1.0.0 curl -fsSL https://raw.githubusercontent.com/TheWayWithin/BOS-AI/main/deployment/scripts/install.sh | bash -s full
```

Set `BOS_AI_VERSION` to any git tag (e.g. `v1.0.0`) to install that exact release.

### MCP-Enhanced Install

```bash
curl -fsSL https://raw.githubusercontent.com/TheWayWithin/BOS-AI/main/deployment/scripts/install-with-mcp.sh | bash -s full
```

Adds direct API connections for 40-60% faster operations. Requires API key configuration.

**Troubleshooting:** [Installation Issues](docs/troubleshooting/installation.md)

---

## Security

Report vulnerabilities privately via [GitHub Security Advisories](https://github.com/TheWayWithin/BOS-AI/security/advisories/new).

- No API keys or secrets in the repo — all credentials load from `.env.mcp` (gitignored)
- Install scripts use `set -euo pipefail`, validate paths, and refuse system directories
- `.env.mcp` parsed as key=value pairs, never `source`d as shell code
- Pin installs to a tagged release with `BOS_AI_VERSION=v1.0.0`
- Recommended install pattern downloads the script for inspection before running

---

## Documentation

### Getting Started
- [Business Operations Guide](docs/getting-started/business-guide.md) - For business operators
- [Product Developer Guide](docs/getting-started/developer-guide.md) - For product builders
- [Your First Mission](docs/getting-started/first-mission.md) - Guided walkthrough

### Core Concepts
- [Business Chassis](docs/concepts/business-chassis.md) - The multiplication framework
- [BOS-AI Lifecycle](docs/concepts/lifecycle.md) - The four stages
- [Philosophy](docs/concepts/philosophy.md) - Design principles

### Reference
- [Quick Reference Card](docs/reference/quick-reference.md) - Command cheat sheet
- [Directory Structure](docs/reference/directory-structure.md) - Project organization
- [Agent Directory](docs/agents/README.md) - All 30 agents
- [Mission Catalog](docs/missions/README.md) - All available missions

### Operations
- [Operations Library](docs/OPERATIONS-LIBRARY.md) - Complete frameworks
- [Foundation Workflows](docs/workflows/foundation/) - Setup guides

### PRD System
- [PRD Template](docs/Document%20Library/Foundation/Product%20Requirements%20Document%20(PRD).md) - Enhanced machine-parsable template (v3.1)
- [PRD Creation SOP](docs/Document%20Library/Foundation/PRD%20Creation%20SOP.md) - Creation process with Auto/Engaged modes
- [Design Playbook Template](docs/Document%20Library/Foundation/Design%20Playbook%20Template.md) - Technical preferences
- [Migration Guide](docs/reference/prd/PRD%20v3.1%20Migration%20Guide.md) - Upgrade from legacy PRDs

### Troubleshooting
- [Installation Issues](docs/troubleshooting/installation.md) - Setup problems
- [FAQ](docs/troubleshooting/faq.md) - Common questions

---

## Quick Reference

### Most Common Workflows

**Starting a new business:**
```bash
/coord foundation-quick-start    # 3-4 hours
/coord marketing-system-setup    # 4-5 hours
/coord sales-system-setup        # 3-4 hours
```

**Optimizing existing business:**
```bash
/coord optimize                  # 15 minutes - find opportunity
/meeting @agent "specific topic" # Deep dive with specialist
```

**Building a product:**
```bash
/coord solution-design "idea"    # Create PRD
# Then hand off to AGENT-11 project for development
```

### The Formula

```
Profit = Prospects × Lead Conversion × Client Conversion × Average Spend × Transaction Frequency × Margin
```

10% improvement in each = **77% more profit**

### Quick Commands

| Command | Purpose |
|---------|---------|
| `/coord optimize` | Find biggest opportunity |
| `/coord daily` | Daily business review |
| `/coord weekly` | Weekly performance analysis |
| `/meeting @agent "topic"` | Specialist consultation |
| `/report` | Progress report |
| `/pmd "issue"` | Root cause analysis |

---

## Need Help?

- **Quick diagnostic:** `/pmd "describe your issue"`
- **Installation problems:** [Troubleshooting Guide](docs/troubleshooting/installation.md)
- **Common questions:** [FAQ](docs/troubleshooting/faq.md)
- **Full documentation:** [CLAUDE.md](CLAUDE.md)

---

## Success Path

| Milestone | Time | What You Achieve |
|-----------|------|------------------|
| First `/coord optimize` | 15 min | Identify biggest opportunity |
| Foundation documents | 3-4 hours | Strategic clarity |
| One operations system | 3-5 hours | Execution framework |
| All four systems | 13-17 hours | Complete business OS |
| **90 days** | Ongoing | **77%+ profit potential** |

---

**Ready to transform your business?**

```bash
/coord optimize
```

---

[Business Guide](docs/getting-started/business-guide.md) | [Developer Guide](docs/getting-started/developer-guide.md) | [Full Documentation](CLAUDE.md)
