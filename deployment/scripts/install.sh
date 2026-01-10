#!/bin/bash

# BOS-AI One-Line Installation Script
# Downloads and installs BOS-AI complete system directly from GitHub
# Usage: curl -fsSL https://raw.githubusercontent.com/TheWayWithin/BOS-AI/main/deployment/scripts/install.sh | bash -s full
# Tiers: starter (5 agents), business (15 agents), full (30 agents)

set -e

# Configuration
GITHUB_RAW_BASE="https://raw.githubusercontent.com/TheWayWithin/BOS-AI/main"
TIER="${1:-full}"  # Default to full tier for complete system

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
echo "║   BOS-AI: Business Operating System Installation            ║"
echo "║   Complete Document Library + Agents + Missions             ║"
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

# Create complete directory structure
echo -e "${BLUE}📁 Creating directory structure...${NC}"
mkdir -p .claude/agents
mkdir -p .claude/commands
mkdir -p .claude/missions
mkdir -p .claude/document-library
mkdir -p workspace
mkdir -p documents/foundation/prds
mkdir -p documents/operations
mkdir -p documents/archive
mkdir -p documents/assets
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

# Download core documentation with protection
echo -e "${PURPLE}📚 Installing core documentation...${NC}"

# Backup existing .claude/CLAUDE.md if it exists (protect customizations)
if [ -f ".claude/CLAUDE.md" ]; then
    BACKUP_FILE=".claude/CLAUDE.md.backup.$(date +%Y%m%d_%H%M%S)"
    cp .claude/CLAUDE.md "$BACKUP_FILE"
    echo -e "${YELLOW}⚠ Existing .claude/CLAUDE.md backed up to: $(basename $BACKUP_FILE)${NC}"
    echo -e "${CYAN}  Review backup if you had customizations${NC}"
fi

if download_file "$GITHUB_RAW_BASE/CLAUDE.md" ".claude/CLAUDE.md"; then
    echo -e "${GREEN}✓ .claude/CLAUDE.md installed (BOS-AI system documentation)${NC}"
else
    echo -e "${YELLOW}⚠ Failed to download CLAUDE.md${NC}"
fi

if download_file "$GITHUB_RAW_BASE/BOUNDARIES.md" ".claude/BOUNDARIES.md"; then
    echo -e "${GREEN}✓ BOUNDARIES.md installed${NC}"
else
    echo -e "${YELLOW}⚠ Failed to download BOUNDARIES.md${NC}"
fi

# Download Document Library templates and SOPs
echo -e "${CYAN}📚 Installing Document Library (templates & SOPs)...${NC}"
LIBRARY_COUNT=0

# Create subdirectories
mkdir -p .claude/document-library/Foundation
mkdir -p .claude/document-library/Operations/Marketing
mkdir -p .claude/document-library/Operations/Sales
mkdir -p .claude/document-library/Operations/Customer\ Service
mkdir -p .claude/document-library/Operations/Finance

# Root-level Document Library files
echo -e "${CYAN}  📁 Installing root Document Library files...${NC}"
declare -a ROOT_LIBRARY_FILES=(
    "business_foundation_library_guide.md"
    "FILING-STANDARDS.md"
)

for doc in "${ROOT_LIBRARY_FILES[@]}"; do
    # URL encode the filename (replace spaces with %20)
    encoded_doc=$(echo "$doc" | sed 's/ /%20/g')
    if download_file "$GITHUB_RAW_BASE/docs/Document%20Library/$encoded_doc" ".claude/document-library/$doc"; then
        echo -e "${GREEN}    ✓ $doc${NC}"
        LIBRARY_COUNT=$((LIBRARY_COUNT + 1))
    else
        echo -e "${YELLOW}    ⚠ Failed: $doc${NC}"
    fi
done

# Foundation documents
echo -e "${CYAN}  📁 Installing Foundation documents...${NC}"
declare -a FOUNDATION_FILES=(
    "Vision and Mission.md"
    "Vision and Mission Development SOP (Rapid AI-Driven).md"
    "Market and Client Research Template.md"
    "Market and Client Research SOP (Rapid AI-Driven).md"
    "Client Success Blueprint.md"
    "Client Success Blueprint Creation SOP (Revised).md"
    "Positioning Statement Template.md"
    "Positioning Statement SOP: 3-Hour Sprint.md"
    "Positioning AI Prompts for Statement Development.md"
    "Strategic Roadmap_ Vision to Great.md"
    "Strategic Roadmap Creation SOP (AI-Driven).md"
    "Brand Style Guide.md"
    "Brand Style Guide Creation SOP (AI-Driven).md"
    "Product Requirements Document (PRD).md"
    "PRD Creation SOP.md"
    "Design Playbook Template.md"
    "Design Playbook Creation SOP.md"
    "Pricing Strategy Template.md"
    "Pricing Strategy Creation SOP (AI-Driven).md"
)

for doc in "${FOUNDATION_FILES[@]}"; do
    # URL encode the filename (replace spaces with %20)
    encoded_doc=$(echo "$doc" | sed 's/ /%20/g')
    if download_file "$GITHUB_RAW_BASE/docs/Document%20Library/Foundation/$encoded_doc" ".claude/document-library/Foundation/$doc"; then
        echo -e "${GREEN}    ✓ $doc${NC}"
        LIBRARY_COUNT=$((LIBRARY_COUNT + 1))
    else
        echo -e "${YELLOW}    ⚠ Failed: $doc${NC}"
    fi
done

# Solopreneur Defaults (JSON configuration file)
if download_file "$GITHUB_RAW_BASE/docs/Document%20Library/Foundation/Solopreneur-Defaults.json" ".claude/document-library/Foundation/Solopreneur-Defaults.json"; then
    echo -e "${GREEN}    ✓ Solopreneur-Defaults.json${NC}"
    LIBRARY_COUNT=$((LIBRARY_COUNT + 1))
else
    echo -e "${YELLOW}    ⚠ Failed: Solopreneur-Defaults.json${NC}"
fi

# Marketing Operations documents
echo -e "${CYAN}  📁 Installing Marketing Operations...${NC}"
declare -a MARKETING_FILES=(
    "Marketing Bible.md"
    "Marketing Plan.md"
    "Content Calendar.md"
    "Marketing Documentation Creation SOP (AI-Driven).md"
)

for doc in "${MARKETING_FILES[@]}"; do
    encoded_doc=$(echo "$doc" | sed 's/ /%20/g')
    if download_file "$GITHUB_RAW_BASE/docs/Document%20Library/Operations/Marketing/$encoded_doc" ".claude/document-library/Operations/Marketing/$doc"; then
        echo -e "${GREEN}    ✓ $doc${NC}"
        LIBRARY_COUNT=$((LIBRARY_COUNT + 1))
    else
        echo -e "${YELLOW}    ⚠ Failed: $doc${NC}"
    fi
done

# Sales Operations documents
echo -e "${CYAN}  📁 Installing Sales Operations...${NC}"
declare -a SALES_FILES=(
    "Sales Bible.md"
    "Sales Plan.md"
    "Sales Documentation Creation SOP (AI-Driven).md"
)

for doc in "${SALES_FILES[@]}"; do
    encoded_doc=$(echo "$doc" | sed 's/ /%20/g')
    if download_file "$GITHUB_RAW_BASE/docs/Document%20Library/Operations/Sales/$encoded_doc" ".claude/document-library/Operations/Sales/$doc"; then
        echo -e "${GREEN}    ✓ $doc${NC}"
        LIBRARY_COUNT=$((LIBRARY_COUNT + 1))
    else
        echo -e "${YELLOW}    ⚠ Failed: $doc${NC}"
    fi
done

# Customer Service Operations documents
echo -e "${CYAN}  📁 Installing Customer Service Operations...${NC}"
declare -a CUSTOMER_SERVICE_FILES=(
    "Customer Service Bible.md"
    "Customer Service Plan.md"
    "Customer Service Documentation Creation SOP (AI-Driven).md"
)

for doc in "${CUSTOMER_SERVICE_FILES[@]}"; do
    encoded_doc=$(echo "$doc" | sed 's/ /%20/g')
    if download_file "$GITHUB_RAW_BASE/docs/Document%20Library/Operations/Customer%20Service/$encoded_doc" ".claude/document-library/Operations/Customer Service/$doc"; then
        echo -e "${GREEN}    ✓ $doc${NC}"
        LIBRARY_COUNT=$((LIBRARY_COUNT + 1))
    else
        echo -e "${YELLOW}    ⚠ Failed: $doc${NC}"
    fi
done

# Finance Operations documents
echo -e "${CYAN}  📁 Installing Finance Operations...${NC}"
declare -a FINANCE_FILES=(
    "Finance Bible.md"
    "Finance Plan.md"
    "Finance Documentation Creation SOP (AI-Driven).md"
)

for doc in "${FINANCE_FILES[@]}"; do
    encoded_doc=$(echo "$doc" | sed 's/ /%20/g')
    if download_file "$GITHUB_RAW_BASE/docs/Document%20Library/Operations/Finance/$encoded_doc" ".claude/document-library/Operations/Finance/$doc"; then
        echo -e "${GREEN}    ✓ $doc${NC}"
        LIBRARY_COUNT=$((LIBRARY_COUNT + 1))
    else
        echo -e "${YELLOW}    ⚠ Failed: $doc${NC}"
    fi
done

echo -e "${GREEN}✓ Installed $LIBRARY_COUNT Document Library files${NC}"

# Download workspace templates
echo -e "${PURPLE}📋 Installing workspace templates...${NC}"
WORKSPACE_COUNT=0

declare -a WORKSPACE_FILES=(
    "business-plan.md"
    "chassis-metrics.md"
    "agent-context.md"
    "handoff-notes.md"
    "decision-log.md"
)

for file in "${WORKSPACE_FILES[@]}"; do
    if download_file "$GITHUB_RAW_BASE/workspace/$file" "workspace/$file"; then
        echo -e "${GREEN}  ✓ $file${NC}"
        WORKSPACE_COUNT=$((WORKSPACE_COUNT + 1))
    else
        echo -e "${YELLOW}  ⚠ Failed: $file${NC}"
    fi
done

# Download commands
echo -e "${CYAN}🎮 Installing command system...${NC}"
COMMAND_COUNT=0

if download_file "$GITHUB_RAW_BASE/.claude/commands/coord.md" ".claude/commands/coord.md"; then
    echo -e "${GREEN}✓ /coord command installed${NC}"
    COMMAND_COUNT=$((COMMAND_COUNT + 1))
else
    echo -e "${YELLOW}⚠ Failed to download coord.md${NC}"
fi

if download_file "$GITHUB_RAW_BASE/.claude/commands/meeting.md" ".claude/commands/meeting.md"; then
    echo -e "${GREEN}✓ /meeting command installed${NC}"
    COMMAND_COUNT=$((COMMAND_COUNT + 1))
else
    echo -e "${YELLOW}⚠ Failed to download meeting.md${NC}"
fi

if download_file "$GITHUB_RAW_BASE/commands/report.md" ".claude/commands/report.md"; then
    echo -e "${GREEN}✓ /report command installed${NC}"
    COMMAND_COUNT=$((COMMAND_COUNT + 1))
else
    echo -e "${YELLOW}⚠ Failed to download report.md${NC}"
fi

if download_file "$GITHUB_RAW_BASE/commands/pmd.md" ".claude/commands/pmd.md"; then
    echo -e "${GREEN}✓ /pmd command installed${NC}"
    COMMAND_COUNT=$((COMMAND_COUNT + 1))
else
    echo -e "${YELLOW}⚠ Failed to download pmd.md${NC}"
fi

if download_file "$GITHUB_RAW_BASE/commands/dailyreport.md" ".claude/commands/dailyreport.md"; then
    echo -e "${GREEN}✓ /dailyreport command installed${NC}"
    COMMAND_COUNT=$((COMMAND_COUNT + 1))
else
    echo -e "${YELLOW}⚠ Failed to download dailyreport.md${NC}"
fi

# Download missions
echo -e "${YELLOW}🎯 Installing missions...${NC}"
MISSION_COUNT=0

# Business Setup missions
echo -e "${CYAN}  📁 Installing business-setup missions...${NC}"
for mission in chassis-implementation client-success-blueprint core-asset-creation foundation-setup foundation-migration foundation-bootstrap; do
    if download_file "$GITHUB_RAW_BASE/missions/business-setup/$mission.md" ".claude/missions/$mission.md"; then
        echo -e "${GREEN}    ✓ $mission${NC}"
        MISSION_COUNT=$((MISSION_COUNT + 1))
    else
        echo -e "${YELLOW}    ⚠ Failed: $mission${NC}"
    fi
done

# Discovery missions
echo -e "${CYAN}  📁 Installing discovery missions...${NC}"
for mission in market-research opportunity-validation competitive-analysis; do
    if download_file "$GITHUB_RAW_BASE/missions/discovery/$mission.md" ".claude/missions/$mission.md"; then
        echo -e "${GREEN}    ✓ $mission${NC}"
        MISSION_COUNT=$((MISSION_COUNT + 1))
    else
        echo -e "${YELLOW}    ⚠ Failed: $mission${NC}"
    fi
done

# Creation missions
echo -e "${CYAN}  📁 Installing creation missions...${NC}"
for mission in solution-development mvp-creation value-optimization; do
    if download_file "$GITHUB_RAW_BASE/missions/creation/$mission.md" ".claude/missions/$mission.md"; then
        echo -e "${GREEN}    ✓ $mission${NC}"
        MISSION_COUNT=$((MISSION_COUNT + 1))
    else
        echo -e "${YELLOW}    ⚠ Failed: $mission${NC}"
    fi
done

# Operations missions
echo -e "${CYAN}  📁 Installing operations missions...${NC}"
for mission in daily-chassis-review weekly-optimization quarterly-strategy foundation-review vision-mission-update; do
    if download_file "$GITHUB_RAW_BASE/missions/operations/$mission.md" ".claude/missions/$mission.md"; then
        echo -e "${GREEN}    ✓ $mission${NC}"
        MISSION_COUNT=$((MISSION_COUNT + 1))
    else
        echo -e "${YELLOW}    ⚠ Failed: $mission${NC}"
    fi
done

# Sequence missions
echo -e "${CYAN}  📁 Installing sequence missions...${NC}"
for mission in chassis-optimization-sequence product-launch-sequence customer-acquisition-sequence retention-improvement-sequence weekly-review-sequence; do
    if download_file "$GITHUB_RAW_BASE/missions/sequences/$mission.md" ".claude/missions/$mission.md"; then
        echo -e "${GREEN}    ✓ $mission${NC}"
        MISSION_COUNT=$((MISSION_COUNT + 1))
    else
        echo -e "${YELLOW}    ⚠ Failed: $mission${NC}"
    fi
done

# Other category missions (delivery, growth, optimization, marketing, sales, customer-service, finance, foundation)
for category in delivery growth optimization marketing sales customer-service finance foundation; do
    echo -e "${CYAN}  📁 Installing $category missions...${NC}"

    case $category in
        delivery)
            missions="customer-onboarding quality-assurance delivery-optimization"
            ;;
        growth)
            missions="scaling-strategy market-expansion revenue-optimization"
            ;;
        optimization)
            missions="chassis-optimization multiplication-analysis performance-enhancement"
            ;;
        marketing)
            missions="marketing-system-setup marketing-bible-creation marketing-plan-development content-calendar-implementation customer-journey-optimization campaign-launch content-batch-creation"
            ;;
        sales)
            missions="sales-system-setup sales-bible-creation sales-plan-development pipeline-optimization conversion-mastery pricing-strategy sales-marketing-alignment"
            ;;
        customer-service)
            missions="customer-service-system-setup service-bible-creation service-plan-development retention-optimization service-excellence-transformation customer-success-enablement proactive-service-implementation"
            ;;
        finance)
            missions="finance-system-setup finance-bible-creation finance-plan-development profit-optimization cash-flow-mastery investment-strategy-development financial-transformation"
            ;;
        foundation)
            missions="vision-mission-creation market-research-creation client-blueprint-creation positioning-creation roadmap-creation brand-guide-creation prd-creation pricing-strategy-creation"
            ;;
    esac
    
    for mission in $missions; do
        if download_file "$GITHUB_RAW_BASE/missions/$category/$mission.md" ".claude/missions/$mission.md"; then
            echo -e "${GREEN}    ✓ $mission${NC}"
            MISSION_COUNT=$((MISSION_COUNT + 1))
        else
            echo -e "${YELLOW}    ⚠ Failed: $mission${NC}"
        fi
    done
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
        echo -e "${GREEN}✓ $agent_name${NC}"
        AGENT_COUNT=$((AGENT_COUNT + 1))
    else
        echo -e "${YELLOW}⚠ Failed: $agent_name${NC}"
        FAILED_COUNT=$((FAILED_COUNT + 1))
    fi
done

# Create project CLAUDE.md if it doesn't exist
if [ ! -f "CLAUDE.md" ]; then
    echo -e "${BLUE}📝 Creating project CLAUDE.md...${NC}"
    cat > CLAUDE.md << 'EOF'
# Project with BOS-AI

This project uses BOS-AI for business operations management.

## Quick Start
- Use `/coord` for business orchestration
- Templates in `.claude/document-library/`
- Save documents to `documents/foundation/`

See `.claude/CLAUDE.md` for full BOS-AI documentation.
EOF
    echo -e "${GREEN}✓ Created project CLAUDE.md${NC}"
fi

# Create installation summary
echo -e "${GREEN}✅ Creating installation summary...${NC}"

cat > .claude/INSTALLATION_SUMMARY.md << EOF
# BOS-AI Installation Summary

## Installation Date: $(date)
## Installation Tier: $TIER

### 📊 Installed Components
- **Document Library**: $LIBRARY_COUNT templates & SOPs
- **Agents**: $AGENT_COUNT business agents
- **Missions**: $MISSION_COUNT missions
- **Commands**: $COMMAND_COUNT commands
- **Workspace**: $WORKSPACE_COUNT context templates

### 📁 Directory Structure
- \`.claude/document-library/\` → Templates & SOPs
- \`.claude/agents/\` → Business agents  
- \`.claude/missions/\` → Business missions
- \`documents/foundation/\` → Your business documents
- \`documents/archive/\` → Version history
- \`workspace/\` → Mission context

### 🚀 Quick Start

1. **Create your Vision & Mission**:
   \`\`\`
   /coord vision-mission-update
   \`\`\`

2. **Run Business Chassis optimization**:
   \`\`\`
   /coord optimize
   \`\`\`

3. **Review all foundation documents**:
   \`\`\`
   /coord foundation-review
   \`\`\`

### 📖 Key Documents
- Filing Standards: \`.claude/document-library/FILING-STANDARDS.md\`
- Library Guide: \`.claude/document-library/business_foundation_library_guide.md\`
- BOS-AI Commands: \`.claude/CLAUDE.md\`

---
*BOS-AI v2.0 - Business Operating System*
EOF

# Display summary
echo -e "${BLUE}"
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                 INSTALLATION COMPLETE                        ║"
echo "╠══════════════════════════════════════════════════════════════╣"
printf "║  📚 Document Library: %-3s templates & SOPs              ║\n" "$LIBRARY_COUNT"
printf "║  🤖 Agents:          %-3s business agents                ║\n" "$AGENT_COUNT"
printf "║  🎯 Missions:        %-3s available                      ║\n" "$MISSION_COUNT"
printf "║  🎮 Commands:        %-3s installed                      ║\n" "$COMMAND_COUNT"
printf "║  📋 Workspace:       %-3s context templates              ║\n" "$WORKSPACE_COUNT"
echo "║  📁 Directories:     All created                            ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

if [ $FAILED_COUNT -gt 0 ]; then
    echo -e "${YELLOW}⚠️  Some components failed to install. Re-run to retry.${NC}"
fi

echo -e "${GREEN}🎉 BOS-AI installation complete!${NC}"
echo -e "${CYAN}📚 Type '/coord' to start using BOS-AI${NC}"
echo ""
echo -e "${PURPLE}Key locations:${NC}"
echo "  • Templates: .claude/document-library/"
echo "  • Your docs: documents/foundation/"
echo "  • Archives:  documents/archive/"
echo ""
echo -e "${GREEN}🚀 Your Business Operating System is ready!${NC}"

exit 0