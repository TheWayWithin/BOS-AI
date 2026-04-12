# Sprint 2: Safe Install Pipeline

**Priority**: HIGH
**Effort**: ~1-2 hours
**Risk reduction**: Covers findings #2, #6, #7, #8 from security audit
**Scope**: Install scripts, MCP setup scripts
**Depends on**: Sprint 1 (shell hardening should land first)

---

## Tasks

### Temp file safety (finding #2)

- [ ] Replace hardcoded `/tmp/bos-ai-install` with `mktemp -d` in `install-bos-ai.sh`
- [ ] Replace any other hardcoded `/tmp` paths across all scripts with `mktemp`
- [ ] Add cleanup traps to every script that creates temp files/directories:
  ```bash
  TEMP_DIR=$(mktemp -d "${TMPDIR:-/tmp}/bos-ai-install.XXXXXXXXXX")
  trap 'rm -rf "$TEMP_DIR"' EXIT INT TERM
  ```

### Backup before overwrite (finding #6)

- [ ] In `deployment/scripts/install.sh`: before any `cat > file` that overwrites user files, check if the file exists and back it up
  ```bash
  if [ -f "$TARGET_FILE" ]; then
    cp "$TARGET_FILE" "${TARGET_FILE}.bak.$(date +%Y%m%d_%H%M%S)"
    echo "Backed up existing $TARGET_FILE"
  fi
  ```
- [ ] Apply same pattern to `install-to-project.sh` (already partially does this for CLAUDE.md — extend to all files)

### Safe env parsing (finding #7)

- [ ] Replace `source "$PROJECT_ROOT/.env.mcp"` in `mcp-setup.sh` with safe key=value parser:
  ```bash
  while IFS='=' read -r key value; do
    [[ "$key" =~ ^[[:space:]]*# ]] && continue
    [[ -z "$key" ]] && continue
    if [[ "$key" =~ ^[A-Za-z_][A-Za-z0-9_]*$ ]]; then
      export "$key=$value"
    fi
  done < "$PROJECT_ROOT/.env.mcp"
  ```
- [ ] Apply same pattern to `deployment/scripts/mcp-setup.sh`

### Cleanup traps (finding #8)

- [ ] Add `trap 'rm -rf "$TEMP_DIR"' EXIT INT TERM` to `install-bos-ai.sh`
- [ ] Add same trap to `quick-install.sh`
- [ ] Verify no temp files left behind after interrupted install (test with Ctrl+C mid-run)

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
