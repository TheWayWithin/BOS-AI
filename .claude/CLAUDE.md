# BOS-AI Development Environment

**This is the BOS-AI LIBRARY repository. We use AGENT-11 to build it.**

---

## Two Directory Structures

| Directory | Contains | Edit? |
|-----------|----------|-------|
| `.claude/` | AGENT-11 runtime (agents, commands, missions we USE) | ❌ No |
| `/agents/`, `/commands/`, `/missions/` | BOS-AI library source (what we BUILD) | ✅ Yes |

```
BOS-AI Repository
├── .claude/                    ← AGENT-11 (DO NOT EDIT)
│   ├── agents/                 ← @developer, @tester, @architect (we USE these)
│   ├── commands/               ← /coord, /pmd (AGENT-11 versions)
│   └── CLAUDE.md               ← THIS FILE
│
├── /agents/                    ← BOS-AI LIBRARY (EDIT THESE)
│   ├── coordination/           ← chassis-intelligence.md, etc.
│   ├── marketing/              ← brand-strategy.md, etc.
│   └── ...                     ← 29 business agents (source)
│
├── /commands/                  ← BOS-AI LIBRARY (EDIT THESE)
│   ├── coord.md                ← BOS-AI /coord command
│   └── meeting.md              ← BOS-AI /meeting command
│
├── /missions/                  ← BOS-AI LIBRARY (EDIT THESE)
│
└── /CLAUDE.md                  ← BOS-AI user docs (DEPLOYED to users)
```

---

## Quick Rules

| If you need to... | Do this |
|-------------------|---------|
| Fix BOS-AI user issue | Edit `/commands/`, `/agents/`, `/missions/` |
| Update BOS-AI docs | Edit root `/CLAUDE.md` |
| Use development agents | Use @developer, @tester, @architect |
| Test deployment | Deploy to SEPARATE project, never here |

---

## Available AGENT-11 Agents

For development work, use these agents:

| Agent | Purpose |
|-------|---------|
| `@developer` | Implement features, fix bugs |
| `@tester` | Test functionality, verify fixes |
| `@architect` | Design systems, review architecture |
| `@designer` | UX/UI, documentation design |
| `@documenter` | Write documentation |
| `@coordinator` | Orchestrate complex tasks |
| `@strategist` | Plan features, requirements |
| `@operator` | Deployment, CI/CD |

---

## Common Mistakes

### Wrong: Edit .claude/ for BOS-AI fixes
```
.claude/commands/coord.md     ← AGENT-11 version (we USE)
/commands/coord.md            ← BOS-AI version (we BUILD) ✅
```

### Wrong: Run deployment here
```bash
# ❌ Never do this - overwrites AGENT-11 with BOS-AI
./deployment/scripts/deploy-bos-ai.sh

# ✅ Test in separate project
cd ~/test-business && /path/to/deploy-bos-ai.sh
```

### Wrong: Use BOS-AI commands for development
```bash
# ❌ These are for BOS-AI users
/coord optimize
/meeting @chassis-intelligence

# ✅ Use AGENT-11 for development
@developer implement feature
@tester verify fix
```

---

## File Location Cheat Sheet

| To edit... | Edit this | NOT this |
|------------|-----------|----------|
| BOS-AI coord command | `/commands/coord.md` | ~~`.claude/commands/coord.md`~~ |
| BOS-AI agents | `/agents/[category]/[name].md` | ~~`.claude/agents/`~~ |
| BOS-AI missions | `/missions/[category]/[name].md` | N/A |
| BOS-AI user docs | `/CLAUDE.md` | N/A |
| This dev environment | `.claude/CLAUDE.md` | N/A |

---

## Remember

- **AGENT-11** is in `.claude/` - we USE it for development
- **BOS-AI library** is in root dirs - we BUILD it for users
- **Never deploy here** - test in separate projects
- **Root CLAUDE.md** deploys to users - keep it lean
