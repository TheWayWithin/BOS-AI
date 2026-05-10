# BOS-AI - Your Business Operating System

**BOS-AI runs your BUSINESS. AGENT-11 builds your SOFTWARE.**

---

## Core Concept: The Business Chassis

Transform your business through the multiplication effect:

```
Profit = Prospects × Lead Conversion × Client Conversion × Average Spend × Transaction Frequency × Margin
```

**The Multiplication Effect:**
- 10% improvement in each = **77% profit increase**
- 20% improvement in each = **299% profit increase**

Small improvements across all multipliers create exponential results.

---

## Karpathy Business Constitution

Seven rules govern every BOS-AI specialist, every mission, every time.

1. **Read the foundation first.** Before any strategic recommendation, read the relevant documents in `/documents/foundation/` (vision-mission, market-research, client-blueprint, strategic-roadmap, brand-guide, positioning, pricing, prd). Foundation docs are the source of truth — not memory files, not your prior assumptions.

2. **Prioritise the chassis.** When optimising, focus on the **weakest** multiplier in the Business Chassis formula. Compounding a 10% gain on the weakest multiplier beats a 30% gain on the strongest.

3. **Solopreneur voice.** Write in the first person ("I", "my"). Never use corporate-speak: `we`, `our team`, `the team`, `leverage`, `unlock`, `empower`, `ecosystem`, `seamless`, `robust`. No em-dashes in publishable content. Enforced deterministically by `library/hooks/check-voice.sh` on files in `blog/`, `progress/`, `documents/business-assets/`, `documents/foundation/` — see `library/hooks/README.md` to install.

4. **Smart brevity.** Keep generated documents concise and actionable. Lead with the answer. Cut filler. If a sentence isn't earning its place, delete it.

5. **No code.** Never write code or technical architecture. That is AGENT-11's job. Missions that produce a PRD hand off cleanly — see the PRD Handoff section below.

6. **Phase Handoffs use the 5-field schema.** Findings / Decisions / Warnings / Open / Evidence. No free-form prose handoffs. Append to `/workspace/agent-context.md`.

7. **Coordinator runs top-level only.** `/coord` runs at the top level. Never spawn `/coord` from inside a subagent. Specialists do not spawn other specialists.

---

## Essential Commands

| Command | Purpose |
|---------|---------|
| `/coord` | Business orchestration — Universal Router dispatches by mission name |
| `/coord chassis-optimization` | Multi-step sequence: find weakest multiplier, fix it |
| `/meeting @agent "topic"` | Direct consultation with specialist agent |
| `/report` | Generate progress report |
| `/dailyreport` | Daily progress + blog/social media posts |
| `/pmd "issue"` | Root cause analysis and diagnostics |

**Quick examples:**
```bash
/coord chassis-optimization                    # Find biggest opportunity
/coord marketing-system-setup      # Full marketing framework (4-5 hours)
/meeting @brand-strategy "pricing" # Consult specialist
```

---

## Available Agents (30)

### Core Functions
| Category | Agents |
|----------|--------|
| **Coordination** | `@chassis-intelligence`, `@client-success-intelligence`, `@multiplication-engine` |
| **Discovery** | `@market-intelligence`, `@opportunity-validation`, `@strategic-opportunity` |
| **Creation** | `@solution-design`, `@rapid-development`, `@value-optimization` |
| **Delivery** | `@customer-success`, `@quality-assurance`, `@delivery-optimization` |
| **Growth** | `@scaling-strategy`, `@market-expansion`, `@revenue-optimization` |

### Operations Functions
| Category | Agents |
|----------|--------|
| **Marketing** | `@brand-strategy`, `@campaign-execution`, `@content-creation` |
| **Sales** | `@pipeline-management`, `@conversion-optimization`, `@revenue-operations` |
| **Customer Service** | `@support-management`, `@satisfaction-optimization`, `@retention-strategy` |
| **Finance** | `@budget-planning`, `@performance-analysis`, `@investment-strategy` |
| **Legal** | `@compliance-management`, `@risk-assessment`, `@contract-management` |

---

## Missions Overview

Missions are systematic workflows that coordinate multiple agents. Execute with `/coord [mission-name]`.

### Core System Setups (Recommended Starting Points)
| Mission | Time | Creates |
|---------|------|---------|
| `marketing-system-setup` | 4-5 hours | Marketing Bible, Plan, Content Calendar |
| `sales-system-setup` | 3-4 hours | Sales Bible, Sales Plan |
| `customer-service-system-setup` | 3-4 hours | Service Bible, Service Plan |
| `finance-system-setup` | 3-4 hours | Finance Bible, Finance Plan |

### Quick Wins (< 2 hours each)
- `marketing-bible-creation` - Strategic marketing foundation
- `sales-bible-creation` - Strategic sales foundation
- `vision-mission-creation` - Define purpose and direction
- `prd-creation` - Product Requirements Document

**View all missions:** `/missions/` directory or run `/coord` for interactive selection.

---

## Operations Library

Templates and SOPs for business operations are deployed to `.claude/document-library/`.

**Structure:**
```
.claude/document-library/
├── Foundation/           # Strategic templates (Vision, PRD, Positioning, etc.)
└── Operations/
    ├── Marketing/        # Marketing Bible, Plan, Calendar
    ├── Sales/            # Sales Bible, Plan
    ├── Customer Service/ # Service Bible, Plan
    └── Finance/          # Finance Bible, Plan
```

**Your documents go to:** `documents/foundation/` (not the template library)

---

## PRD System

BOS-AI includes an enhanced PRD system for machine-parsable, agent-ready technical handoffs.

### Current PRD Template (v3.1)

Includes **System Skeleton** sections for direct code generation:
- Data Model (entities, relationships)
- UI Sitemap (routes, access levels)
- Business Rules (validation, state machines)
- API Dependencies (external integrations)
- Privacy & Compliance (data classification)

### PRD Commands
```bash
/coord prd-creation              # Create new PRD (Auto or Engaged mode)
/coord prd-creation --add-feature  # Add single feature to existing PRD
```

### Design Playbook (Optional)
Captures technical preferences (HOW) without polluting the PRD (WHAT/WHY). Developers may override.

**Template location:** `.claude/document-library/Foundation/`

---

## Document Versioning Convention

**Rule: Never put version numbers in filenames.**

| DO | DON'T |
|----|-------|
| `PRD Creation SOP.md` | `PRD Creation SOP v2.1.md` |

**Correct approach:**
1. Simple filename (no version)
2. Version metadata inside document header
3. Archive old versions to `archive/` folder with date stamps

---

## BOS-AI vs AGENT-11 Boundaries

**BOS-AI creates:**
- Business strategy and requirements
- Product Requirements Documents (PRDs)
- Operational frameworks (Bibles, Plans, Calendars)
- Market intelligence and customer insights

**BOS-AI does NOT create:**
- Code or software implementations
- Technical architecture or database schemas
- API designs or integrations
- DevOps or deployment infrastructure

**For technical implementation:** Create PRD in BOS-AI → Hand off to AGENT-11 project.

See `.claude/BOUNDARIES.md` for complete details.

---

## PRD Handoff Workflow

When you need software built:

1. **BOS-AI**: Create PRD with `/coord prd-creation` or `/coord solution-design`
2. **Create AGENT-11 project**: Separate directory for technical work
3. **Copy PRD** to AGENT-11 project
4. **AGENT-11**: Build software from PRD
5. **Return to BOS-AI**: Launch and operate the product

---

## Progress Tracking

- **business-plan.md** - Forward-looking: goals, strategies, planned approaches
- **progress.md** - Backward-looking: what happened, lessons learned
- **Foundation documents** in `/documents/foundation/` are the source of truth for business context (vision, markets, customers). Read these before making strategic recommendations.

---

## Quick Reference

### Business Chassis Formula
```
Profit = Prospects × Lead Conversion × Client Conversion × Average Spend × Transaction Frequency × Margin
```
10% improvement in each = **77% profit increase**

### Getting Started Flow
1. `/coord chassis-optimization` — Find biggest opportunity
2. Pick recommended system setup mission
3. Complete 1 system (3-5 hours)
4. Add remaining systems over time

### Most Used Commands
```bash
/coord chassis-optimization      # Find opportunity (weakest multiplier)
/coord [mission-name]            # Run mission (see Universal Router in commands/coord.md)
/meeting @agent "topic"          # Consult specialist
/report                          # Progress report
/dailyreport                     # Daily progress + blog/social
/pmd "issue"                     # Diagnose problem
```

The full mission list lives in `commands/coord.md` (the Universal Router) and `missions/` (the mission files themselves). Mission names are matched literally — no fuzzy / NLP intent matching.

### Key Locations
| Location | Purpose |
|----------|---------|
| `.claude/document-library/` | Templates and SOPs (read-only) |
| `documents/foundation/` | Your business documents |
| `/missions/` | Available missions |
| `/routines/` | Scheduled routine templates (set up at claude.ai/code/routines) |
| `library/voice/` | Default voice guide (copy to `voice-guide.md` to customise) |
| `library/hooks/` | Optional voice-enforcement hook (`check-voice.sh`) |

---

## Documentation & Help

| Resource | Location |
|----------|----------|
| Business Guide | `docs/getting-started/business-guide.md` |
| Developer Guide | `docs/getting-started/developer-guide.md` |
| FAQ | `docs/troubleshooting/faq.md` |
| Troubleshooting | `docs/troubleshooting/guide.md` |
| Boundaries | `.claude/BOUNDARIES.md` |
| Quick Reference | `docs/reference/quick-reference.md` |
| Phase Handoff schema | `templates/phase-handoff-template.md` |
| Universal Router | `commands/coord.md` |
| Migration from v1.x | `library/migrate-from-v1.md` |

**Quick diagnostic:** `/pmd "describe your issue"`

---

**Ready?** Type `/coord` to begin.
