# Sprint 3: Install Integrity & Version Pinning

**Priority**: CRITICAL (highest-impact fix but requires design decisions)
**Effort**: ~2-3 hours
**Risk reduction**: Covers findings #1, #9 from security audit
**Scope**: Remote install pipeline (`curl|bash` pattern)
**Depends on**: Sprint 1 and Sprint 2 (scripts should be hardened first)

---

## Context

BOS-AI's install path is `curl -fsSL <url> | bash`. This is the highest-risk
pattern in the repo. If the GitHub raw content endpoint is compromised, a MITM
succeeds, or someone gains write access to `main`, every new install runs
attacker-controlled code. This sprint adds integrity verification and version
pinning to close that gap.

## Tasks

### Version pinning (finding #9)

- [x] Versioning scheme: semver (v1.0.0) — 2026-04-12
- [x] `deployment/scripts/install.sh` GITHUB_RAW_BASE now uses `${BOS_AI_VERSION}` instead of hardcoded `main` — 2026-04-12
- [x] README documents version pinning with `BOS_AI_VERSION=v1.0.0` — 2026-04-12
- N/A: `install-bos-ai.sh` and `quick-install.sh` are in agent-11 repo, not BOS-AI

### Integrity verification (finding #1)

Decision: **Option A** (download-then-inspect). No checksum overhead.

- [x] README updated with download-then-inspect as recommended install pattern — 2026-04-12
- [x] Direct `curl|bash` pipe kept as documented alternative — 2026-04-12
- N/A: `quick-install.sh` is in agent-11 repo

### Release process

- [x] First tagged release `v1.0.0` created and pushed to GitHub — 2026-04-12
- [x] Users can now pin with `BOS_AI_VERSION=v1.0.0` — verified
- Note: README quick-start URLs still reference `main` (intentional — the quick-start should always get latest; pinning is for production/repeatable installs)

## Files to modify

| File | Changes |
|------|---------|
| `project/deployment/scripts/install-bos-ai.sh` | Version parameter, download-to-file |
| `project/deployment/scripts/quick-install.sh` | Version parameter, download-to-file |
| `deployment/scripts/install.sh` | Version-aware `GITHUB_RAW_BASE` |
| `README.md` | Document version pinning and inspect-before-run |

## Design decisions needed

1. **Versioning scheme**: semver (`v1.0.0`) or date-based (`2026.04`)? Semver recommended.
2. **Option A vs B**: Download-then-verify is simpler and has no maintenance overhead. Checksum verification is stronger but requires updating checksums on every release. Recommend starting with Option A and adding checksums later if the user base grows.
3. **Breaking the `curl|bash` one-liner**: The inspect-before-run pattern is safer but adds a step. Keep the one-liner as a documented alternative? Recommend yes, with a clear warning.

## Acceptance criteria

- Install scripts accept `BOS_AI_VERSION` env var to pin to a tagged release
- Default behaviour fetches latest release tag (not `main`)
- At least one of: download-to-file with inspect prompt, or checksum verification
- First tagged release exists on GitHub
- README documents the new install options
- No install script references `main` branch directly for file downloads

## Testing

```bash
# Test version pinning
BOS_AI_VERSION=v1.0.0 bash quick-install.sh

# Test latest resolution
bash quick-install.sh  # should resolve to latest tag

# Test download-to-file (Option A)
bash quick-install.sh  # should print path and prompt to review

# Test invalid version
BOS_AI_VERSION=v99.99.99 bash quick-install.sh  # should error clearly
```
