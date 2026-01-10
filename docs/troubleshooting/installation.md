# Installation Troubleshooting

Solutions for common installation and setup issues with BOS-AI.

---

## Pre-Installation Checklist

Before installing BOS-AI, verify you have:

| Requirement | How to Check | Notes |
|-------------|--------------|-------|
| Claude Code | `claude --version` | Must be installed and working |
| Git | `git --version` | Required for repository operations |
| Terminal access | Open Terminal app | macOS, Linux, or Windows PowerShell |
| Network access | `ping github.com` | Required to download BOS-AI |

---

## Installation Methods

### Method 1: Full Installation (Recommended)

```bash
mkdir ~/my-business && cd ~/my-business && git init
curl -fsSL https://raw.githubusercontent.com/TheWayWithin/BOS-AI/main/deployment/scripts/install.sh | bash -s full
```

### Method 2: Manual Installation

If the automatic installer fails:

```bash
# Create your business directory
mkdir ~/my-business && cd ~/my-business && git init

# Clone BOS-AI
git clone https://github.com/TheWayWithin/BOS-AI.git temp-bos

# Copy required files
cp -r temp-bos/.claude .
cp temp-bos/CLAUDE.md .

# Clean up
rm -rf temp-bos

# Verify
ls -la .claude/agents/
```

---

## Common Issues and Solutions

### Issue: "curl: command not found"

**Symptom**: Terminal says curl is not installed.

**Solution**:
```bash
# macOS - install Xcode command line tools
xcode-select --install

# Linux (Ubuntu/Debian)
sudo apt-get install curl

# Linux (CentOS/RHEL)
sudo yum install curl
```

---

### Issue: "Permission denied"

**Symptom**: Script fails with permission errors.

**Solutions**:

1. **Check directory permissions**:
   ```bash
   ls -la ~/
   # Your home directory should be owned by you
   ```

2. **Try a different directory**:
   ```bash
   mkdir ~/Documents/my-business && cd ~/Documents/my-business
   git init
   # Then run installation again
   ```

3. **Don't use sudo** (unless specifically required):
   ```bash
   # Wrong - don't do this
   sudo curl -fsSL ... | bash

   # Right - run as normal user
   curl -fsSL ... | bash
   ```

---

### Issue: "Agents not appearing"

**Symptom**: After installation, typing `@` doesn't show BOS-AI agents.

**Solutions**:

1. **Restart Claude Code**:
   ```bash
   # Exit Claude Code completely
   # Open a new terminal
   cd ~/my-business
   claude code .
   ```

2. **Verify installation location**:
   ```bash
   ls -la .claude/agents/
   # Should show 30+ agent files
   ```

3. **Check you're in the right directory**:
   ```bash
   pwd
   # Should be your business directory
   cat CLAUDE.md | head -5
   # Should show BOS-AI header
   ```

4. **Verify agent file format**:
   ```bash
   cat .claude/agents/chassis-intelligence.md | head -10
   # Should show agent definition
   ```

---

### Issue: "Commands not recognized"

**Symptom**: `/coord` or other commands don't work.

**Solutions**:

1. **Check commands directory**:
   ```bash
   ls -la .claude/commands/
   # Should show coord.md, meeting.md, etc.
   ```

2. **Verify command format**:
   ```bash
   cat .claude/commands/coord.md | head -10
   # Should show command definition
   ```

3. **Use correct syntax**:
   ```
   # Correct
   /coord optimize

   # Incorrect
   /coord-optimize
   @coord optimize
   coord optimize
   ```

---

### Issue: "Network/download failures"

**Symptom**: Script fails to download files from GitHub.

**Solutions**:

1. **Check network connectivity**:
   ```bash
   curl -I https://github.com
   # Should return HTTP 200
   ```

2. **Try alternative download**:
   ```bash
   # Download manually in browser, then:
   cd ~/Downloads
   unzip BOS-AI-main.zip
   cd BOS-AI-main
   ./deployment/scripts/install.sh full ~/my-business
   ```

3. **Check for VPN/firewall issues**:
   - Temporarily disable VPN
   - Check corporate firewall settings

---

### Issue: "Git not initialized"

**Symptom**: Error about git repository.

**Solution**:
```bash
cd ~/my-business
git init
# Now run installation again
```

---

### Issue: ".claude directory already exists"

**Symptom**: Warning about overwriting existing installation.

**Solutions**:

1. **Backup and reinstall** (recommended for fresh start):
   ```bash
   mv .claude .claude-backup
   # Run installation again
   ```

2. **Keep existing and update**:
   ```bash
   # The installer should offer update option
   # Or manually update specific files
   ```

---

## Verification Commands

After installation, verify everything works:

```bash
# Check agent count (should be 30+)
ls .claude/agents/ | wc -l

# Check commands (should be 5+)
ls .claude/commands/ | wc -l

# Check CLAUDE.md exists
cat CLAUDE.md | head -3

# Check missions directory
ls missions/ | wc -l

# Test in Claude Code
claude code .
# Then type: /coord
# Should show mission menu
```

---

## Platform-Specific Issues

### macOS

**Issue**: Security warning about unsigned scripts

**Solution**:
```bash
# If macOS blocks the script:
# 1. Open System Preferences → Security & Privacy
# 2. Click "Allow Anyway" for the blocked script
# Or use this command:
xattr -d com.apple.quarantine install.sh
./install.sh full
```

### Windows (WSL)

**Issue**: Path formatting issues

**Solution**:
```bash
# Use WSL paths, not Windows paths
# Wrong: /mnt/c/Users/Name/my-business
# Right: ~/my-business
cd ~
mkdir my-business
cd my-business
git init
# Run installation
```

### Linux

**Issue**: Missing dependencies

**Solution**:
```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install git curl

# CentOS/RHEL
sudo yum install git curl
```

---

## Getting Help

If none of the above solutions work:

1. **Collect diagnostic information**:
   ```bash
   echo "=== System Info ==="
   uname -a
   echo "=== Git Version ==="
   git --version
   echo "=== Directory Contents ==="
   ls -la
   echo "=== .claude Contents ==="
   ls -la .claude/ 2>/dev/null || echo "No .claude directory"
   ```

2. **Check GitHub Issues**:
   - Visit: https://github.com/TheWayWithin/BOS-AI/issues
   - Search for your error message
   - Create new issue if not found

3. **Use `/pmd` for analysis**:
   ```
   /pmd "installation issue: [describe problem]"
   ```

---

## Related Documentation

- [FAQ](faq.md) - Frequently asked questions
- [Getting Started](../getting-started/business-guide.md) - Business operations guide
- [Directory Structure](../reference/directory-structure.md) - Understanding BOS-AI organization

---

[Back to README](../../README.md) | [FAQ](faq.md)
