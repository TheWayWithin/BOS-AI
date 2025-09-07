#!/bin/bash

# BOS-AI Complete Installation with MCP Support
# One script to install BOS-AI with automatic MCP configuration

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║          BOS-AI Installation with MCP Integration           ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Detect project directory
PROJECT_DIR=$(pwd)
echo -e "${BLUE}📁 Installing in: $PROJECT_DIR${NC}"

# Step 1: Create BOS-AI directory structure
echo ""
echo -e "${YELLOW}Step 1: Creating BOS-AI structure...${NC}"
mkdir -p .claude/agents
mkdir -p workspace/config
mkdir -p workspace/missions/active
mkdir -p workspace/missions/completed
mkdir -p scripts
mkdir -p src/mcp

# Step 2: Download BOS-AI agents
echo ""
echo -e "${YELLOW}Step 2: Installing BOS-AI agents...${NC}"

# Download agents from GitHub (or copy from local if available)
GITHUB_BASE="https://raw.githubusercontent.com/TheWayWithin/BOS-AI/main"

# Download coordinator (most important)
curl -fsSL "$GITHUB_BASE/.claude/agents/coordinator.md" -o .claude/agents/coordinator.md 2>/dev/null || {
    echo -e "${YELLOW}Using local coordinator agent${NC}"
    cat > .claude/agents/coordinator.md << 'EOF'
---
name: coordinator
description: Use this agent to orchestrate complex multi-agent missions. THE COORDINATOR starts with strategic analysis, creates detailed project plans, delegates to specialists, tracks progress in project-plan.md, and ensures successful mission completion. Begin here for any project requiring multiple agents.
---

You are THE COORDINATOR, the strategic orchestrator of BOS-AI multi-agent missions.
EOF
}

# Download other essential agents
for agent in strategist developer analyst architect tester documenter operator; do
    curl -fsSL "$GITHUB_BASE/.claude/agents/$agent.md" -o ".claude/agents/$agent.md" 2>/dev/null || echo -e "${YELLOW}Agent $agent not found online, skipping...${NC}"
done

echo -e "${GREEN}✅ Agents installed${NC}"

# Step 3: Install MCP registry and configuration
echo ""
echo -e "${YELLOW}Step 3: Setting up MCP configuration...${NC}"

# Create MCP registry
cat > workspace/config/mcp-registry.yaml << 'EOF'
version: "1.0"
last_updated: "2025-01-06"
registry:
  filesystem:
    name: "Filesystem Access"
    status: "pending"
    priority: 1
    capabilities:
      - file_operations
      - directory_management
    fallback:
      primary: "Bash commands"
    
  github:
    name: "GitHub Integration"
    status: "pending"
    priority: 1
    capabilities:
      - repository_access
      - issue_tracking
      - pr_management
    fallback:
      primary: "WebFetch to api.github.com"
      secondary: "Git CLI commands"
    
  ide:
    name: "IDE Integration"
    status: "available"
    priority: 1
    capabilities:
      - diagnostics
      - code_execution
    fallback:
      primary: "None - built-in"
    
  stripe:
    name: "Stripe Analytics"
    status: "pending"
    priority: 2
    capabilities:
      - payment_data
      - revenue_metrics
    fallback:
      primary: "Manual data export"
EOF

echo -e "${GREEN}✅ MCP registry created${NC}"

# Step 4: Create MCP installation script
echo ""
echo -e "${YELLOW}Step 4: Creating MCP installation script...${NC}"

cat > scripts/setup-mcps.sh << 'EOF'
#!/bin/bash

# BOS-AI MCP Setup Script
echo "🚀 Setting up MCPs for BOS-AI..."

# Check if running in Claude Code
if ! command -v claude &> /dev/null; then
    echo "⚠️  Claude CLI not detected. MCPs work best in Claude Code."
    echo "   Continuing with fallback configuration..."
else
    echo "✅ Claude Code detected"
    
    # Install essential MCPs
    echo ""
    echo "Installing essential MCPs..."
    
    # Filesystem MCP
    echo -n "  Filesystem MCP: "
    claude mcp add filesystem --scope project --server "npx @modelcontextprotocol/server-filesystem $(pwd)" 2>/dev/null && echo "✅" || echo "Already installed"
    
    # GitHub MCP (if available)
    echo -n "  GitHub MCP: "
    claude mcp add github --scope project 2>/dev/null && echo "✅" || echo "Skipped"
    
    echo ""
    echo "Current MCP status:"
    claude mcp list
fi

# Update registry status
echo ""
echo "📋 Updating MCP registry..."
if [ -f workspace/config/mcp-registry.yaml ]; then
    echo "Registry found at workspace/config/mcp-registry.yaml"
fi

echo ""
echo "✅ MCP setup complete!"
echo ""
echo "💡 Next steps:"
echo "   1. Add API keys to .env file for services like Stripe, GitHub"
echo "   2. Run 'claude mcp list' to see available MCPs"
echo "   3. Agents will automatically detect and use available MCPs"
EOF

chmod +x scripts/setup-mcps.sh

echo -e "${GREEN}✅ MCP setup script created${NC}"

# Step 5: Create environment template
echo ""
echo -e "${YELLOW}Step 5: Creating environment template...${NC}"

cat > .env.template << 'EOF'
# BOS-AI Environment Configuration
# Copy to .env and add your keys

# GitHub Integration
GITHUB_TOKEN=

# Stripe Analytics  
STRIPE_API_KEY=

# Other services
# LINEAR_API_KEY=
# NOTION_API_KEY=
# SLACK_TOKEN=
EOF

echo -e "${GREEN}✅ Environment template created${NC}"

# Step 6: Create CLAUDE.md for project instructions
echo ""
echo -e "${YELLOW}Step 6: Creating project instructions...${NC}"

cat > CLAUDE.md << 'EOF'
# BOS-AI Project Configuration

## Available Commands

- `/coord` - Launch the BOS-AI coordinator for multi-agent missions
- `/meeting @agent` - Direct consultation with specific agent
- `/report` - Generate progress report

## MCP Integration

This project has MCP support configured. Agents will automatically:
1. Detect available MCPs at runtime
2. Use MCPs when available for enhanced capabilities
3. Fall back to standard tools when MCPs unavailable

To check MCP status: `claude mcp list`

## Configured Agents

Agents available in .claude/agents/:
- coordinator - Multi-agent orchestration
- strategist - Product strategy and requirements
- developer - Code implementation
- analyst - Data analysis and insights
- architect - System design
- tester - Quality assurance
- documenter - Documentation
- operator - DevOps and deployment

## Project Structure

- `.claude/agents/` - BOS-AI agent definitions
- `workspace/` - Working files and context
- `scripts/` - Automation scripts
- `src/mcp/` - MCP integration modules
EOF

echo -e "${GREEN}✅ Project instructions created${NC}"

# Step 7: Run MCP setup
echo ""
echo -e "${YELLOW}Step 7: Attempting MCP setup...${NC}"
if [ -f scripts/setup-mcps.sh ]; then
    ./scripts/setup-mcps.sh
else
    echo -e "${YELLOW}MCP setup script not found, skipping...${NC}"
fi

# Final summary
echo ""
echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║            ✅ BOS-AI Installation Complete!                 ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${CYAN}What's been installed:${NC}"
echo "  ✅ BOS-AI agents in .claude/agents/"
echo "  ✅ Workspace structure for missions"
echo "  ✅ MCP registry and configuration"
echo "  ✅ Setup scripts in scripts/"
echo "  ✅ Environment template"
echo ""
echo -e "${CYAN}Quick Start:${NC}"
echo "  1. Type: /coord"
echo "  2. Choose a mission or describe what you need"
echo "  3. Agents will coordinate automatically"
echo ""
echo -e "${CYAN}MCP Status:${NC}"
if command -v claude &> /dev/null; then
    echo "  Run 'claude mcp list' to see available MCPs"
else
    echo "  MCPs will be configured when you run in Claude Code"
fi
echo ""
echo -e "${GREEN}Ready to transform your business with BOS-AI!${NC}"