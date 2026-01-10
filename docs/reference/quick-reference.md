# BOS-AI Quick Reference Card

> Print this page or keep it handy for daily BOS-AI operations.

---

## Essential Commands

| Command | Purpose | Time |
|---------|---------|------|
| `/coord` | Interactive mission menu | - |
| `/coord optimize` | Business Chassis analysis | 15-30m |
| `/coord [mission-name]` | Execute specific mission | varies |
| `/meeting @agent "topic"` | Direct agent consultation | 10-30m |
| `/report` | Progress tracking report | 5-10m |
| `/dailyreport` | Daily summary + social posts | 5-10m |
| `/pmd "issue"` | Root cause analysis | 15-30m |
| `/recon` | UI/UX reconnaissance | 20-30m |
| `/design-review` | Design review of branch | 30-60m |

---

## Quick-Start Missions

### Foundation Documents (Build Once)

| Mission | Time | What You Get |
|---------|------|--------------|
| `vision-mission-creation` | 30-60m | Vision & Mission statement |
| `market-research` | 60-90m | Market & competitive analysis |
| `client-blueprint-creation` | 60-90m | Ideal customer profiles |
| `positioning-statement` | 60m | Unique positioning statement |
| `brand-guide-creation` | 90m | Brand style guide |
| `pricing-strategy` | 60-90m | Pricing strategy document |
| `prd-creation` | 30-60m | Product requirements doc |

### Operations Systems (Ongoing)

| Mission | Time | What You Get |
|---------|------|--------------|
| `marketing-system-setup` | 4-5h | Bible + Plan + Calendar |
| `sales-system-setup` | 3-4h | Bible + Plan |
| `customer-service-system-setup` | 3-4h | Bible + Plan |
| `finance-system-setup` | 3-4h | Bible + Plan |

### Quick Missions

| Mission | Time | What You Get |
|---------|------|--------------|
| `marketing-bible-creation` | 90m | Marketing foundation |
| `sales-bible-creation` | 2h | Sales foundation |
| `content-calendar-implementation` | 60m | 30-day content plan |

---

## Business Chassis Formula

```
Profit = Prospects x Lead% x Client% x Spend x Frequency x Margin
```

**Key Insight**: 10% improvement in each = **77% profit increase**

| Factor | What It Measures | Agents |
|--------|------------------|--------|
| Prospects | Total reach | @market-intelligence, @campaign-execution |
| Lead Conversion | Visitors to leads | @conversion-optimization, @content-creation |
| Client Conversion | Leads to customers | @pipeline-management, @sales-bible |
| Average Spend | Revenue per sale | @pricing-strategy, @revenue-optimization |
| Transaction Frequency | Repeat purchases | @customer-success, @retention-strategy |
| Margin | Profit per sale | @budget-planning, @performance-analysis |

---

## Key Agents by Function

### Strategy & Coordination
| Need | Agent |
|------|-------|
| Central orchestration | @chassis-intelligence |
| Business optimization | @multiplication-engine |
| Customer-centric ops | @client-success-intelligence |

### Marketing
| Need | Agent |
|------|-------|
| Brand positioning | @brand-strategy |
| Campaign planning | @campaign-execution |
| Content strategy | @content-creation |

### Sales
| Need | Agent |
|------|-------|
| Pipeline management | @pipeline-management |
| Conversion improvement | @conversion-optimization |
| Revenue operations | @revenue-operations |

### Customer Service
| Need | Agent |
|------|-------|
| Support operations | @support-management |
| Customer satisfaction | @satisfaction-optimization |
| Retention programs | @retention-strategy |

### Finance
| Need | Agent |
|------|-------|
| Budget planning | @budget-planning |
| Performance analysis | @performance-analysis |
| Investment strategy | @investment-strategy |

### Discovery & Growth
| Need | Agent |
|------|-------|
| Market research | @market-intelligence |
| Opportunity assessment | @opportunity-validation |
| Scaling strategy | @scaling-strategy |

---

## File Locations

| Content | Location |
|---------|----------|
| Mission definitions | `/missions/` |
| Document templates | `/docs/Document Library/` |
| Business memory | `/memories/` |
| Progress tracking | `progress.md` |
| Agent profiles | `.claude/agents/` |
| System config | `CLAUDE.md` |

---

## Common Patterns

### Daily Operations
```
/coord optimize           # Morning: Identify today's priority
/meeting @agent "topic"   # Execute: Work on priority
/dailyreport              # Evening: Document progress
```

### Weekly Review
```
/report weekly            # Review week's progress
/coord optimize           # Identify next week's focus
```

### Starting New Project
```
/coord project-setup      # Create foundation structure
/coord vision-mission-creation  # Define vision
/coord market-research    # Research market
```

### Building Product
```
/coord prd-creation       # Create requirements doc
# Hand off PRD to AGENT-11 project for development
```

---

## Quick Troubleshooting

| Issue | Solution |
|-------|----------|
| Commands not working | Ensure you're in Claude Code, not terminal |
| Agents not found | Check `ls .claude/agents/` |
| Mission fails to start | Check for active missions in `/missions/active/` |
| Need more agents | Upgrade: `bash install.sh full` |

---

## Links

- [Business Guide](../getting-started/business-guide.md) - Complete business operations
- [Developer Guide](../getting-started/developer-guide.md) - Product development workflow
- [First Mission](../getting-started/first-mission.md) - Guided walkthrough
- [FAQ](../troubleshooting/faq.md) - Common questions
- [Back to README](../../README.md)

---

*Last updated: 2026-01-10*
