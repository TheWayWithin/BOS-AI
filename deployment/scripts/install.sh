#!/bin/bash

# BOS-AI Installation Script
# Deploys the Business Operating System AI Agent Suite to your project
# Usage: curl -sSL https://raw.githubusercontent.com/TheWayWithin/BOS-AI/main/deployment/scripts/install.sh | bash -s [minimal|business|full]

set -e

# Colors for output - check if terminal supports colors
if [ -t 1 ] && command -v tput >/dev/null 2>&1; then
    # Terminal supports colors
    RED=$(tput setaf 1)
    GREEN=$(tput setaf 2)
    BLUE=$(tput setaf 4)
    YELLOW=$(tput setaf 3)
    NC=$(tput sgr0) # No Color
else
    # No color support or not in terminal
    RED=''
    GREEN=''
    BLUE=''
    YELLOW=''
    NC=''
fi

# Configuration
REPO_URL="https://github.com/TheWayWithin/BOS-AI.git"
TEMP_DIR="/tmp/bos-ai-install-$$"
DEPLOYMENT_TYPE="${1:-full}"

# Print banner
printf "%s\n" "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
printf "%s\n" "${BLUE}║                                                              ║${NC}"
printf "%s\n" "${BLUE}║     BOS-AI: Business Operating System AI Agent Suite        ║${NC}"
printf "%s\n" "${BLUE}║     One framework. Four engines. Exponential results.       ║${NC}"
printf "%s\n" "${BLUE}║                                                              ║${NC}"
printf "%s\n" "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""

printf "%s\n" "${GREEN}🚀 Starting BOS-AI deployment (${DEPLOYMENT_TYPE} configuration)...${NC}"

# Create temporary directory
printf "%s\n" "${BLUE}📁 Creating temporary installation directory...${NC}"
mkdir -p "$TEMP_DIR"
cd "$TEMP_DIR"

# Clone repository
printf "%s\n" "${BLUE}📥 Downloading BOS-AI framework...${NC}"
git clone --quiet --depth 1 "$REPO_URL" .

# Determine what to install based on deployment type
printf "%s\n" "${BLUE}🔧 Configuring deployment type: ${DEPLOYMENT_TYPE}${NC}"

case "$DEPLOYMENT_TYPE" in
    "minimal")
        printf "%s\n" "${YELLOW}→ Installing Minimal System (5 Core Agents)${NC}"
        AGENT_COUNT="5"
        AGENT_LIST="chassis-intelligence market-intelligence customer-success revenue-optimization solution-design"
        ;;
    "business")
        printf "%s\n" "${YELLOW}→ Installing Business System (15 Business-Critical Agents)${NC}"
        AGENT_COUNT="15"
        AGENT_LIST="chassis-intelligence client-success-intelligence multiplication-engine market-intelligence customer-success revenue-optimization solution-design brand-strategy campaign-execution pipeline-management conversion-optimization support-management satisfaction-optimization budget-planning performance-analysis"
        ;;
    "full"|*)
        printf "%s\n" "${YELLOW}→ Installing Full System (All 29 Agents + Complete Framework)${NC}"
        AGENT_COUNT="29"
        AGENT_LIST="ALL"
        ;;
esac

# Get the original directory where script was called
INSTALL_DIR="$(pwd -P)"
if [ ! -z "$OLDPWD" ]; then
    INSTALL_DIR="$OLDPWD"
fi

printf "%s\n" "${BLUE}📂 Installing to: ${INSTALL_DIR}${NC}"

# Create BOS-AI directory structure
printf "%s\n" "${GREEN}🏗️  Creating BOS-AI structure...${NC}"

# Copy core documentation
cp -f README.md "$INSTALL_DIR/" 2>/dev/null || true
cp -f LICENSE "$INSTALL_DIR/" 2>/dev/null || true

# Create .bos-ai directory for agent configurations
mkdir -p "$INSTALL_DIR/.bos-ai"

# Create .claude directory for Claude Code integration
mkdir -p "$INSTALL_DIR/.claude/agents"

# Copy agents to .claude/agents for Claude Code
printf "  → Installing agents to .claude/agents...\n"
if [ -d ".claude/agents" ]; then
    if [ "$AGENT_LIST" = "ALL" ]; then
        # Copy all agent files for full deployment
        cp .claude/agents/*.md "$INSTALL_DIR/.claude/agents/" 2>/dev/null || true
        printf "  → Installed all 29 agents\n"
    else
        # Copy specific agents for minimal/business deployment
        for agent in $AGENT_LIST; do
            if [ -f ".claude/agents/${agent}.md" ]; then
                cp ".claude/agents/${agent}.md" "$INSTALL_DIR/.claude/agents/"
            fi
        done
        printf "  → Installed %s agents\n" "$AGENT_COUNT"
    fi
    
    # Always copy README for agent documentation
    cp .claude/agents/README.md "$INSTALL_DIR/.claude/agents/" 2>/dev/null || true
fi

# Copy missions to .claude/missions for all deployment types
printf "  → Installing mission workflows...\n"
mkdir -p "$INSTALL_DIR/.claude/missions"
if [ -d ".claude/missions" ]; then
    cp -r .claude/missions/* "$INSTALL_DIR/.claude/missions/" 2>/dev/null || true
fi

# Copy additional resources for business and full deployments
if [[ "$DEPLOYMENT_TYPE" == "business" ]] || [[ "$DEPLOYMENT_TYPE" == "full" ]]; then
    printf "  → Installing business templates...\n"
    mkdir -p "$INSTALL_DIR/.bos-ai/templates"
    if [ -d "templates" ]; then
        cp -r templates/* "$INSTALL_DIR/.bos-ai/templates/" 2>/dev/null || true
    fi
fi

# Copy frameworks for full deployment only
if [[ "$DEPLOYMENT_TYPE" == "full" ]]; then
    printf "  → Installing complete framework documentation...\n"
    mkdir -p "$INSTALL_DIR/.bos-ai/frameworks"
    if [ -d "frameworks" ]; then
        cp -r frameworks/* "$INSTALL_DIR/.bos-ai/frameworks/" 2>/dev/null || true
    fi
    
    mkdir -p "$INSTALL_DIR/.bos-ai/documents"
    if [ -d "documents" ]; then
        cp -r documents/* "$INSTALL_DIR/.bos-ai/documents/" 2>/dev/null || true
    fi
fi

# Create project structure
printf "%s\n" "${GREEN}📚 Creating project structure...${NC}"
mkdir -p "$INSTALL_DIR/assets/business-bibles"
mkdir -p "$INSTALL_DIR/assets/client-success-blueprint"
mkdir -p "$INSTALL_DIR/assets/strategic-plans"
mkdir -p "$INSTALL_DIR/assets/reports"
mkdir -p "$INSTALL_DIR/intelligence/business-chassis"
mkdir -p "$INSTALL_DIR/intelligence/client-intelligence"
mkdir -p "$INSTALL_DIR/intelligence/market-intelligence"

# Create initial configuration
printf "%s\n" "${GREEN}⚙️  Creating initial configuration...${NC}"
cat > "$INSTALL_DIR/.bos-ai/config.json" << EOF
{
  "version": "1.0.0",
  "deployment_type": "${DEPLOYMENT_TYPE}",
  "business_name": "$(basename "$INSTALL_DIR")",
  "installed_date": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "engines": {
    "discovery": true,
    "creation": true,
    "delivery": true,
    "growth": true
  },
  "business_chassis": {
    "prospects": 0,
    "lead_conversion": 0,
    "client_conversion": 0,
    "average_spend": 0,
    "transaction_frequency": 0,
    "margin": 0
  }
}
EOF

# Copy CLAUDE.md for command system
printf "%s\n" "${GREEN}🤖 Setting up Claude Code command system...${NC}"
if [ -f ".claude/CLAUDE.md" ]; then
    cp ".claude/CLAUDE.md" "$INSTALL_DIR/.claude/CLAUDE.md"
else
    # Create basic CLAUDE.md if not found in repo
    cat > "$INSTALL_DIR/.claude/CLAUDE.md" << 'EOF'
# BOS-AI Command System

## 🎯 Quick Commands

### /coord - Business Orchestration
When you type `/coord`, I become your Business Chassis Intelligence coordinator. Use:
- `/coord` - Interactive mission selection
- `/coord optimize` - Optimize Business Chassis metrics
- `/coord daily` - Daily business review
- `/coord launch [product]` - Product launch coordination

### /meeting - Agent Consultation
Direct conversations with specialized agents:
- `/meeting @revenue-optimization "pricing strategy"`
- `/meeting @customer-success "onboarding process"`
- `/meeting @brand-strategy "marketing campaign"`

## 📊 Business Chassis Formula
Prospects × Lead Conversion × Client Conversion × Average Spend × Transaction Frequency × Margin = Profit

10% improvement in each = 77% profit increase!
EOF
fi

# Create initialization script
printf "%s\n" "${GREEN}📝 Creating initialization script...${NC}"
cat > "$INSTALL_DIR/bos-ai-init.sh" << 'EOF'
#!/bin/bash
# BOS-AI Initialization Script

echo "🚀 Initializing BOS-AI for your business..."
echo ""
echo "Business Chassis Components:"
echo "1. Prospects - Your market reach"
echo "2. Lead Conversion - Interest to lead rate"
echo "3. Client Conversion - Lead to client rate"
echo "4. Average Spend - Revenue per transaction"
echo "5. Transaction Frequency - Purchases per period"
echo "6. Margin - Profit percentage"
echo ""
echo "Remember: 10% improvement in each = 77% profit increase!"
echo ""
echo "Run 'bos-ai help' for available commands"
EOF
chmod +x "$INSTALL_DIR/bos-ai-init.sh"

# Clean up
printf "%s\n" "${BLUE}🧹 Cleaning up installation files...${NC}"
cd "$INSTALL_DIR"
rm -rf "$TEMP_DIR"

# Success message
printf "%s\n" "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
printf "%s\n" "${GREEN}║                                                              ║${NC}"
printf "%s\n" "${GREEN}║        ✅ BOS-AI Successfully Installed!                    ║${NC}"
printf "%s\n" "${GREEN}║                                                              ║${NC}"
printf "%s\n" "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"

echo ""
echo "📋 Next Steps:"
echo "1. Open Claude Code in this directory"
echo "2. Type /coord to start business orchestration"
echo "3. Or use @chassis-intelligence directly"
echo ""
printf "%s\n" "${BLUE}Available Commands:${NC}"
echo "  /coord         - Business orchestration mode"
echo "  /meeting       - Consult with specific agents"
echo "  @agent-name    - Direct agent interaction"
echo ""
echo "Your AI-powered Business Operating System is ready!"
echo "Start optimizing your Business Chassis for exponential growth!"