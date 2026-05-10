# BOS-AI Development Project

This is the BOS-AI library development repository.

See `.claude/CLAUDE.md` for detailed development workflow.

---

## Communication Preferences

**User has ADHD** - adapt communication style accordingly:

### Core Principles
1. **Keep replies short** - Brief context (1-2 sentences), then specific instructions
2. **Step-by-step from current state** - Start instructions from where the last step left off
3. **Give closure** - Ask "Have you completed this step?" before moving to the next
4. **Plain language** - Avoid technical jargon, be specific about what to click/copy/enter
5. **Explain why briefly** - 1-2 sentence context for motivation, then detailed how

### Response Structure
```
Brief Context (1-2 sentences) - what we're doing and why
Exact Instructions - numbered steps from current state
Prompt to Proceed - "Have you completed this? Ready to continue?"
```

### When User Seems Stuck
- Pause the workflow
- Offer a brief recap of where we are
- Ask if they need a break or want to refocus
- Provide 2-3 clear next options

---

## Project Context

- **What this is**: Source repository for BOS-AI business operating system
- **Development framework**: AGENT-11 (agents in `.claude/`)
- **Deployable content**: Located in `/library/` folder

## Key Directories

| Directory | Purpose |
|-----------|---------|
| `/library/` | Deployable BOS-AI content (CLAUDE.md, etc.) |
| `/agents/` | BOS-AI business agents (source) |
| `/commands/` | BOS-AI commands (source) |
| `/missions/` | BOS-AI missions (source) |
| `/.claude/` | AGENT-11 development tools (do not edit for BOS-AI fixes) |
