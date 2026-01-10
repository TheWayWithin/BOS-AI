# Troubleshooting Guide

Solutions for common issues when using BOS-AI.

---

## Mission Issues

### Mission fails to start or returns error

**Solutions:**
1. Check `/workspace/missions/active/` for active missions (can't run multiple simultaneously)
2. Verify mission name is correct (case-sensitive)
3. Check if inputs are required: `/missions/[category]/[mission-name].md`
4. Try interactive mode: `/coord` → Select mission from menu

### Mission takes longer than estimated

**Solutions:**
1. Time estimates are typical - your context may require more customization
2. Check progress: `[mission-name]-progress.md` in `/workspace/missions/active/`
3. Missions can be paused and resumed across sessions

---

## Agent Issues

### Agent doesn't respond or provides generic answers

**Solutions:**
1. Be specific in `/meeting` requests: Include context and constraints
2. Try different agent specialization (e.g., `@brand-strategy` vs. `@campaign-execution`)
3. Use `/pmd` for root cause analysis if issue persists

### Don't know which agent to use

**Solutions:**
1. Reference Available Agents section in CLAUDE.md for specializations
2. Start with engine-level agents (e.g., `@scaling-strategy` for growth questions)
3. Use `/coord` instead - it auto-selects correct agents for missions

---

## Boundary Confusion

### Confused about BOS-AI vs. AGENT-11

**Key distinction:**
- **BOS-AI** = Business operations (strategy, PRDs, marketing, sales)
- **AGENT-11** = Software development (code, architecture, deployment)

**Rule of thumb:** BOS-AI creates requirements, AGENT-11 creates code.

**Solutions:**
1. Read `.claude/BOUNDARIES.md` for complete separation details
2. If you need software built, create PRD in BOS-AI and hand off to AGENT-11

---

## Document Issues

### Can't find templates

**Location:** `.claude/document-library/`
- Foundation templates: `.claude/document-library/Foundation/`
- Operations templates: `.claude/document-library/Operations/`

### PRD handoff questions

See PRD Creation SOP at `.claude/document-library/Foundation/PRD Creation SOP.md`

---

## Quick Diagnostics

Use `/pmd "describe the issue"` for automated root cause analysis and recommendations.

**Common diagnostic commands:**
```bash
/pmd "mission not starting"
/pmd "agent responses unclear"
/pmd "document not found"
```

---

**See also:** [FAQ](faq.md) | [Quick Reference](../reference/quick-reference.md)
