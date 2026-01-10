# BOS-AI Directory Structure

Complete reference for BOS-AI's file organization and what each directory contains.

---

## Top-Level Overview

```
BOS-AI/
├── .claude/                  # Runtime configuration (deployed to your project)
│   ├── agents/               # 30 business intelligence agents
│   ├── commands/             # Slash commands (/coord, /meeting, etc.)
│   └── CLAUDE.md             # Development configuration
│
├── agents/                   # Agent source files (library)
│   ├── coordination/         # Central orchestration agents
│   ├── discovery/            # Market intelligence agents
│   ├── creation/             # Solution design agents
│   ├── delivery/             # Customer success agents
│   ├── growth/               # Scaling strategy agents
│   ├── marketing/            # Marketing function agents
│   ├── sales/                # Sales function agents
│   ├── customer-service/     # Support function agents
│   ├── finance/              # Financial management agents
│   └── legal/                # Compliance and risk agents
│
├── commands/                 # Command source files (library)
│   ├── coord.md              # Mission orchestration command
│   ├── meeting.md            # Agent consultation command
│   ├── report.md             # Progress reporting command
│   └── ...                   # Additional commands
│
├── missions/                 # Mission definitions
│   ├── foundation/           # Core business setup missions
│   ├── marketing/            # Marketing operations missions
│   ├── sales/                # Sales operations missions
│   ├── customer-service/     # Service operations missions
│   ├── finance/              # Financial operations missions
│   └── strategic/            # Strategic initiative missions
│
├── memories/                 # Institutional memory system
│   ├── business/             # Business intelligence
│   ├── strategies/           # Strategic approaches
│   └── lessons/              # Learnings and patterns
│
├── docs/                     # Documentation
│   ├── getting-started/      # Onboarding guides
│   ├── concepts/             # Core concept explanations
│   ├── reference/            # Quick reference materials
│   ├── troubleshooting/      # Problem resolution guides
│   └── Document Library/     # Operational templates
│
├── templates/                # Reusable templates
├── deployment/               # Installation and deployment scripts
├── CLAUDE.md                 # Main system instructions
└── README.md                 # Project overview
```

---

## Agents Directory (`/agents/`)

Source files for the 30 BOS-AI business agents, organized by function.

### Coordination Agents

| Agent | File | Purpose |
|-------|------|---------|
| Chassis Intelligence | `coordination/chassis-intelligence.md` | Central business orchestration |
| Client Success Intelligence | `coordination/client-success-intelligence.md` | Customer-centric operations |
| Multiplication Engine | `coordination/multiplication-engine.md` | Business Chassis optimization |

### Discovery Agents

| Agent | File | Purpose |
|-------|------|---------|
| Market Intelligence | `discovery/market-intelligence.md` | Market research and analysis |
| Opportunity Validation | `discovery/opportunity-validation.md` | Opportunity assessment |
| Strategic Opportunity | `discovery/strategic-opportunity.md` | Strategic positioning |

### Creation Agents

| Agent | File | Purpose |
|-------|------|---------|
| Solution Design | `creation/solution-design.md` | 10x value solution architecture |
| Rapid Development | `creation/rapid-development.md` | Fast implementation strategy |
| Value Optimization | `creation/value-optimization.md` | Value maximization |

### Delivery Agents

| Agent | File | Purpose |
|-------|------|---------|
| Customer Success | `delivery/customer-success.md` | Customer satisfaction |
| Quality Assurance | `delivery/quality-assurance.md` | Quality standards |
| Delivery Optimization | `delivery/delivery-optimization.md` | Efficient processes |

### Growth Agents

| Agent | File | Purpose |
|-------|------|---------|
| Scaling Strategy | `growth/scaling-strategy.md` | Business scaling |
| Market Expansion | `growth/market-expansion.md` | New market entry |
| Revenue Optimization | `growth/revenue-optimization.md` | Revenue maximization |

### Function Agents

**Marketing** (`marketing/`):
- Brand Strategy, Campaign Execution, Content Creation

**Sales** (`sales/`):
- Pipeline Management, Conversion Optimization, Revenue Operations

**Customer Service** (`customer-service/`):
- Support Management, Satisfaction Optimization, Retention Strategy

**Finance** (`finance/`):
- Budget Planning, Performance Analysis, Investment Strategy

**Legal** (`legal/`):
- Compliance Management, Risk Assessment, Contract Management

---

## Missions Directory (`/missions/`)

Structured workflows for common business operations.

### Foundation Missions (`/missions/foundation/`)

Core setup missions for establishing business foundations:
- Vision and mission creation
- Market research
- Client blueprint development
- Positioning statement
- Strategic roadmap
- Brand guide creation
- Pricing strategy
- PRD development

### Operations Missions

| Directory | Focus | Example Missions |
|-----------|-------|------------------|
| `/missions/marketing/` | Customer acquisition | System setup, Bible creation, Content calendar |
| `/missions/sales/` | Revenue generation | System setup, Pipeline optimization, Conversion |
| `/missions/customer-service/` | Customer retention | System setup, Retention optimization |
| `/missions/finance/` | Profit optimization | System setup, Cash flow, Investment strategy |

### Strategic Missions (`/missions/strategic/`)

Major business initiatives:
- Product launches
- Market entry
- Acquisition campaigns
- Business pivots

---

## Memory System (`/memories/`)

Persistent business intelligence across sessions.

### Business Memory (`/memories/business/`)

| File | Contains |
|------|----------|
| `vision.xml` | Strategic objectives, business model |
| `markets.xml` | Market intelligence, competitive insights |
| `customers.xml` | Customer personas, behavior patterns |
| `operations.xml` | Operational performance, process data |

### Strategies Memory (`/memories/strategies/`)

| File | Contains |
|------|----------|
| `marketing.xml` | Campaign performance, channel data |
| `sales.xml` | Sales strategies, conversion insights |
| `growth.xml` | Scaling approaches, expansion learnings |

### Lessons Memory (`/memories/lessons/`)

| File | Contains |
|------|----------|
| `failures.xml` | What didn't work and why |
| `insights.xml` | Key business discoveries |
| `decisions.xml` | Decision history and outcomes |
| `patterns.xml` | Successful operation patterns |

---

## Documentation (`/docs/`)

### Getting Started (`/docs/getting-started/`)

| File | Audience | Content |
|------|----------|---------|
| `business-guide.md` | Business operators | Complete business operations guide |
| `developer-guide.md` | Product developers | Technical workflow with AGENT-11 |
| `first-mission.md` | New users | Guided first experience |

### Concepts (`/docs/concepts/`)

| File | Explains |
|------|----------|
| `lifecycle.md` | The 4-stage BOS-AI lifecycle |
| `business-chassis.md` | The multiplication framework |
| `philosophy.md` | Design principles and approach |

### Reference (`/docs/reference/`)

| File | Contains |
|------|----------|
| `quick-reference.md` | Command cheat sheet |
| `directory-structure.md` | This file |

### Troubleshooting (`/docs/troubleshooting/`)

| File | Covers |
|------|--------|
| `installation.md` | Setup issues and solutions |
| `faq.md` | Common questions answered |

### Document Library (`/docs/Document Library/`)

Operational templates organized by function:
- Foundation templates
- Marketing operations templates
- Sales operations templates
- Customer service templates
- Finance templates

---

## Runtime Directory (`.claude/`)

**What gets deployed to your business project.**

```
.claude/
├── agents/           # 30 business agents (runtime copies)
├── commands/         # Slash commands (runtime copies)
├── CLAUDE.md         # Development configuration
└── BOUNDARIES.md     # System boundary definitions
```

**Important**: These are runtime files. Edit source files in `/agents/` and `/commands/` directories.

---

## Configuration Files

| File | Purpose | Location |
|------|---------|----------|
| `CLAUDE.md` | Main system instructions | Root |
| `.claude/CLAUDE.md` | Development configuration | .claude/ |
| `.claude/BOUNDARIES.md` | BOS-AI vs AGENT-11 boundaries | .claude/ |

---

## Deployment (`/deployment/`)

Installation and deployment scripts:

```
deployment/
├── scripts/
│   ├── install.sh        # Main installation script
│   └── deploy-bos-ai.sh  # Deployment helper
└── ...
```

---

## Key Principles

### Source vs Runtime

- **Source files** (`/agents/`, `/commands/`): What you edit
- **Runtime files** (`.claude/`): What gets deployed

### Memory Persistence

- Memory files persist across sessions
- Agents read memories before execution
- Lessons accumulate over time

### Mission State

- Active missions stored in `/workspace/missions/active/`
- Progress tracked for pause/resume
- Completed missions archived

---

## Related Documentation

- [Business Operations Guide](../getting-started/business-guide.md)
- [BOS-AI Lifecycle](../concepts/lifecycle.md)
- [Installation Troubleshooting](../troubleshooting/installation.md)

---

[Back to README](../../README.md) | [Quick Reference](quick-reference.md)
