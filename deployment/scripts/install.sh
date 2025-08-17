#!/bin/bash

# BOS-AI Installation Script
# Deploys the Business Operating System AI Agent Suite to your project
# Usage: curl -sSL https://raw.githubusercontent.com/TheWayWithin/BOS-AI/main/deployment/scripts/install.sh | bash -s [core|business|full]

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
    "core")
        printf "%s\n" "${YELLOW}→ Installing Core System (4 Engines + Central Intelligence)${NC}"
        INCLUDE_DIRS="agents/coordination agents/discovery agents/creation agents/delivery agents/growth"
        ;;
    "business")
        printf "%s\n" "${YELLOW}→ Installing Business System (Core + Business Functions)${NC}"
        INCLUDE_DIRS="agents/coordination agents/discovery agents/creation agents/delivery agents/growth agents/marketing agents/sales agents/customer-service"
        ;;
    "full"|*)
        printf "%s\n" "${YELLOW}→ Installing Full System (All Components)${NC}"
        INCLUDE_DIRS="agents documents missions templates frameworks"
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

# Copy all agents to .claude/agents for Claude Code
printf "  → Installing agents to .claude/agents...\n"
if [ -d "agents" ]; then
    # Copy all agent markdown files maintaining structure
    find agents -name "*.md" -type f | while read agent_file; do
        # Get just the filename without path
        filename=$(basename "$agent_file")
        # Skip README files
        if [ "$filename" != "README.md" ]; then
            cp "$agent_file" "$INSTALL_DIR/.claude/agents/$filename"
        fi
    done
    printf "  → Installed %s agents\n" "$(find agents -name "*.md" -type f | grep -v README | wc -l)"
fi

# Copy selected components to .bos-ai
for dir in $INCLUDE_DIRS; do
    if [ -d "$dir" ]; then
        printf "  → Installing %s...\n" "${dir}"
        mkdir -p "$INSTALL_DIR/.bos-ai/$(dirname $dir)"
        cp -r "$dir" "$INSTALL_DIR/.bos-ai/$(dirname $dir)/"
    fi
done

# Copy missions
if [[ "$DEPLOYMENT_TYPE" == "full" ]] || [[ "$DEPLOYMENT_TYPE" == "business" ]]; then
    printf "  → Installing mission workflows...\n"
    mkdir -p "$INSTALL_DIR/.bos-ai/missions"
    cp -r missions/* "$INSTALL_DIR/.bos-ai/missions/" 2>/dev/null || true
fi

# Copy templates for full deployment
if [[ "$DEPLOYMENT_TYPE" == "full" ]]; then
    printf "  → Installing templates...\n"
    mkdir -p "$INSTALL_DIR/.bos-ai/templates"
    cp -r templates/* "$INSTALL_DIR/.bos-ai/templates/" 2>/dev/null || true
    
    printf "  → Installing frameworks...\n"
    mkdir -p "$INSTALL_DIR/.bos-ai/frameworks"
    cp -r frameworks/* "$INSTALL_DIR/.bos-ai/frameworks/" 2>/dev/null || true
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

# Create CLAUDE.md for Claude Code integration
printf "%s\n" "${GREEN}🤖 Setting up Claude Code integration...${NC}"
cat > "$INSTALL_DIR/CLAUDE.md" << 'EOF'
# BOS-AI Agent Suite for Business Operations

This project uses the BOS-AI framework for systematic business operations.

## Available Agents

- **@chassis-intelligence** - Business Chassis optimization coordinator
- **@market-intelligence** - Market research and competitive analysis
- **@solution-design** - 10x value solution architecture
- **@customer-success** - Customer success management

## Quick Commands

- `bos-ai status` - Check Business Chassis metrics
- `bos-ai optimize` - Run chassis optimization analysis
- `bos-ai mission` - Execute business missions

## Business Focus

All operations are focused on optimizing the Business Chassis:
Prospects × Lead Conversion × Client Conversion × Average Spend × Transaction Frequency × Margin = Profit
EOF

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
echo "1. Run ./bos-ai-init.sh to initialize your Business Chassis"
echo "2. Create your Client Success Blueprint in assets/client-success-blueprint/"
echo "3. Begin tracking Business Chassis metrics in intelligence/business-chassis/"
echo ""
echo "Your AI-powered Business Operating System is ready!"
echo "Start with daily chassis optimization for exponential growth."