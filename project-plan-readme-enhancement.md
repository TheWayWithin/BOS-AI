# Project Plan: BOS-AI README Enhancement

## Executive Summary

The current README.md is ~1,400 lines and tries to serve all users simultaneously, creating cognitive overload. This project restructures documentation using **progressive disclosure** - showing users what they need when they need it.

## Project Overview

**Objective**: Restructure BOS-AI documentation to improve accessibility for two distinct user personas while maintaining comprehensive coverage.

**Target Personas**:
1. **Business-Only Users** - Using BOS-AI to run a business (no development)
2. **Product Developers** - Building products with BOS-AI + AGENT-11 lifecycle

**Success Metrics**:
- README reduced from ~1,400 lines to ~300 lines
- Clear entry path for each persona
- All existing information preserved (moved to appropriate locations)
- Improved navigation and discoverability

---

## Problems Identified (Context for Execution)

### 1. Information Overload (Critical)
- README is 1,387 lines - too long for initial comprehension
- Users face decision fatigue before installing

### 2. Mixed Audiences (Critical)
- Technical AGENT-11 details interleaved with basic installation
- Business-only users confused by development workflow
- Product developers can't find complete Foundation → PRD → AGENT-11 path

### 3. Repeated Information (Moderate)
- Installation commands appear 4+ times
- Business Chassis formula appears 3 times
- Stage descriptions duplicated in multiple formats

### 4. Poor Progressive Disclosure (Moderate)
- MCP configuration, directory structures appear before users understand value
- Deep technical details too early in document

### 5. Missing Clear Entry Points (Moderate)
- No "start here" based on user type
- Both personas forced through same content

---

## Content Specifications

### Persona Callouts (Sprint 1)

**After Quick Start section, add:**

```markdown
> **📊 Running a Business?** You don't need to understand AGENT-11 or technical details.
> Jump to the [Business Operations Guide](docs/getting-started/business-guide.md) for a streamlined path.

> **💻 Building a Product?** You'll use BOS-AI for Foundation documents, then AGENT-11 for development.
> See the [Product Developer Guide](docs/getting-started/developer-guide.md) for the complete workflow.
```

### Documentation Map (Sprint 1)

**Add new section after installation:**

```markdown
## 📚 Documentation Map

### New to BOS-AI?
- [Quick Start](docs/getting-started/README.md) - Install and first commands
- [Your First Mission](docs/getting-started/first-mission.md) - Guided `/coord optimize`

### Choose Your Path
- [Business Operations Guide](docs/getting-started/business-guide.md) - Run your business with BOS-AI
- [Product Developer Guide](docs/getting-started/developer-guide.md) - Build products with BOS-AI + AGENT-11

### Reference
- [All 30 Agents](docs/agents/README.md) - Complete agent catalog
- [Mission Catalog](docs/missions/README.md) - All available missions
- [Command Reference](CLAUDE.md) - Full command documentation
- [Quick Reference Card](docs/reference/quick-reference.md) - One-page cheat sheet

### Deep Dives
- [Business Chassis Explained](docs/concepts/business-chassis.md)
- [Foundation Documents](docs/workflows/foundation/)
- [Operations Library](docs/OPERATIONS-LIBRARY.md)
- [MCP Integration Guide](docs/guides/MCP-GUIDE.md)

### Troubleshooting
- [Installation Issues](docs/troubleshooting/installation.md)
- [FAQ](docs/troubleshooting/faq.md)
```

### Developer Guide Structure (Sprint 2)

**File: `docs/getting-started/developer-guide.md`**

```markdown
# Building Products with BOS-AI + AGENT-11

## Overview
- BOS-AI creates business requirements (WHAT to build)
- AGENT-11 implements software (HOW to build it)
- They are SEPARATE PROJECTS that work together

## The Product Development Lifecycle
[Include lifecycle diagram from README]

## Phase 1: Foundation Documents (BOS-AI) - REQUIRED

**CRITICAL**: You cannot skip Foundation. These documents are the INPUT to AGENT-11.

### Why Foundation Matters
- 60-80% higher success rates
- $55K-200K risk mitigation
- 3x faster growth through aligned execution
- Clear PRD that developers can actually implement

### Foundation Document Sequence

| # | Document | Time | Command | Development Impact |
|---|----------|------|---------|-------------------|
| 1 | Vision & Mission | 1 hr | `/coord vision-mission-creation` | Guides product direction |
| 2 | Market Research | 1 hr | `/coord market-research-creation` | Validates features |
| 3 | Client Blueprint | 1 hr | `/coord client-blueprint-creation` | Defines user personas |
| 4 | Positioning | 1 hr | `/coord positioning-creation` | Unique features |
| 5 | Strategic Roadmap | 1 hr | `/coord roadmap-creation` | MVP scope |
| 6 | Brand Guide | 1 hr | `/coord brand-guide-creation` | UI/UX direction |
| 7 | Pricing Strategy | 1-1.5 hr | `/coord pricing-strategy-creation` | Tier features |
| 8 | **PRD** | 1-2 hr | `/coord prd-creation` | **AGENT-11 input** |

### Quick Start vs Complete Foundation
- Quick: `/coord foundation-quick-start` (3-4 hours) - Essential + PRD
- Complete: `/coord foundation-system-setup` (6-8 hours) - All documents

### Each Document Explained
[2-3 paragraphs per document explaining what it provides to development]

## Phase 2: PRD Creation

### What Makes a Good PRD for AGENT-11
- Clear user stories with acceptance criteria
- Business constraints and requirements
- Success metrics (how to measure done)
- NOT technical specifications (AGENT-11 decides those)

### Creating Your PRD
```bash
/coord prd-creation  # 1-2 hours
```

## Phase 3: AGENT-11 Setup and Handoff

### Create Separate Development Project
```bash
mkdir ~/my-product-dev
cd ~/my-product-dev
git init
```

### Install AGENT-11
```bash
curl -fsSL https://raw.githubusercontent.com/TheWayWithin/agent-11/main/install.sh | bash
```

### Copy Your PRD
```bash
cp ~/my-business/documents/foundation/prds/[your-prd].md ~/my-product-dev/ideation.md
```

### Initialize Development
```bash
claude code .
/coord dev-setup ideation.md    # Initialize from PRD
/coord continue                  # Autonomous execution
```

## Phase 4: Return to BOS-AI for Operations

After AGENT-11 delivers working product:

```bash
cd ~/my-business
/coord marketing-system-setup   # 1-2 hours
/coord sales-system-setup       # 1-2 hours
```

## Phase 5: The Continuous Cycle

1. Gather customer feedback in BOS-AI
2. Identify enhancements needed
3. Create new PRDs (`/coord prd-creation`)
4. Hand off to AGENT-11 for implementation
5. Operate enhanced product in BOS-AI
6. Repeat

## Quick Reference

| Phase | Where | Key Command |
|-------|-------|-------------|
| Foundation | BOS-AI | `/coord foundation-quick-start` |
| PRD | BOS-AI | `/coord prd-creation` |
| Development | AGENT-11 | `/coord dev-setup ideation.md` |
| Operations | BOS-AI | `/coord marketing-system-setup` |
| Growth | BOS-AI | `/coord optimize` |
```

### Business Guide Structure (Sprint 3)

**File: `docs/getting-started/business-guide.md`**

```markdown
# Running Your Business with BOS-AI

## Overview
BOS-AI is your complete business operating system with 30 AI agents.
No technical knowledge required - just business strategy and operations.

## Getting Started
[Simple installation - same as README]

## Phase 1: Build Your Foundation (6-8 hours)

Create your strategic business documents:

### Quick Start Option
```bash
/coord foundation-quick-start  # 3-4 hours
```

### Complete Foundation
```bash
/coord foundation-system-setup  # 6-8 hours
```

### What You'll Create
1. Vision & Mission - Your North Star
2. Market Research - Understand your market
3. Client Blueprint - Know your ideal customer
4. Positioning - Stand out from competition
5. Strategic Roadmap - Plan your path
6. Brand Guide - Your visual identity
7. Pricing Strategy - Value-based pricing

## Phase 2: Set Up Operations (3-7 hours)

```bash
/coord marketing-system-setup          # 1-2 hours
/coord sales-system-setup              # 1-2 hours
/coord customer-service-system-setup   # 1-3 hours
```

## Phase 3: Optimize & Grow (Ongoing)

```bash
/coord optimize     # Find biggest opportunity
/coord daily        # Daily metrics review
/coord weekly       # Weekly performance analysis
```

## The Business Chassis
[Brief explanation with formula]

## Need Software Built?

BOS-AI creates PRDs (Product Requirements Documents) that define WHAT to build.
For actual software development, see the [Product Developer Guide](developer-guide.md).

You can also hand PRDs to external development teams.
```

### README Slim-Down Target (Sprint 4)

**Target structure (~300 lines):**

```markdown
# BOS-AI: Your AI-Powered Business Operating System

[3-5 sentence value proposition]
[Badges]

## 🚀 Quick Start (2 minutes)

```bash
mkdir ~/my-business && cd ~/my-business && git init
curl -fsSL https://raw.githubusercontent.com/TheWayWithin/BOS-AI/main/deployment/scripts/install.sh | bash -s full
claude code .
/coord optimize
```

## 📍 Choose Your Path

[Persona callouts with links to guides]

## 📚 Documentation Map

[Categorized links to all docs]

## ⚡ Essential Commands

| Command | Purpose |
|---------|---------|
| `/coord optimize` | Analyze and improve your business |
| `/coord foundation-quick-start` | Create strategic foundation |
| `/meeting @agent "topic"` | Consult specialist agent |
| `/report` | Track progress |

## 🆘 Get Help

- [Troubleshooting](docs/troubleshooting/)
- [FAQ](docs/troubleshooting/faq.md)
- [GitHub Issues](...)
- [GitHub Discussions](...)

## 💖 Support BOS-AI

[Buy me a coffee section]

## License

[License info]
```

### Content Migration Map (Sprint 4)

| README Section | Lines | Move To |
|---------------|-------|---------|
| Lifecycle diagram | 50 | `docs/concepts/lifecycle.md` |
| Stage 1-4 detailed workflows | 400 | `docs/getting-started/developer-guide.md` |
| Foundation Library details | 100 | `docs/getting-started/developer-guide.md` |
| Operations Library details | 150 | `docs/getting-started/business-guide.md` |
| MCP Integration | 50 | Link to existing `docs/guides/MCP-GUIDE.md` |
| 30 Agent descriptions | 50 | Link to existing `docs/agents/README.md` |
| Directory structure | 50 | `docs/reference/directory-structure.md` |
| Source Repository Structure | 50 | `docs/contributing/repository-structure.md` |
| Troubleshooting & FAQ | 100 | `docs/troubleshooting/` |
| Business Chassis details | 50 | `docs/concepts/business-chassis.md` |
| Philosophy sections | 50 | `docs/concepts/philosophy.md` |
| Four-Engine Innovation Cycle | 50 | `docs/concepts/innovation-cycle.md` |
| Solopreneur Advantage | 30 | `docs/concepts/philosophy.md` |
| Detailed installation options | 50 | `docs/getting-started/README.md` |

---

## Sprint Overview

| Sprint | Focus | Duration | Key Deliverables |
|--------|-------|----------|------------------|
| Sprint 1 | Quick Wins & Foundation | 2-3 hours | Callouts, navigation, link existing docs |
| Sprint 2 | Developer Guide | 4-5 hours | Complete developer-guide.md with Foundation treatment |
| Sprint 3 | Business Guide | 2-3 hours | Business-focused guide (simpler path) |
| Sprint 4 | README Slim-Down | 3-4 hours | Reduce main README, move content |
| Sprint 5 | Reference & Polish | 2-3 hours | Quick reference, cross-linking, final review |

**Total Estimated Effort**: 13-18 hours

---

## Sprint 1: Quick Wins & Foundation

**Duration**: 2-3 hours
**Goal**: Improve existing README without major restructuring

### Tasks

- [ ] **1.1 Add persona-based callout boxes to README**
  - Add callout after Quick Start for Business Users
  - Add callout for Product Developers pointing to lifecycle
  - Use consistent formatting (blockquotes with emoji)
  - **Acceptance**: Two clear callouts visible in first scroll

- [ ] **1.2 Create Documentation Map section in README**
  - Add new section after Quick Start
  - Organize links by user journey (New Users, Running Business, Building Products, Reference)
  - Link to all existing docs in `docs/` folder
  - **Acceptance**: Single section with categorized links to all major docs

- [ ] **1.3 Promote existing getting-started content**
  - Add prominent link to `docs/getting-started/README.md` in main README
  - Review and update `docs/getting-started/README.md` if needed
  - Ensure installation instructions are consistent
  - **Acceptance**: Getting started guide linked from 2+ locations in README

- [ ] **1.4 Create docs folder structure for new content**
  - Create `docs/getting-started/business-guide.md` (placeholder)
  - Create `docs/getting-started/developer-guide.md` (placeholder)
  - Create `docs/concepts/` folder
  - Create `docs/workflows/foundation/` folder
  - Create `docs/reference/` folder
  - **Acceptance**: Folder structure exists, placeholder files have TOC outline

### Sprint 1 Deliverables
- [ ] Updated README.md with callouts and documentation map
- [ ] Folder structure for new documentation
- [ ] Placeholder files with outlines

---

## Sprint 2: Developer Guide (Comprehensive)

**Duration**: 4-5 hours
**Goal**: Create complete guide for product developers including full Foundation treatment

### Tasks

- [ ] **2.1 Create developer-guide.md structure**
  - Write introduction explaining two-project architecture
  - Include lifecycle diagram
  - Set expectations: "Foundation is required before AGENT-11"
  - **Acceptance**: Clear intro explaining BOS-AI + AGENT-11 relationship

- [ ] **2.2 Write Foundation Documents section (comprehensive)**
  - Document sequence table with timing
  - Explain WHY each document matters for development
  - Include all commands (`/coord foundation-quick-start`, individual missions)
  - Show dependencies between documents
  - **Acceptance**: Complete Foundation workflow documented with commands

- [ ] **2.3 Write individual Foundation document summaries**
  - Vision & Mission: What it provides to development
  - Market Research: How it informs features
  - Client Blueprint: User personas for development
  - Positioning: Unique features and differentiation
  - Strategic Roadmap: MVP scope and priorities
  - Brand Guide: UI/UX direction
  - Pricing Strategy: Tier features and constraints
  - **Acceptance**: Each document has 2-3 paragraph explanation + command

- [ ] **2.4 Write PRD creation section**
  - PRD as the handoff artifact
  - What makes a good PRD for AGENT-11
  - `/coord prd-creation` workflow
  - PRD prerequisites checklist
  - **Acceptance**: Clear PRD section with prerequisites and commands

- [ ] **2.5 Write AGENT-11 setup and handoff section**
  - Creating separate development project
  - Installing AGENT-11
  - Copying PRD from BOS-AI project
  - `/coord dev-setup` and `/coord dev-alignment` commands
  - Link to AGENT-11 README for full documentation
  - **Acceptance**: Step-by-step AGENT-11 setup with commands

- [ ] **2.6 Write continuous cycle section**
  - Returning to BOS-AI for Operations (Stage 3)
  - Gathering feedback → Creating new PRDs
  - The iteration loop diagram
  - **Acceptance**: Complete lifecycle loop documented

- [ ] **2.7 Add quick reference table**
  - Commands summary for developer workflow
  - Decision tree: "When to use BOS-AI vs AGENT-11"
  - **Acceptance**: One-page reference at end of guide

### Sprint 2 Deliverables
- [ ] Complete `docs/getting-started/developer-guide.md` (~800-1000 lines)
- [ ] Developer workflow fully documented
- [ ] Foundation → PRD → AGENT-11 → Operations cycle complete

---

## Sprint 3: Business Guide

**Duration**: 2-3 hours
**Goal**: Create focused guide for business-only users (no AGENT-11 complexity)

### Tasks

- [ ] **3.1 Create business-guide.md structure**
  - Write introduction: "BOS-AI runs your entire business"
  - Emphasize: No technical knowledge required
  - Hide AGENT-11 complexity (brief mention only)
  - **Acceptance**: Introduction clearly targets non-technical users

- [ ] **3.2 Write Foundation Documents section**
  - Same Foundation sequence as developer guide
  - Different framing: "Your strategic business documents"
  - Focus on business outcomes, not development inputs
  - **Acceptance**: Foundation workflow with business-focused language

- [ ] **3.3 Write Operations Systems section**
  - Marketing System setup and benefits
  - Sales System setup and benefits
  - Customer Service System setup and benefits
  - Finance System setup (if applicable)
  - **Acceptance**: All four Operations systems documented

- [ ] **3.4 Write Growth & Optimization section**
  - Business Chassis optimization
  - `/coord optimize` workflow
  - Daily/weekly review cycles
  - **Acceptance**: Ongoing operations workflow documented

- [ ] **3.5 Add "Need Software Built?" section**
  - Brief explanation that BOS-AI creates PRDs
  - Link to developer-guide.md for full AGENT-11 workflow
  - Option to hand PRDs to external development teams
  - **Acceptance**: Clear off-ramp to development without overwhelming

- [ ] **3.6 Add quick reference table**
  - Essential commands for business operations
  - Mission selection guide
  - Agent consultation examples
  - **Acceptance**: One-page reference at end of guide

### Sprint 3 Deliverables
- [ ] Complete `docs/getting-started/business-guide.md` (~400-500 lines)
- [ ] Business-focused workflow documented
- [ ] No overwhelming technical details

---

## Sprint 4: README Slim-Down

**Duration**: 3-4 hours
**Goal**: Reduce main README to ~300 lines by moving content to appropriate locations

### Tasks

- [ ] **4.1 Identify content to move**
  - Audit current README sections
  - Tag each section: KEEP, MOVE, or CONSOLIDATE
  - Create mapping of where content moves to
  - **Acceptance**: Complete audit document/checklist

- [ ] **4.2 Move lifecycle content to docs/concepts/**
  - Move detailed lifecycle diagram to `docs/concepts/lifecycle.md`
  - Keep simplified version in README
  - Update cross-references
  - **Acceptance**: Lifecycle details moved, README has summary + link

- [ ] **4.3 Move Business Chassis details to docs/concepts/**
  - Create `docs/concepts/business-chassis.md`
  - Move formula explanation and multiplication effect details
  - Keep one-line formula in README
  - **Acceptance**: Business Chassis concept doc created, README simplified

- [ ] **4.4 Move Foundation/Operations details**
  - Consolidate Foundation details in developer/business guides
  - Remove duplication from README
  - Link to guides instead
  - **Acceptance**: Foundation details removed from README, linked to guides

- [ ] **4.5 Move technical reference content**
  - Move directory structure to `docs/reference/directory-structure.md`
  - Move source repository structure to `docs/contributing/`
  - Move detailed MCP content (keep link to existing guide)
  - **Acceptance**: Technical details moved, README has links only

- [ ] **4.6 Move troubleshooting content**
  - Create `docs/troubleshooting/` folder structure
  - Move FAQ to `docs/troubleshooting/faq.md`
  - Move installation issues to `docs/troubleshooting/installation.md`
  - Keep brief troubleshooting section in README with links
  - **Acceptance**: Troubleshooting moved, README has summary + links

- [ ] **4.7 Consolidate installation sections**
  - Single authoritative installation section
  - Remove duplicate installation commands
  - Clear decision tree: Standard vs MCP-Enhanced
  - **Acceptance**: One installation section, no duplicates

- [ ] **4.8 Rewrite README introduction**
  - Concise value proposition (3-5 sentences)
  - Clear "Choose Your Path" section
  - Prominent links to persona guides
  - **Acceptance**: README intro is <50 lines

- [ ] **4.9 Final README structure**
  - Target: ~300 lines total
  - Sections: Intro, Install, Choose Path, Essential Commands, Get Help
  - All detailed content linked, not inline
  - **Acceptance**: README is 250-350 lines

### Sprint 4 Deliverables
- [ ] Slim README.md (~300 lines)
- [ ] Content moved to appropriate `docs/` locations
- [ ] All links verified working
- [ ] No content lost (everything preserved somewhere)

---

## Sprint 5: Reference & Polish

**Duration**: 2-3 hours
**Goal**: Add reference materials and final polish

### Tasks

- [ ] **5.1 Create quick reference card**
  - Create `docs/reference/quick-reference.md`
  - One-page command cheat sheet
  - Mission decision tree
  - Agent selection guide by need
  - **Acceptance**: Single-page printable reference

- [ ] **5.2 Create first-mission guide**
  - Create `docs/getting-started/first-mission.md`
  - Guided walkthrough of `/coord optimize`
  - What to expect, how to interpret results
  - Next steps after first mission
  - **Acceptance**: Beginner-friendly first experience guide

- [ ] **5.3 Improve cross-linking**
  - Add "See also" sections to all docs
  - Ensure consistent navigation patterns
  - Add breadcrumbs or "Back to" links
  - **Acceptance**: Every doc links to related content

- [ ] **5.4 Update existing docs for consistency**
  - Review `docs/agents/README.md` - update links
  - Review `docs/missions/README.md` - update links
  - Review `docs/getting-started/README.md` - align with new structure
  - **Acceptance**: All existing docs aligned with new structure

- [ ] **5.5 Create/update docs index**
  - Update `docs/README.md` (if exists) or create
  - Complete documentation map
  - Clear navigation for all user types
  - **Acceptance**: Single index page for all documentation

- [ ] **5.6 Final review and testing**
  - Read through as Business User persona
  - Read through as Product Developer persona
  - Verify all links work
  - Check for remaining duplication
  - **Acceptance**: Both personas can navigate successfully

- [ ] **5.7 Update CLAUDE.md references**
  - Ensure CLAUDE.md links to new docs where appropriate
  - Check for outdated references
  - **Acceptance**: CLAUDE.md aligned with new structure

### Sprint 5 Deliverables
- [ ] `docs/reference/quick-reference.md`
- [ ] `docs/getting-started/first-mission.md`
- [ ] All docs cross-linked
- [ ] Documentation index updated
- [ ] Final review complete

---

## Definition of Done

### Per Sprint
- [ ] All tasks marked complete
- [ ] Deliverables created and verified
- [ ] Links tested and working
- [ ] No broken references

### Project Complete
- [ ] README reduced to ~300 lines
- [ ] Developer guide complete with full Foundation treatment
- [ ] Business guide complete with simplified path
- [ ] All content preserved (nothing lost)
- [ ] Clear navigation for both personas
- [ ] Quick reference materials available
- [ ] All cross-links working

---

## Risk Mitigation

| Risk | Mitigation |
|------|------------|
| Content lost during move | Create audit checklist, verify each section moved |
| Broken links | Test all links after each sprint |
| Inconsistent information | Single source of truth for each topic |
| Scope creep | Stick to restructuring, don't add new content |
| User confusion during transition | Complete all sprints before announcing changes |

---

## Dependencies

```
Sprint 1 ─────────────────────────────────────┐
    │                                         │
    ▼                                         │
Sprint 2 (Developer Guide)                    │
    │                                         │
    ▼                                         │
Sprint 3 (Business Guide)                     │
    │                                         │
    ▼                                         │
Sprint 4 (README Slim-Down) ◄─────────────────┘
    │         (needs guides to link to)
    ▼
Sprint 5 (Polish)
```

- Sprint 4 depends on Sprints 2 & 3 (needs guides to exist before linking)
- Sprint 5 depends on Sprint 4 (needs final structure before polish)
- Sprints 2 & 3 can run in parallel after Sprint 1

---

## Notes

- **Do not delete** any content from README until it's confirmed moved elsewhere
- **Preserve git history** - use moves rather than delete/create where possible
- **Test as user** - navigate as each persona to verify experience
- **Keep CLAUDE.md stable** - this is the command reference, changes are minimal

---

*Created: 2025-01-09*
*Status: Ready for execution*
