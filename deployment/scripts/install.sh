#!/bin/bash

# BOS-AI Installation Script
# Deploys the Business Operating System AI Agent Suite to your project
# Usage: curl -sSL https://raw.githubusercontent.com/TheWayWithin/BOS-AI/main/deployment/scripts/install.sh | bash -s [core|business|full]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
REPO_URL="https://github.com/TheWayWithin/BOS-AI.git"
TEMP_DIR="/tmp/bos-ai-install-$$"
DEPLOYMENT_TYPE="${1:-full}"

# Print banner
echo -e "${BLUE}"
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                                                              ║"
echo "║     BOS-AI: Business Operating System AI Agent Suite        ║"
echo "║     One framework. Four engines. Exponential results.       ║"
echo "║                                                              ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

echo -e "${GREEN}🚀 Starting BOS-AI deployment (${DEPLOYMENT_TYPE} configuration)...${NC}"

# Create temporary directory
echo -e "${BLUE}📁 Creating temporary installation directory...${NC}"
mkdir -p "$TEMP_DIR"
cd "$TEMP_DIR"

# Clone repository
echo -e "${BLUE}📥 Downloading BOS-AI framework...${NC}"
git clone --quiet --depth 1 "$REPO_URL" .

# Determine what to install based on deployment type
echo -e "${BLUE}🔧 Configuring deployment type: ${DEPLOYMENT_TYPE}${NC}"

case "$DEPLOYMENT_TYPE" in
    "core")
        echo -e "${YELLOW}→ Installing Core System (4 Engines + Central Intelligence)${NC}"
        INCLUDE_DIRS="agents/coordination agents/discovery agents/creation agents/delivery agents/growth"
        ;;
    "business")
        echo -e "${YELLOW}→ Installing Business System (Core + Business Functions)${NC}"
        INCLUDE_DIRS="agents/coordination agents/discovery agents/creation agents/delivery agents/growth agents/marketing agents/sales agents/customer-service"
        ;;
    "full"|*)
        echo -e "${YELLOW}→ Installing Full System (All Components)${NC}"
        INCLUDE_DIRS="agents documents missions templates frameworks"
        ;;
esac

# Get the original directory where script was called
INSTALL_DIR="$(pwd -P)"
if [ ! -z "$OLDPWD" ]; then
    INSTALL_DIR="$OLDPWD"
fi

echo -e "${BLUE}📂 Installing to: ${INSTALL_DIR}${NC}"

# Create BOS-AI directory structure
echo -e "${GREEN}🏗️  Creating BOS-AI structure...${NC}"

# Copy core documentation
cp -f README.md "$INSTALL_DIR/" 2>/dev/null || true
cp -f LICENSE "$INSTALL_DIR/" 2>/dev/null || true

# Create .bos-ai directory for agent configurations
mkdir -p "$INSTALL_DIR/.bos-ai"

# Copy selected components
for dir in $INCLUDE_DIRS; do
    if [ -d "$dir" ]; then
        echo -e "  → Installing ${dir}..."
        mkdir -p "$INSTALL_DIR/.bos-ai/$(dirname $dir)"
        cp -r "$dir" "$INSTALL_DIR/.bos-ai/$(dirname $dir)/"
    fi
done

# Copy missions
if [[ "$DEPLOYMENT_TYPE" == "full" ]] || [[ "$DEPLOYMENT_TYPE" == "business" ]]; then
    echo -e "  → Installing mission workflows..."
    mkdir -p "$INSTALL_DIR/.bos-ai/missions"
    cp -r missions/* "$INSTALL_DIR/.bos-ai/missions/" 2>/dev/null || true
fi

# Copy templates for full deployment
if [[ "$DEPLOYMENT_TYPE" == "full" ]]; then
    echo -e "  → Installing templates..."
    mkdir -p "$INSTALL_DIR/.bos-ai/templates"
    cp -r templates/* "$INSTALL_DIR/.bos-ai/templates/" 2>/dev/null || true
    
    echo -e "  → Installing frameworks..."
    mkdir -p "$INSTALL_DIR/.bos-ai/frameworks"
    cp -r frameworks/* "$INSTALL_DIR/.bos-ai/frameworks/" 2>/dev/null || true
fi

# Create project structure
echo -e "${GREEN}📚 Creating project structure...${NC}"
mkdir -p "$INSTALL_DIR/assets/business-bibles"
mkdir -p "$INSTALL_DIR/assets/client-success-blueprint"
mkdir -p "$INSTALL_DIR/assets/strategic-plans"
mkdir -p "$INSTALL_DIR/assets/reports"
mkdir -p "$INSTALL_DIR/intelligence/business-chassis"
mkdir -p "$INSTALL_DIR/intelligence/client-intelligence"
mkdir -p "$INSTALL_DIR/intelligence/market-intelligence"

# Create initial configuration
echo -e "${GREEN}⚙️  Creating initial configuration...${NC}"
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
echo -e "${GREEN}🤖 Setting up Claude Code integration...${NC}"
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
echo -e "${GREEN}📝 Creating initialization script...${NC}"
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
echo -e "${BLUE}🧹 Cleaning up installation files...${NC}"
cd "$INSTALL_DIR"
rm -rf "$TEMP_DIR"

# Success message
echo -e "${GREEN}"
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                                                              ║"
echo "║        ✅ BOS-AI Successfully Installed!                    ║"
echo "║                                                              ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

echo -e "${YELLOW}📋 Next Steps:${NC}"
echo "1. Run ${GREEN}./bos-ai-init.sh${NC} to initialize your Business Chassis"
echo "2. Create your Client Success Blueprint in ${GREEN}assets/client-success-blueprint/${NC}"
echo "3. Begin tracking Business Chassis metrics in ${GREEN}intelligence/business-chassis/${NC}"
echo ""
echo -e "${BLUE}Your AI-powered Business Operating System is ready!${NC}"
echo -e "${GREEN}Start with daily chassis optimization for exponential growth.${NC}"