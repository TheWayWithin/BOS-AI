# Agent Context: README Enhancement Mission

**Mission**: BOS-AI README Progressive Disclosure Restructuring
**Started**: 2026-01-09
**Objective**: Reduce README from ~1,400 lines to ~300 lines using progressive disclosure

---

## Mission Objectives

1. **Primary**: Restructure BOS-AI documentation for two distinct user personas
2. **Secondary**: Maintain comprehensive coverage while improving accessibility
3. **Constraint**: No content loss - everything must be preserved somewhere

---

## Target Personas

### Persona 1: Business-Only Users
- **Goal**: Run a business with BOS-AI (no development)
- **Pain Point**: Overwhelmed by AGENT-11 technical details
- **Need**: Simple path to Foundation → Operations → Growth
- **Destination**: `docs/getting-started/business-guide.md`

### Persona 2: Product Developers
- **Goal**: Build products using BOS-AI + AGENT-11 lifecycle
- **Pain Point**: Can't find complete Foundation → PRD → AGENT-11 path
- **Need**: Full lifecycle documentation with commands
- **Destination**: `docs/getting-started/developer-guide.md`

---

## Current State Analysis

### README.md Statistics
- Total lines: ~1,388
- Target lines: ~300
- Reduction needed: ~78%

### Content Distribution (Approximate)
| Section | Lines | Disposition |
|---------|-------|-------------|
| Lifecycle diagram | 50 | Move to `docs/concepts/lifecycle.md` |
| Stage 1-4 detailed workflows | 400 | Move to developer-guide.md |
| Foundation Library details | 100 | Move to developer-guide.md |
| Operations Library details | 150 | Move to business-guide.md |
| MCP Integration | 50 | Link to existing `docs/guides/MCP-GUIDE.md` |
| 30 Agent descriptions | 50 | Link to existing `docs/agents/README.md` |
| Directory structure | 50 | Move to `docs/reference/directory-structure.md` |
| Source Repository Structure | 50 | Move to `docs/contributing/repository-structure.md` |
| Troubleshooting & FAQ | 100 | Move to `docs/troubleshooting/` |
| Business Chassis details | 50 | Move to `docs/concepts/business-chassis.md` |
| Philosophy sections | 50 | Move to `docs/concepts/philosophy.md` |
| Four-Engine Innovation | 50 | Move to `docs/concepts/innovation-cycle.md` |
| Solopreneur Advantage | 30 | Move to `docs/concepts/philosophy.md` |
| Detailed installation | 50 | Move to `docs/getting-started/README.md` |

### Existing Documentation Structure
```
docs/
├── getting-started/
│   └── README.md          # EXISTS - Basic getting started
├── agents/
│   └── README.md          # EXISTS - Agent catalog
├── missions/
│   └── README.md          # EXISTS - Mission catalog
├── guides/
│   └── MCP-GUIDE.md       # EXISTS - MCP documentation
└── OPERATIONS-LIBRARY.md  # EXISTS - Operations docs
```

### Structure to Create
```
docs/
├── getting-started/
│   ├── README.md          # EXISTS
│   ├── developer-guide.md # CREATE
│   ├── business-guide.md  # CREATE
│   └── first-mission.md   # CREATE
├── concepts/
│   ├── business-chassis.md # CREATE
│   ├── lifecycle.md        # CREATE
│   └── philosophy.md       # CREATE
├── reference/
│   ├── quick-reference.md  # CREATE
│   └── directory-structure.md # CREATE
├── troubleshooting/
│   ├── faq.md              # CREATE
│   └── installation.md     # CREATE
└── workflows/
    └── foundation/
        └── README.md       # CREATE
```

---

## Sprint Execution Plan

### Sprint 1: Quick Wins (2-3 hours) ← CURRENT
- Add persona callouts to README
- Add Documentation Map
- Create folder structure
- Create placeholder files

### Sprint 2: Developer Guide (4-5 hours)
- Complete developer-guide.md (~800-1000 lines)
- Full Foundation → PRD → AGENT-11 → Operations workflow

### Sprint 3: Business Guide (2-3 hours)
- Complete business-guide.md (~400-500 lines)
- Simplified business-only workflow

### Sprint 4: README Slim-Down (3-4 hours)
- Reduce README to ~300 lines
- Move content to appropriate docs

### Sprint 5: Polish (2-3 hours)
- Quick reference card
- Cross-linking
- Final review

---

## Key Decisions Made

1. **Progressive Disclosure Pattern**: README provides overview and routing, detailed content lives in specific guides
2. **Two-Guide Approach**: Separate guides for each persona rather than trying to serve both in one document
3. **Sprint Dependencies**: Sprints 2-3 must complete before Sprint 4 (need guides to link to)
4. **No Content Loss**: All information will be preserved, just reorganized

---

## Accumulated Findings

*(Updated as mission progresses)*

### 2026-01-09 - Mission Start
- README is well-written but too comprehensive for a landing page
- Clear persona split is possible: business-only vs. product developers
- Foundation documents are critical for both paths but need different framing
- AGENT-11 details should only appear in developer guide

---

## Critical Constraints

1. **BOS-AI Development Repo**: We are in the BOS-AI source repository using AGENT-11 agents
2. **Edit Library Source**: Changes to BOS-AI content go in root `/` not `.claude/`
3. **No Deployment Testing**: Don't run deploy scripts in this repo
4. **Security First**: Follow Critical Software Development Principles

---
