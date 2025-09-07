#!/bin/bash

# BOS-AI MCP System Deployment Script
# Deploys the MCP automation system to a business project

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}       BOS-AI MCP System Deployment Tool                       ${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo ""

# Source directory (BOS-AI development)
SOURCE_DIR="/Users/jamiewatters/DevProjects/BOS-AI"

# Check if source exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo -e "${RED}❌ Error: BOS-AI development directory not found at $SOURCE_DIR${NC}"
    exit 1
fi

# Get target project
if [ -z "$1" ]; then
    echo -e "${YELLOW}Usage: $0 <target-project-path>${NC}"
    echo ""
    echo "Available business projects:"
    echo "  1. /Users/jamiewatters/BusinessProjects/ai-search-mastery-business"
    echo "  2. /Users/jamiewatters/BusinessProjects/SoloMarket"
    echo "  3. /Users/jamiewatters/BusinessProjects/Evolve-7 Business"
    echo ""
    echo -e "${GREEN}Example:${NC}"
    echo "  $0 /Users/jamiewatters/BusinessProjects/ai-search-mastery-business"
    exit 1
fi

TARGET_DIR="$1"

# Check if target exists
if [ ! -d "$TARGET_DIR" ]; then
    echo -e "${RED}❌ Error: Target directory not found: $TARGET_DIR${NC}"
    exit 1
fi

echo -e "${GREEN}📦 Deploying MCP system to: $TARGET_DIR${NC}"
echo ""

# Create necessary directories
echo -e "${BLUE}Creating directories...${NC}"
mkdir -p "$TARGET_DIR/src/mcp"
mkdir -p "$TARGET_DIR/scripts"
mkdir -p "$TARGET_DIR/workspace/config"

# Copy MCP core files
echo -e "${BLUE}Copying MCP core system...${NC}"
if [ -d "$SOURCE_DIR/src/mcp" ]; then
    cp -r "$SOURCE_DIR/src/mcp/"* "$TARGET_DIR/src/mcp/" 2>/dev/null || true
    echo -e "${GREEN}✅ Core MCP modules copied${NC}"
else
    echo -e "${YELLOW}⚠️  MCP source modules not found, skipping...${NC}"
fi

# Copy installation scripts
echo -e "${BLUE}Copying installation scripts...${NC}"
if [ -f "$SOURCE_DIR/scripts/install-bos-ai-mcps.sh" ]; then
    cp "$SOURCE_DIR/scripts/install-bos-ai-mcps.sh" "$TARGET_DIR/scripts/"
    chmod +x "$TARGET_DIR/scripts/install-bos-ai-mcps.sh"
    echo -e "${GREEN}✅ Installation script copied${NC}"
else
    # Create a basic installation script
    cat > "$TARGET_DIR/scripts/install-bos-ai-mcps.sh" << 'EOF'
#!/bin/bash

# BOS-AI MCP Installation Script
echo "🚀 Installing BOS-AI MCPs..."

# Check for Claude Code CLI
if ! command -v claude &> /dev/null; then
    echo "❌ Claude Code CLI not found. Please ensure you're running this in Claude Code."
    exit 1
fi

# Install essential MCPs
echo "📦 Installing GitHub MCP..."
claude mcp add github --scope project 2>/dev/null || echo "GitHub MCP may already be installed"

echo "📦 Installing Filesystem MCP..."
claude mcp add filesystem --scope project --server "npx @modelcontextprotocol/server-filesystem $(pwd)" 2>/dev/null || echo "Filesystem MCP may already be installed"

# List current MCPs
echo ""
echo "📋 Current MCP Status:"
claude mcp list

echo ""
echo "✅ MCP installation complete!"
echo "💡 To add API keys for services like Stripe, GitHub, etc.:"
echo "   1. Copy .env.mcp-template to .env"
echo "   2. Add your API keys"
echo "   3. Re-run this script"
EOF
    chmod +x "$TARGET_DIR/scripts/install-bos-ai-mcps.sh"
    echo -e "${GREEN}✅ Basic installation script created${NC}"
fi

# Copy status check script
if [ -f "$SOURCE_DIR/scripts/check-mcp-status.sh" ]; then
    cp "$SOURCE_DIR/scripts/check-mcp-status.sh" "$TARGET_DIR/scripts/"
    chmod +x "$TARGET_DIR/scripts/check-mcp-status.sh"
    echo -e "${GREEN}✅ Status check script copied${NC}"
else
    # Create a basic status script
    cat > "$TARGET_DIR/scripts/check-mcp-status.sh" << 'EOF'
#!/bin/bash

# MCP Status Check
echo "🔍 BOS-AI MCP Status Check"
echo "=========================="
echo ""

# Check Claude Code CLI
if command -v claude &> /dev/null; then
    echo "✅ Claude Code CLI found"
    echo ""
    echo "📋 Configured MCPs:"
    claude mcp list
else
    echo "❌ Claude Code CLI not found"
    echo "   Please run this in Claude Code environment"
fi

echo ""
echo "💡 To install MCPs, run: ./scripts/install-bos-ai-mcps.sh"
EOF
    chmod +x "$TARGET_DIR/scripts/check-mcp-status.sh"
    echo -e "${GREEN}✅ Basic status script created${NC}"
fi

# Copy MCP registry
echo -e "${BLUE}Copying MCP registry...${NC}"
if [ -f "$SOURCE_DIR/workspace/config/mcp-registry.yaml" ]; then
    cp "$SOURCE_DIR/workspace/config/mcp-registry.yaml" "$TARGET_DIR/workspace/config/"
    echo -e "${GREEN}✅ MCP registry copied${NC}"
else
    # Create a basic registry
    cat > "$TARGET_DIR/workspace/config/mcp-registry.yaml" << 'EOF'
version: "1.0"
last_updated: "2025-01-06"
registry:
  github:
    status: "pending"
    fallback: "WebFetch to api.github.com"
  filesystem:
    status: "pending"
    fallback: "Bash file operations"
  ide:
    status: "available"
    fallback: "none"
EOF
    echo -e "${GREEN}✅ Basic MCP registry created${NC}"
fi

# Copy environment template
if [ -f "$SOURCE_DIR/.env.mcp-template" ]; then
    cp "$SOURCE_DIR/.env.mcp-template" "$TARGET_DIR/"
    echo -e "${GREEN}✅ Environment template copied${NC}"
else
    # Create basic env template
    cat > "$TARGET_DIR/.env.mcp-template" << 'EOF'
# BOS-AI MCP Configuration
# Copy this file to .env and add your API keys

# GitHub (for repository access)
GITHUB_TOKEN=your_github_personal_access_token

# Stripe (for payment analytics)
STRIPE_API_KEY=your_stripe_api_key

# Other services as needed
# LINEAR_API_KEY=your_linear_api_key
# NOTION_API_KEY=your_notion_api_key
EOF
    echo -e "${GREEN}✅ Basic environment template created${NC}"
fi

echo ""
echo -e "${GREEN}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}✅ MCP System Deployed Successfully!${NC}"
echo -e "${GREEN}═══════════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "${YELLOW}Next Steps:${NC}"
echo "1. cd $TARGET_DIR"
echo "2. ./scripts/check-mcp-status.sh    # Check current MCP status"
echo "3. ./scripts/install-bos-ai-mcps.sh  # Install MCPs"
echo ""
echo -e "${BLUE}Optional: Configure API Keys${NC}"
echo "1. cp .env.mcp-template .env"
echo "2. Edit .env and add your API keys"
echo "3. Re-run the installation script"
echo ""
echo -e "${GREEN}The MCP system is now ready to enhance your BOS-AI agents!${NC}"