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

- [ ] Create a release tagging strategy — decide on versioning scheme (e.g. `v1.0.0`, `v1.1.0`)
- [ ] Update `install-bos-ai.sh` and `quick-install.sh` to accept a version parameter:
  ```bash
  VERSION="${BOS_AI_VERSION:-latest}"
  if [ "$VERSION" = "latest" ]; then
    # Fetch latest release tag from GitHub API
    VERSION=$(curl -fsSL https://api.github.com/repos/TheWayWithin/BOS-AI/releases/latest | grep '"tag_name"' | cut -d'"' -f4)
  fi
  INSTALL_URL="https://raw.githubusercontent.com/TheWayWithin/BOS-AI/$VERSION/deployment/scripts/install.sh"
  ```
- [ ] Update `deployment/scripts/install.sh` to use versioned URLs for all file downloads (replace `main` with `$VERSION` in `GITHUB_RAW_BASE`)
- [ ] Document the version pinning in README install section:
  ```bash
  # Install latest release (recommended)
  curl -fsSL https://... | bash

  # Pin to specific version
  BOS_AI_VERSION=v1.0.0 curl -fsSL https://... | bash
  ```

### Integrity verification (finding #1)

Choose one approach (Option A recommended for simplicity):

**Option A: Download-then-verify (simpler)**

- [ ] Update `quick-install.sh` to download to temp file instead of piping directly:
  ```bash
  TMPFILE=$(mktemp "${TMPDIR:-/tmp}/bos-ai-install.XXXXXXXXXX")
  trap 'rm -f "$TMPFILE"' EXIT INT TERM
  curl -fsSL "$INSTALL_URL" -o "$TMPFILE"
  echo "Downloaded install script to $TMPFILE"
  echo "Review it before running: cat $TMPFILE"
  echo "Run with: bash $TMPFILE"
  ```
- [ ] Document the inspect-before-run pattern in README as the recommended approach
- [ ] Keep the direct `curl|bash` one-liner as an alternative for users who accept the risk

**Option B: Checksum verification (stronger but maintenance overhead)**

- [ ] Generate SHA-256 checksums for each release and publish in `CHECKSUMS.sha256`
- [ ] Update install scripts to verify checksum before execution:
  ```bash
  EXPECTED_SHA=$(curl -fsSL "$CHECKSUM_URL" | grep "install.sh" | cut -d' ' -f1)
  ACTUAL_SHA=$(shasum -a 256 "$TMPFILE" | cut -d' ' -f1)
  if [ "$ACTUAL_SHA" != "$EXPECTED_SHA" ]; then
    echo "ERROR: Checksum mismatch. Aborting. The download may be corrupted or tampered with."
    exit 1
  fi
  ```
- [ ] Add checksum generation to release process (manual or CI)

### Release process

- [ ] Create first tagged release from current `main`
- [ ] Document release process (tag, push tag, optionally generate checksums)
- [ ] Update all documentation that references `main` branch URLs to reference releases

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
