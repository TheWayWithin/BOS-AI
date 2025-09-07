# MCP Connection & Availability Strategy for BOS-AI

## Overview
This document outlines the technical strategy for ensuring MCPs are properly connected and available for BOS-AI agents, with automatic detection, fallback mechanisms, and maintenance protocols.

## Architecture Components

### 1. MCP Registry System

#### Registry File Structure
```yaml
# Location: /workspace/config/mcp-registry.yaml
version: "1.0"
last_updated: "2025-01-06"
registry:
  github:
    name: "GitHub MCP Server"
    status: "connected"
    scope: "project"
    transport: "stdio"
    priority: 1
    capabilities:
      - repository_access
      - issue_tracking
      - pr_management
    fallback:
      primary: "WebFetch to api.github.com"
      secondary: "Manual git commands"
    required_by:
      - strategist
      - developer
      - analyst
      - coordinator
    health_check_command: "mcp__github__list-repos"
    
  stripe:
    name: "Stripe Payment Analytics"
    status: "pending"
    scope: "user"
    transport: "http"
    priority: 1
    capabilities:
      - payment_analytics
      - customer_metrics
      - revenue_tracking
    fallback:
      primary: "WebFetch to Stripe Dashboard"
      secondary: "Manual data export"
    required_by:
      - analyst
      - revenue-optimization
      - budget-planning
    health_check_command: "mcp__stripe__get-metrics"
```

### 2. MCP Health Check System

#### Automated Health Check Script
```bash
#!/bin/bash
# Location: /scripts/mcp-health-check.sh

echo "🔍 BOS-AI MCP Health Check Starting..."

# Function to check MCP availability
check_mcp() {
    local mcp_name=$1
    local test_command=$2
    
    echo -n "Checking $mcp_name... "
    
    # Try to execute a simple MCP command
    if claude mcp test "$mcp_name" 2>/dev/null; then
        echo "✅ Connected"
        return 0
    else
        echo "❌ Unavailable"
        return 1
    fi
}

# Check each critical MCP
MCPS_TO_CHECK=(
    "github:mcp__github"
    "stripe:mcp__stripe"
    "firecrawl:mcp__firecrawl"
    "notion:mcp__notion"
    "linear:mcp__linear"
)

FAILED_MCPS=()

for mcp_entry in "${MCPS_TO_CHECK[@]}"; do
    IFS=':' read -r name command <<< "$mcp_entry"
    if ! check_mcp "$name" "$command"; then
        FAILED_MCPS+=("$name")
    fi
done

# Update registry with results
if [ ${#FAILED_MCPS[@]} -eq 0 ]; then
    echo "✅ All MCPs operational"
else
    echo "⚠️ Failed MCPs: ${FAILED_MCPS[*]}"
    echo "Updating registry with fallback status..."
fi

# Generate status report
date > /workspace/config/mcp-status.txt
claude mcp list >> /workspace/config/mcp-status.txt
```

### 3. Agent MCP Detection Protocol

#### Enhanced Agent Initialization
Every BOS-AI agent should include this initialization sequence:

```markdown
## MCP INITIALIZATION PROTOCOL

Before executing any task:

1. **Check MCP Availability**
   ```bash
   # Read MCP registry
   if [ -f /workspace/config/mcp-registry.yaml ]; then
       AVAILABLE_MCPS=$(cat /workspace/config/mcp-registry.yaml)
   fi
   ```

2. **Verify Required MCPs**
   - Check if mcp__github is available for code operations
   - Check if mcp__stripe is available for revenue analytics
   - Check if mcp__firecrawl is available for market research

3. **Implement Fallback Logic**
   ```
   IF mcp__github unavailable:
       USE WebFetch("https://api.github.com/...")
   IF mcp__stripe unavailable:
       REQUEST manual data: "Please provide Stripe metrics"
   IF mcp__firecrawl unavailable:
       USE WebSearch for market data
   ```

4. **Log MCP Usage**
   - Document which MCPs were used
   - Note any fallbacks activated
   - Update /workspace/mcp-usage-log.md
```

### 4. MCP Installation Automation

#### Master Installation Script
```bash
#!/bin/bash
# Location: /scripts/install-bos-ai-mcps.sh

echo "🚀 BOS-AI MCP Installation Script"
echo "=================================="

# Configuration
MCP_CONFIG_DIR="/workspace/config"
LOG_FILE="$MCP_CONFIG_DIR/mcp-install.log"

# Create config directory if not exists
mkdir -p "$MCP_CONFIG_DIR"

# Function to install MCP with error handling
install_mcp() {
    local name=$1
    local scope=$2
    local transport=$3
    local config=$4
    
    echo "Installing $name..."
    
    if [ "$transport" = "stdio" ]; then
        claude mcp add "$name" --scope "$scope" --server "$config" 2>&1 | tee -a "$LOG_FILE"
    elif [ "$transport" = "http" ]; then
        claude mcp add "$name" --scope "$scope" --transport http "$config" 2>&1 | tee -a "$LOG_FILE"
    fi
    
    if [ $? -eq 0 ]; then
        echo "✅ $name installed successfully"
        return 0
    else
        echo "❌ Failed to install $name"
        return 1
    fi
}

# Tier 1: Essential MCPs
echo ""
echo "📦 Installing Tier 1 (Essential) MCPs..."
echo "----------------------------------------"

install_mcp "github" "project" "stdio" "npx @modelcontextprotocol/server-github"
install_mcp "filesystem" "project" "stdio" "npx @modelcontextprotocol/server-filesystem /workspace"
install_mcp "postgres" "project" "stdio" "npx @modelcontextprotocol/server-postgres postgresql://localhost/bosai"

# Tier 2: High Value MCPs (if available)
echo ""
echo "📦 Installing Tier 2 (High Value) MCPs..."
echo "----------------------------------------"

# Check for Stripe credentials
if [ -n "$STRIPE_API_KEY" ]; then
    install_mcp "stripe" "user" "http" "https://mcp-stripe.example.com"
else
    echo "⚠️ Stripe API key not found, skipping..."
fi

# Install from npm if available
npm list -g @modelcontextprotocol/server-slack &>/dev/null
if [ $? -eq 0 ]; then
    install_mcp "slack" "project" "stdio" "npx @modelcontextprotocol/server-slack"
fi

# Generate installation report
echo ""
echo "📊 Installation Summary"
echo "----------------------"
claude mcp list

# Update registry
echo ""
echo "📝 Updating MCP Registry..."
./scripts/update-mcp-registry.sh

echo ""
echo "✅ BOS-AI MCP Installation Complete!"
echo "Run './scripts/mcp-health-check.sh' to verify all connections"
```

### 5. Runtime MCP Discovery

#### Dynamic MCP Detection for Agents
```javascript
// Location: /workspace/utils/mcp-detector.js

const fs = require('fs');
const { exec } = require('child_process');
const yaml = require('js-yaml');

class MCPDetector {
    constructor() {
        this.registryPath = '/workspace/config/mcp-registry.yaml';
        this.availableMCPs = new Map();
    }
    
    async initialize() {
        // Load registry
        try {
            const registryContent = fs.readFileSync(this.registryPath, 'utf8');
            const registry = yaml.load(registryContent);
            
            // Check each MCP's actual availability
            for (const [mcpId, config] of Object.entries(registry.registry)) {
                const isAvailable = await this.checkMCPAvailability(mcpId);
                this.availableMCPs.set(mcpId, {
                    ...config,
                    available: isAvailable
                });
            }
        } catch (error) {
            console.error('Failed to load MCP registry:', error);
        }
    }
    
    async checkMCPAvailability(mcpId) {
        return new Promise((resolve) => {
            exec(`claude mcp test ${mcpId}`, (error, stdout, stderr) => {
                resolve(!error);
            });
        });
    }
    
    getMCPForCapability(capability) {
        for (const [mcpId, config] of this.availableMCPs) {
            if (config.available && config.capabilities.includes(capability)) {
                return mcpId;
            }
        }
        return null;
    }
    
    getFallback(mcpId) {
        const config = this.availableMCPs.get(mcpId);
        return config ? config.fallback : null;
    }
}

module.exports = MCPDetector;
```

### 6. Fallback Mechanism Implementation

#### Intelligent Fallback System
```markdown
## FALLBACK PROTOCOL FOR AGENTS

When an MCP is unavailable, use this decision tree:

### For Data MCPs (Stripe, Analytics, etc.)
```
IF mcp__stripe unavailable:
  TRY WebFetch("https://dashboard.stripe.com/api/...")
  ELSE REQUEST "Please export Stripe data CSV and place in /workspace/data/"
  ELSE USE cached data from /workspace/cache/stripe/
```

### For Communication MCPs (Slack, Email, etc.)
```
IF mcp__slack unavailable:
  TRY WebFetch to Slack Web API
  ELSE USE Bash to send webhook notifications
  ELSE LOG message to /workspace/communications/pending/
```

### For Development MCPs (GitHub, Linear, etc.)
```
IF mcp__github unavailable:
  TRY Git commands via Bash
  ELSE USE WebFetch to GitHub API with token
  ELSE REQUEST manual repository information
```

### For Research MCPs (Firecrawl, Context7, etc.)
```
IF mcp__firecrawl unavailable:
  USE WebSearch with specific queries
  ELSE USE WebFetch with target URLs
  ELSE REQUEST manual market research data
```
```

### 7. MCP Connection Monitoring

#### Monitoring Dashboard
```markdown
# Location: /workspace/dashboards/mcp-status.md

# MCP Connection Status Dashboard

Last Updated: [AUTO-UPDATED]

## Connection Status
| MCP | Status | Last Check | Uptime | Usage Count |
|-----|--------|------------|--------|-------------|
| GitHub | 🟢 Connected | 2025-01-06 14:30 | 99.9% | 1,234 |
| Stripe | 🔴 Disconnected | 2025-01-06 14:30 | 0% | 0 |
| Firecrawl | 🟢 Connected | 2025-01-06 14:30 | 98.5% | 567 |
| Linear | 🟡 Degraded | 2025-01-06 14:30 | 75% | 234 |
| Notion | 🟢 Connected | 2025-01-06 14:30 | 99% | 890 |

## Fallback Activations (Last 24h)
- Stripe → WebFetch: 15 times
- GitHub → Git CLI: 3 times
- Firecrawl → WebSearch: 8 times

## Recommendations
- ⚠️ Stripe MCP needs authentication renewal
- ℹ️ Linear MCP showing intermittent timeouts
- ✅ Consider upgrading Notion MCP to v2.0
```

### 8. Agent Prompt Enhancement

#### Updated Agent Instructions
Add to all BOS-AI agent prompts:

```markdown
## MCP USAGE INSTRUCTIONS

1. **Start Every Session:**
   - Run: `cat /workspace/config/mcp-status.txt`
   - Check which MCPs are available
   - Note fallback options

2. **When Using MCPs:**
   - Always try MCP first: `mcp__[service]__[action]`
   - If error, immediately switch to fallback
   - Log MCP failures to `/workspace/logs/mcp-failures.log`

3. **Fallback Priority:**
   - Level 1: Alternative MCP (if available)
   - Level 2: Web API via WebFetch
   - Level 3: Manual data request from user
   - Level 4: Cached/historical data

4. **Report Issues:**
   - Document failed MCPs in handoff notes
   - Suggest MCP additions if gaps identified
   - Track usage patterns for optimization
```

## Implementation Roadmap

### Phase 1: Foundation (Week 1)
- [ ] Create MCP registry system
- [ ] Deploy health check scripts
- [ ] Install Tier 1 MCPs
- [ ] Update agent prompts

### Phase 2: Automation (Week 2)
- [ ] Implement auto-discovery
- [ ] Build fallback system
- [ ] Create monitoring dashboard
- [ ] Test with pilot agents

### Phase 3: Optimization (Week 3-4)
- [ ] Analyze usage patterns
- [ ] Add Tier 2 MCPs
- [ ] Optimize connection pooling
- [ ] Document best practices

### Phase 4: Scaling (Month 2)
- [ ] Custom MCP development
- [ ] Performance optimization
- [ ] Advanced fallback strategies
- [ ] Full agent rollout

## Success Metrics

1. **Availability**: >95% uptime for Tier 1 MCPs
2. **Fallback Success**: >90% task completion even with MCP failures
3. **Performance**: <2s MCP connection time
4. **Coverage**: 100% of agents have MCP detection
5. **Usage**: >75% of eligible operations use MCPs

## Troubleshooting Guide

### Common Issues & Solutions

**Issue**: MCP not found by agent
**Solution**: Run `claude mcp list` and update registry

**Issue**: Authentication failures
**Solution**: Check environment variables, renew tokens

**Issue**: Slow MCP responses
**Solution**: Implement caching layer, use connection pooling

**Issue**: Fallback not working
**Solution**: Verify fallback URLs, check API keys

## Conclusion

This comprehensive MCP connection strategy ensures BOS-AI agents can:
1. Automatically detect available MCPs
2. Gracefully handle MCP failures
3. Use intelligent fallbacks
4. Maintain high availability
5. Optimize for performance

The system is designed to be resilient, self-healing, and continuously improving based on usage patterns.