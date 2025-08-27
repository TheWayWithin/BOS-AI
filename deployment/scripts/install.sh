#!/bin/bash

# BOS-AI One-Line Installation Script
# Downloads and installs BOS-AI agents directly from GitHub without cloning
# Usage: curl -fsSL https://raw.githubusercontent.com/TheWayWithin/BOS-AI/main/deployment/scripts/install.sh | bash -s [tier]
# Tiers: starter (5 agents), business (15 agents), full (30 agents)

set -e

# Configuration
GITHUB_RAW_BASE="https://raw.githubusercontent.com/TheWayWithin/BOS-AI/main"
TIER="${1:-starter}"  # Default to starter tier

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Banner
echo -e "${BLUE}"
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                                                              ║"
echo "║   BOS-AI: One-Line Installation                             ║"
echo "║   Business Operating System AI Framework                     ║"
echo "║                                                              ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Validate tier
case $TIER in
    starter|business|full)
        echo -e "${GREEN}✓ Installing $TIER tier${NC}"
        ;;
    *)
        echo -e "${RED}✗ Invalid tier: $TIER${NC}"
        echo "Usage: curl -fsSL [URL] | bash -s [starter|business|full]"
        exit 1
        ;;
esac

# Create directory structure
echo -e "${BLUE}📁 Creating directory structure...${NC}"
mkdir -p .claude/agents
mkdir -p .claude/commands
mkdir -p .claude/missions
mkdir -p documents/business-assets
mkdir -p documents/sops
mkdir -p assets/reports

# Function to download file with retry
download_file() {
    local url=$1
    local dest=$2
    local max_retries=3
    local retry_count=0
    
    while [ $retry_count -lt $max_retries ]; do
        if curl -fsSL "$url" -o "$dest" 2>/dev/null; then
            return 0
        fi
        retry_count=$((retry_count + 1))
        sleep 1
    done
    return 1
}

# Download CLAUDE.md documentation
echo -e "${PURPLE}📚 Installing documentation...${NC}"
if download_file "$GITHUB_RAW_BASE/CLAUDE.md" ".claude/CLAUDE.md"; then
    echo -e "${GREEN}✓ CLAUDE.md installed${NC}"
else
    echo -e "${YELLOW}⚠ Failed to download CLAUDE.md${NC}"
fi

# Download commands
echo -e "${CYAN}🎮 Installing command system...${NC}"
if download_file "$GITHUB_RAW_BASE/.claude/commands/coord.md" ".claude/commands/coord.md"; then
    echo -e "${GREEN}✓ /coord command installed${NC}"
else
    echo -e "${YELLOW}⚠ Failed to download coord.md${NC}"
fi

if download_file "$GITHUB_RAW_BASE/.claude/commands/meeting.md" ".claude/commands/meeting.md"; then
    echo -e "${GREEN}✓ /meeting command installed${NC}"
else
    echo -e "${YELLOW}⚠ Failed to download meeting.md${NC}"
fi

# Download missions
echo -e "${YELLOW}🎯 Installing missions...${NC}"

# Download missions from each category (compatible with older bash)
# Business Setup missions
echo -e "${CYAN}  📁 Installing business-setup missions...${NC}"
for mission in chassis-implementation client-success-blueprint core-asset-creation; do
    if download_file "$GITHUB_RAW_BASE/missions/business-setup/$mission.md" ".claude/missions/$mission.md"; then
        echo -e "${GREEN}    ✓ $mission installed${NC}"
    else
        echo -e "${YELLOW}    ⚠ Failed to download $mission${NC}"
    fi
done

# Discovery missions
echo -e "${CYAN}  📁 Installing discovery missions...${NC}"
for mission in market-research opportunity-validation competitive-analysis; do
    if download_file "$GITHUB_RAW_BASE/missions/discovery/$mission.md" ".claude/missions/$mission.md"; then
        echo -e "${GREEN}    ✓ $mission installed${NC}"
    else
        echo -e "${YELLOW}    ⚠ Failed to download $mission${NC}"
    fi
done

# Creation missions
echo -e "${CYAN}  📁 Installing creation missions...${NC}"
for mission in solution-development mvp-creation value-optimization; do
    if download_file "$GITHUB_RAW_BASE/missions/creation/$mission.md" ".claude/missions/$mission.md"; then
        echo -e "${GREEN}    ✓ $mission installed${NC}"
    else
        echo -e "${YELLOW}    ⚠ Failed to download $mission${NC}"
    fi
done

# Delivery missions
echo -e "${CYAN}  📁 Installing delivery missions...${NC}"
for mission in customer-onboarding quality-assurance delivery-optimization; do
    if download_file "$GITHUB_RAW_BASE/missions/delivery/$mission.md" ".claude/missions/$mission.md"; then
        echo -e "${GREEN}    ✓ $mission installed${NC}"
    else
        echo -e "${YELLOW}    ⚠ Failed to download $mission${NC}"
    fi
done

# Growth missions
echo -e "${CYAN}  📁 Installing growth missions...${NC}"
for mission in scaling-strategy market-expansion revenue-optimization; do
    if download_file "$GITHUB_RAW_BASE/missions/growth/$mission.md" ".claude/missions/$mission.md"; then
        echo -e "${GREEN}    ✓ $mission installed${NC}"
    else
        echo -e "${YELLOW}    ⚠ Failed to download $mission${NC}"
    fi
done

# Operations missions
echo -e "${CYAN}  📁 Installing operations missions...${NC}"
for mission in daily-chassis-review weekly-optimization quarterly-strategy; do
    if download_file "$GITHUB_RAW_BASE/missions/operations/$mission.md" ".claude/missions/$mission.md"; then
        echo -e "${GREEN}    ✓ $mission installed${NC}"
    else
        echo -e "${YELLOW}    ⚠ Failed to download $mission${NC}"
    fi
done

# Optimization missions
echo -e "${CYAN}  📁 Installing optimization missions...${NC}"
for mission in chassis-optimization multiplication-analysis performance-enhancement; do
    if download_file "$GITHUB_RAW_BASE/missions/optimization/$mission.md" ".claude/missions/$mission.md"; then
        echo -e "${GREEN}    ✓ $mission installed${NC}"
    else
        echo -e "${YELLOW}    ⚠ Failed to download $mission${NC}"
    fi
done

# Also download any root-level missions
root_missions=(
    "project-setup"
    "daily-review"
    "customer-acquisition"
    "product-launch"
    "revenue-optimization"
)

for mission in "${root_missions[@]}"; do
    if [ -f "$GITHUB_RAW_BASE/missions/$mission.md" ]; then
        if download_file "$GITHUB_RAW_BASE/missions/$mission.md" ".claude/missions/$mission.md"; then
            echo -e "${GREEN}✓ $mission mission installed${NC}"
        fi
    fi
done

# Define agent lists by tier
declare -a STARTER_AGENTS=(
    "coordination/chassis-intelligence"
    "coordination/multiplication-engine"
    "growth/revenue-optimization"
    "sales/pipeline-management"
    "delivery/customer-success"
)

declare -a BUSINESS_AGENTS=(
    # All starter agents
    "${STARTER_AGENTS[@]}"
    # Additional business agents
    "coordination/client-success-intelligence"
    "discovery/market-intelligence"
    "creation/solution-design"
    "delivery/quality-assurance"
    "growth/scaling-strategy"
    "marketing/brand-strategy"
    "marketing/campaign-execution"
    "sales/conversion-optimization"
    "customer-service/satisfaction-optimization"
    "financial/budget-planning"
)

declare -a FULL_AGENTS=(
    # Core coordination (3)
    "coordination/chassis-intelligence"
    "coordination/client-success-intelligence"
    "coordination/multiplication-engine"
    # Discovery engine (3)
    "discovery/market-intelligence"
    "discovery/opportunity-validation"
    "discovery/strategic-opportunity"
    # Creation engine (3)
    "creation/solution-design"
    "creation/rapid-development"
    "creation/value-optimization"
    # Delivery engine (3)
    "delivery/customer-success"
    "delivery/quality-assurance"
    "delivery/delivery-optimization"
    # Growth engine (3)
    "growth/scaling-strategy"
    "growth/market-expansion"
    "growth/revenue-optimization"
    # Marketing function (3)
    "marketing/brand-strategy"
    "marketing/campaign-execution"
    "marketing/content-creation"
    # Sales function (3)
    "sales/pipeline-management"
    "sales/conversion-optimization"
    "sales/revenue-operations"
    # Customer service (3)
    "customer-service/support-management"
    "customer-service/satisfaction-optimization"
    "customer-service/retention-strategy"
    # Financial management (3)
    "financial/budget-planning"
    "financial/performance-analysis"
    "financial/investment-strategy"
    # Legal compliance (3)
    "legal/compliance-management"
    "legal/risk-assessment"
    "legal/contract-management"
)

# Select agents based on tier
case $TIER in
    starter)
        AGENTS=("${STARTER_AGENTS[@]}")
        echo -e "${BLUE}🤖 Installing 5 essential agents...${NC}"
        ;;
    business)
        AGENTS=("${BUSINESS_AGENTS[@]}")
        echo -e "${BLUE}🤖 Installing 15 business agents...${NC}"
        ;;
    full)
        AGENTS=("${FULL_AGENTS[@]}")
        echo -e "${BLUE}🤖 Installing all 30 agents...${NC}"
        ;;
esac

# Install agents
AGENT_COUNT=0
FAILED_COUNT=0

for agent_path in "${AGENTS[@]}"; do
    agent_name=$(basename "$agent_path")
    if download_file "$GITHUB_RAW_BASE/agents/$agent_path.md" ".claude/agents/$agent_name.md"; then
        echo -e "${GREEN}✓ $agent_name installed${NC}"
        AGENT_COUNT=$((AGENT_COUNT + 1))
    else
        echo -e "${YELLOW}⚠ Failed to install $agent_name${NC}"
        FAILED_COUNT=$((FAILED_COUNT + 1))
    fi
done

# Create starter documents
echo -e "${BLUE}📄 Creating starter documents...${NC}"

# Create filing system SOP
cat > documents/sops/document-filing-sop.md << 'EOF'
# Document Filing Standard Operating Procedure

## Filing System v2.0
- Living Documents: `/documents/business-assets/` and `/documents/sops/`
- Generated Assets: `/assets/reports/`
- Naming Convention: `YYYY-MM-DD-[type]-[description].md`

## Agent Filing Rules
All agents follow this protocol for consistent document management.
EOF

# Create project README
cat > documents/business-assets/README.md << 'EOF'
# Business Assets

This directory contains living business documents that are continuously updated:
- Strategic plans
- Business models
- Client documentation
- Partnership agreements

All documents follow the YYYY-MM-DD naming convention.
EOF

# Create installation summary
echo -e "${GREEN}✅ Creating installation summary...${NC}"

cat > .claude/INSTALLATION_SUMMARY.md << EOF
# BOS-AI Installation Summary

## Installation Date: $(date)
## Installation Tier: $TIER

### 📊 Installed Components
- **Agents**: $AGENT_COUNT successfully installed
- **Commands**: 2 (/coord and /meeting)
- **Missions**: 6 core missions
- **Documentation**: CLAUDE.md reference

### 🚀 Quick Start

1. **Test the system**:
   \`\`\`
   /coord optimize
   \`\`\`

2. **Consult an agent**:
   \`\`\`
   /meeting @chassis-intelligence "business strategy"
   \`\`\`

3. **Run a mission**:
   \`\`\`
   /coord project-setup
   \`\`\`

### 📖 Documentation
- See \`.claude/CLAUDE.md\` for complete command reference
- Visit https://github.com/TheWayWithin/BOS-AI for full documentation

### 🔧 Upgrade Options
- **Current**: $TIER tier
- **Upgrade to business**: \`curl -fsSL [URL] | bash -s business\`
- **Upgrade to full**: \`curl -fsSL [URL] | bash -s full\`

---
*BOS-AI v2.0 - Business Operating System AI Framework*
EOF

# Display summary
echo -e "${BLUE}"
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                 INSTALLATION COMPLETE                        ║"
echo "╠══════════════════════════════════════════════════════════════╣"
echo "║  📊 Tier:        $TIER                                         "
echo "║  🤖 Agents:      $AGENT_COUNT installed                         "
echo "║  ⚠️  Failed:      $FAILED_COUNT                                 "
echo "║  🎮 Commands:    2 installed                                 ║"
echo "║  🎯 Missions:    6 installed                                 ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

if [ $FAILED_COUNT -gt 0 ]; then
    echo -e "${YELLOW}⚠️  Some components failed to install. This may be due to network issues.${NC}"
    echo -e "${YELLOW}   You can re-run the installation to retry failed components.${NC}"
fi

echo -e "${GREEN}🎉 BOS-AI installation complete!${NC}"
echo -e "${CYAN}📚 Type '/coord' to start using BOS-AI${NC}"
echo ""
echo -e "${PURPLE}🚀 Your AI-powered Business Operating System is ready!${NC}"

# Create activation hint file
cat > .claude/ACTIVATE.md << 'EOF'
# 🚀 BOS-AI is Installed!

## Quick Start Commands

### Business Optimization
```
/coord optimize
```

### Agent Consultation
```
/meeting @chassis-intelligence "help me grow my business"
```

### Project Setup
```
/coord project-setup
```

See `.claude/CLAUDE.md` for full documentation.
EOF

exit 0