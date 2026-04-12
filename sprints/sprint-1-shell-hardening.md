# Sprint 1: Shell Script Hardening

**Priority**: HIGH
**Effort**: ~30 minutes
**Risk reduction**: Covers findings #3, #4, #5, #10, #11 from security audit
**Scope**: Every `.sh` file in the repo (excluding `.claude/` and `node_modules/`)

---

## Tasks

- [x] Add `set -euo pipefail` to the top of every shell script — 2026-04-12
- [x] Quote critical variable expansions and fix bare `$2` refs with defaults — 2026-04-12
- [x] Add input validation on target path in `install-to-project.sh` (refuse system dirs) — 2026-04-12
- [x] Replace `source .env.mcp` with safe key=value parser in `mcp-setup.sh` — 2026-04-12
- [x] Grep patterns in `mcp-setup.sh` already specific (check MCP list output, not .env) — N/A
- [x] `commands/scripts/__pycache__/` already deleted in prior session — N/A

## Files to modify

| File | Changes |
|------|---------|
| `install-to-project.sh` | `set -euo pipefail`, quote all vars, validate `$1` |
| `deployment/scripts/install.sh` | `set -euo pipefail`, quote all vars |
| `deployment/scripts/deploy-complete.sh` | `set -euo pipefail`, quote all vars, validate `$1` |
| `deployment/scripts/deploy-full-agents.sh` | `set -euo pipefail`, quote all vars, validate `$1` |
| `deployment/scripts/deploy-optimized-agents.sh` | `set -euo pipefail`, quote all vars, validate `$1` |
| `mcp-setup.sh` | `set -euo pipefail`, quote all vars, anchor grep patterns |
| `deployment/scripts/mcp-setup.sh` | `set -euo pipefail`, quote all vars |
| `mcp/install-mcp.sh` | `set -euo pipefail`, quote all vars |
| `mcp/install-dynamic-mcp.sh` | `set -euo pipefail`, quote all vars |

## Acceptance criteria

- All scripts exit on first error (`set -e`)
- All scripts fail on unset variables (`set -u`)
- All scripts catch pipe failures (`set -o pipefail`)
- No unquoted variable expansions remain (verified with `shellcheck` if available)
- Paths with spaces handled correctly
- System directories rejected with clear error message
- `__pycache__` cleaned up

## Testing

```bash
# Verify set -euo pipefail present in all scripts
grep -rL 'set -euo pipefail' --include='*.sh' .

# Run shellcheck if available
shellcheck install-to-project.sh deployment/scripts/*.sh mcp-setup.sh

# Test path validation
./install-to-project.sh "/tmp/test project"  # should work (spaces)
./install-to-project.sh /etc                  # should refuse
./install-to-project.sh /nonexistent          # should error
```
