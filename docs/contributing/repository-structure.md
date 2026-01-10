# Repository Structure Guide for Contributors

> **Status**: Coming Soon - Sprint 3 Deliverable

Understanding the BOS-AI repository structure for developers contributing to the project.

---

## Table of Contents (Planned)

### 1. Understanding the Two-Layer Architecture

**Critical Distinction**:
```
/.claude/           ← RUNTIME (do not edit directly)
/agents/            ← SOURCE (edit these)
/commands/          ← SOURCE (edit these)
```

### 2. Development Environment
- BOS-AI uses AGENT-11 for its own development
- `.claude/` contains AGENT-11 development agents
- `/agents/` contains BOS-AI business agents (source)

### 3. Directory Deep-Dive

#### Runtime Directory (`.claude/`)
- `agents/` - AGENT-11 dev agents (read-only)
- `commands/` - AGENT-11 dev commands (read-only)
- `CLAUDE.md` - Development instructions
- `BOUNDARIES.md` - System boundaries

#### Source Directories
- `/agents/` - BOS-AI agent source files
- `/commands/` - BOS-AI command source files
- `/missions/` - Mission definition files
- `/templates/` - Reusable template files

### 4. Making Changes
- How deployment scripts work
- Testing changes safely
- Pull request requirements

### 5. Common Contributor Mistakes
- Editing `.claude/` instead of source
- Running deployment in dev environment
- Confusing AGENT-11 with BOS-AI agents

### 6. Testing Protocol
- Creating test environments
- Verification checklist
- Rollback procedures

---

## Key Files for Contributors

| File | Purpose |
|------|--------|
| `.claude/CLAUDE.md` | Development environment instructions |
| `CLAUDE.md` | User-facing system instructions |
| `DEPLOYMENT-VERIFICATION.md` | Testing guide |
| `.claude/BOUNDARIES.md` | System boundaries |

---

[Back to README](../../README.md) | [Contributing Guide](../)
