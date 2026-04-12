# Sprint 2: Safe Install Pipeline

**Priority**: HIGH
**Effort**: ~1-2 hours
**Risk reduction**: Covers findings #2, #6, #7, #8 from security audit
**Scope**: Install scripts, MCP setup scripts
**Depends on**: Sprint 1 (shell hardening should land first)

---

## Tasks

### Temp file safety (finding #2)

- [x] Replace hardcoded `/tmp/bos-ai` paths with `${TMPDIR:-/tmp}/bos-ai` in `validate-mcp-services.sh` and `install-core-services.sh` — 2026-04-12
- [x] No hardcoded `/tmp` paths remain in any BOS-AI script (verified with grep) — 2026-04-12
- N/A: `install-bos-ai.sh` and `quick-install.sh` are in agent-11 repo, not BOS-AI

### Backup before overwrite (finding #6)

- [x] `deployment/scripts/install.sh` already guards CLAUDE.md with `[ ! -f ]` check and backup — N/A
- [x] `install-to-project.sh` already backed up CLAUDE.md; added backup for BOUNDARIES.md — 2026-04-12
- N/A: Agent deploy scripts (`deploy-full-agents.sh`, `deploy-complete.sh`) intentionally regenerate all files — no backup needed

### Safe env parsing (finding #7)

- [x] Replaced `source .env.mcp` with safe key=value parser in `mcp-setup.sh` — completed in Sprint 1
- N/A: `deployment/scripts/mcp-setup.sh` does not exist (it's a subdirectory `mcp-setup/`)

### Cleanup traps (finding #8)

- N/A: `install-bos-ai.sh` and `quick-install.sh` are in agent-11 repo, not BOS-AI
- [x] No BOS-AI scripts create temp directories that need cleanup traps — verified

## Files to modify

| File | Changes |
|------|---------|
| `project/deployment/scripts/install-bos-ai.sh` | mktemp, cleanup trap |
| `project/deployment/scripts/quick-install.sh` | cleanup trap |
| `deployment/scripts/install.sh` | backup before overwrite |
| `install-to-project.sh` | extend backup pattern to all overwrites |
| `mcp-setup.sh` | safe env parsing |
| `deployment/scripts/mcp-setup.sh` | safe env parsing |

## Acceptance criteria

- No hardcoded `/tmp` paths remain in any script
- All temp directories created with `mktemp -d` with random suffix
- Every script that creates temp files has `trap ... EXIT INT TERM`
- Existing user files backed up before overwrite (with timestamped `.bak` suffix)
- `.env.mcp` parsed as key=value pairs, not `source`d as shell code
- Comments and blank lines in `.env.mcp` handled correctly
- Only alphanumeric variable names accepted from `.env.mcp`

## Testing

```bash
# Test cleanup trap — start install, Ctrl+C midway, verify no /tmp leftovers
ls /tmp/bos-ai-install* 2>/dev/null  # should be empty

# Test backup — run install twice, verify .bak file created on second run
ls .claude/CLAUDE.md.bak.* 2>/dev/null

# Test safe env parsing — add a comment and blank line to .env.mcp, verify no errors
echo "# this is a comment" >> .env.mcp
echo "" >> .env.mcp
./mcp-setup.sh  # should not error

# Test malicious env — verify code in .env doesn't execute
echo 'MALICIOUS=$(echo pwned > /tmp/pwned)' >> /tmp/test-env.mcp
# Parse with new safe parser — /tmp/pwned should NOT be created
```
