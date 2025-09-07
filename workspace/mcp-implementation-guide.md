# BOS-AI MCP Implementation Guide

## Executive Summary
This guide provides actionable steps to integrate MCPs into the BOS-AI system, enhancing agent capabilities while maintaining fallback resilience.

## Quick Start (Do This First!)

### Step 1: Install Essential MCPs (5 minutes)
```bash
# Run this now to get started
claude mcp add github --scope project
claude mcp add filesystem --scope project --server "npx @modelcontextprotocol/server-filesystem /Users/jamiewatters/DevProjects/BOS-AI"

# Verify installation
claude mcp list
```

### Step 2: Create MCP Registry (2 minutes)
```bash
# Create config directory
mkdir -p /Users/jamiewatters/DevProjects/BOS-AI/workspace/config

# Create initial registry file
cat > /Users/jamiewatters/DevProjects/BOS-AI/workspace/config/mcp-registry.yaml << 'EOF'
version: "1.0"
last_updated: "2025-01-06"
registry:
  github:
    status: "connected"
    fallback: "WebFetch to api.github.com"
  filesystem:
    status: "connected"
    fallback: "Bash file operations"
EOF
```

### Step 3: Test MCP Access (1 minute)
Try these commands to verify MCPs work:
- For IDE diagnostics: Use `mcp__ide__getDiagnostics`
- For GitHub (if installed): Try accessing via prefixed commands
- Document which MCPs respond successfully

## Detailed Implementation Plan

### Phase 1: Core Infrastructure (This Week)

#### 1.1 MCP Discovery System
```bash
#!/bin/bash
# Save as: /Users/jamiewatters/DevProjects/BOS-AI/scripts/check-mcps.sh

echo "Checking available MCPs..."
claude mcp list > /Users/jamiewatters/DevProjects/BOS-AI/workspace/config/available-mcps.txt

# Parse and format for agent use
echo "# Available MCPs for BOS-AI Agents" > /Users/jamiewatters/DevProjects/BOS-AI/workspace/config/mcp-status.md
echo "Generated: $(date)" >> /Users/jamiewatters/DevProjects/BOS-AI/workspace/config/mcp-status.md
echo "" >> /Users/jamiewatters/DevProjects/BOS-AI/workspace/config/mcp-status.md
claude mcp list >> /Users/jamiewatters/DevProjects/BOS-AI/workspace/config/mcp-status.md
```

#### 1.2 Update Agent Prompts
Add this to EVERY BOS-AI agent in `/agents/` directory:

```markdown
## MCP AVAILABILITY PROTOCOL

At session start, check available MCPs:
1. Read /workspace/config/mcp-status.md if it exists
2. Note which mcp__ prefixed tools are available
3. Use MCPs when available, fallback to standard tools otherwise

Priority MCPs to check:
- mcp__github - for repository operations
- mcp__stripe - for payment analytics  
- mcp__ide - for code diagnostics
- mcp__[others] - as discovered

Fallback Protocol:
- If MCP unavailable, use: WebFetch, WebSearch, or Bash
- Document MCP usage in handoff notes for optimization
```

#### 1.3 Create Installation Scripts
```bash
# Save as: /Users/jamiewatters/DevProjects/BOS-AI/scripts/install-mcps.sh
#!/bin/bash

echo "🚀 Installing BOS-AI Essential MCPs"

# Check if running in Claude Code
if ! command -v claude &> /dev/null; then
    echo "❌ Error: Claude Code CLI not found"
    exit 1
fi

# Essential MCPs (adjust based on what's actually available)
ESSENTIAL_MCPS=(
    "github:project:stdio:npx @modelcontextprotocol/server-github"
    "filesystem:project:stdio:npx @modelcontextprotocol/server-filesystem ~/DevProjects/BOS-AI"
)

for mcp_config in "${ESSENTIAL_MCPS[@]}"; do
    IFS=':' read -r name scope transport server <<< "$mcp_config"
    echo "Installing $name..."
    
    if [ "$transport" = "stdio" ]; then
        claude mcp add "$name" --scope "$scope" --server "$server"
    else
        claude mcp add "$name" --scope "$scope" --transport "$transport" "$server"
    fi
done

echo "✅ Installation complete. Running verification..."
claude mcp list
```

### Phase 2: Agent Enhancement (Next Week)

#### 2.1 Priority Agent Updates
Update these agents first (they benefit most from MCPs):

1. **Strategist** (`/agents/creation/strategist.md`)
   - Add GitHub MCP for PRD management
   - Add market research MCPs when available

2. **Analyst** (`/agents/financial/analyst.md`)
   - Add Stripe MCP for payment analytics
   - Add data visualization MCPs

3. **Coordinator** (`/agents/coordination/coordinator.md`)
   - Add project management MCPs
   - Add communication MCPs

#### 2.2 Fallback Template
Add to each agent:

```markdown
## MCP FALLBACK MATRIX

| Required Capability | Primary MCP | Fallback Method |
|-------------------|-------------|-----------------|
| Repository access | mcp__github | Bash git commands |
| Payment data | mcp__stripe | Request CSV export |
| Web scraping | mcp__firecrawl | WebFetch specific URLs |
| Project tracking | mcp__linear | Read local project files |
| Documentation | mcp__notion | Read/Write markdown files |
```

### Phase 3: Monitoring & Optimization

#### 3.1 Usage Tracking
Create `/workspace/logs/mcp-usage.log` to track:
- Which agents use which MCPs
- Failure rates and fallback activations
- Performance metrics

#### 3.2 Weekly Review Process
Every Monday:
1. Run `./scripts/check-mcps.sh`
2. Review `/workspace/logs/mcp-usage.log`
3. Identify new MCP needs
4. Update agent prompts as needed

## Specific MCP Recommendations

### Immediate Priorities (Install Now)

1. **GitHub MCP** (if available)
   - Critical for development agents
   - Enables repository management
   - Installation: `claude mcp add github --scope project`

2. **Filesystem MCP**
   - Essential for all agents
   - Already partially available via standard tools
   - Enhances file operations

3. **IDE MCP** (already available as `mcp__ide`)
   - Use for code diagnostics
   - Helps development and debugging

### Future Additions (As Available)

1. **Stripe MCP**
   - Revenue analytics for growth agents
   - Requires API key configuration
   - High value for financial agents

2. **Slack/Discord MCP**
   - Team communication
   - Customer support channels
   - Community engagement

3. **Database MCPs**
   - PostgreSQL for metrics storage
   - Redis for caching
   - MongoDB for document storage

## Testing Protocol

### Verify MCP Integration
```bash
# Test script for MCP verification
#!/bin/bash
# Save as: /Users/jamiewatters/DevProjects/BOS-AI/scripts/test-mcps.sh

echo "Testing MCP Integration..."

# Test 1: List available MCPs
echo "Test 1: Listing MCPs"
claude mcp list

# Test 2: Check specific MCP tools
echo "Test 2: Checking IDE MCP"
# This would need to be run within Claude Code context
# where mcp__ide tools are available

# Test 3: Verify fallbacks work
echo "Test 3: Testing fallback to WebFetch"
# Simulate MCP failure and ensure WebFetch works

echo "✅ Testing complete. Check results above."
```

## Troubleshooting

### Common Issues

**Issue**: "MCP not found" errors
```bash
# Solution: Refresh MCP list
claude mcp list
# Update registry file
./scripts/check-mcps.sh
```

**Issue**: Authentication failures
```bash
# Solution: Check environment variables
env | grep -E "(GITHUB|STRIPE|API)"
# Re-add MCP with proper auth
claude mcp remove [name]
claude mcp add [name] --env "API_KEY=$YOUR_KEY"
```

**Issue**: Slow MCP responses
```bash
# Solution: Use local scope when possible
claude mcp add [name] --scope local
# Implement caching in agent logic
```

## Best Practices

### 1. Always Check Availability
```markdown
Before using any mcp__ tool:
1. Check if it appears in available tools
2. Have fallback ready
3. Log usage for monitoring
```

### 2. Graceful Degradation
```markdown
MCP Usage Pattern:
TRY: mcp__github__create_issue
CATCH: WebFetch to GitHub API  
FINALLY: Log attempt in handoff notes
```

### 3. Document Everything
```markdown
In handoff notes, always specify:
- Which MCPs were used
- Which MCPs were unavailable
- Fallback methods employed
- Recommendations for next agent
```

## Immediate Action Items

### For You (Right Now):

1. **Install GitHub MCP** (if available):
   ```bash
   claude mcp add github --scope project
   ```

2. **Create Registry File**:
   ```bash
   mkdir -p workspace/config
   echo "MCPs checked: $(date)" > workspace/config/mcp-status.md
   claude mcp list >> workspace/config/mcp-status.md
   ```

3. **Update One Agent** as pilot:
   - Choose strategist or analyst
   - Add MCP detection logic
   - Test with sample task

4. **Create Monitoring**:
   ```bash
   mkdir -p workspace/logs
   echo "MCP Usage Log Started: $(date)" > workspace/logs/mcp-usage.log
   ```

### For Next Session:

1. Review which MCPs worked
2. Identify missing MCPs needed
3. Update more agents based on pilot results
4. Research community MCPs from awesome-mcp-servers

## Success Metrics

Track these KPIs:
- **MCP Availability**: Target >90% uptime
- **Fallback Success**: Target >95% task completion
- **Agent Enhancement**: Target 50% efficiency gain
- **Error Rate**: Target <5% MCP failures

## Conclusion

MCPs will transform BOS-AI agents from good to exceptional by providing:
- Direct tool access instead of command simulation
- Real-time data instead of cached information  
- Authenticated APIs instead of public endpoints
- Structured responses instead of parsed text

Start with the basics (GitHub, Filesystem), prove the value, then expand based on actual usage patterns.

Remember: **MCPs are force multipliers, not requirements**. Every agent should work without them but excel with them.