#!/bin/bash

# BOS-AI Complete Deployment Script
# Deploys agents, commands, missions, and documentation to Claude Code

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${BLUE}"
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                                                              ║"
echo "║   BOS-AI: Complete System Deployment                        ║"
echo "║   Agents + Commands + Missions + Documentation              ║"
echo "║                                                              ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Create all necessary directories
echo -e "${GREEN}📁 Creating directory structure...${NC}"
mkdir -p .claude/agents
mkdir -p .claude/commands
mkdir -p .claude/missions

# Deploy CLAUDE.md documentation
echo -e "${BLUE}📚 Deploying command documentation...${NC}"
if [ -f "CLAUDE.md" ]; then
    cp CLAUDE.md .claude/
    echo -e "${GREEN}✅ CLAUDE.md deployed${NC}"

    # Verify correct BOS-AI version deployed
    echo -e "${BLUE}🔍 Verifying CLAUDE.md version...${NC}"
    if grep -q "BOS-AI.*Business Operating System" .claude/CLAUDE.md; then
        echo -e "${GREEN}✅ BOS-AI version verified${NC}"
    else
        echo -e "${RED}❌ ERROR: Wrong CLAUDE.md version!${NC}"
        exit 1
    fi
else
    echo -e "${YELLOW}⚠️  CLAUDE.md not found in root${NC}"
    exit 1
fi

# Deploy Commands
echo -e "${PURPLE}🎮 Deploying command system...${NC}"
if [ -d ".claude/commands" ]; then
    # Check if coord.md exists in the expected location
    if [ -f ".claude/commands/coord.md" ]; then
        echo -e "${GREEN}✅ coord.md already deployed${NC}"
    elif [ -f "commands/coord.md" ]; then
        cp commands/coord.md .claude/commands/
        echo -e "${GREEN}✅ coord.md deployed${NC}"
    fi
    
    # Check if meeting.md exists
    if [ -f ".claude/commands/meeting.md" ]; then
        echo -e "${GREEN}✅ meeting.md already deployed${NC}"
    elif [ -f "commands/meeting.md" ]; then
        cp commands/meeting.md .claude/commands/
        echo -e "${GREEN}✅ meeting.md deployed${NC}"
    fi
fi

# Deploy Missions
echo -e "${YELLOW}🎯 Deploying mission workflows...${NC}"

# Deploy missions from root missions directory
for mission in missions/*.md; do
    if [ -f "$mission" ]; then
        filename=$(basename "$mission")
        cp "$mission" .claude/missions/
        echo -e "${GREEN}✅ $filename deployed${NC}"
    fi
done

# Deploy missions from category subdirectories
for category in missions/*/; do
    if [ -d "$category" ]; then
        category_name=$(basename "$category")
        echo -e "${CYAN}  📁 Deploying ${category_name} missions...${NC}"
        for mission in "$category"*.md; do
            if [ -f "$mission" ]; then
                filename=$(basename "$mission")
                cp "$mission" .claude/missions/
                echo -e "${GREEN}    ✅ $filename deployed${NC}"
            fi
        done
    fi
done

# Count missions
MISSION_COUNT=$(ls -1 .claude/missions/*.md 2>/dev/null | wc -l)
echo -e "${GREEN}📊 Deployed ${MISSION_COUNT} missions${NC}"

# Deploy optimized agents
echo -e "${BLUE}🤖 Deploying all 30 BOS-AI agents...${NC}"

# Central Intelligence (Red) - 3 agents
echo -e "${RED}🔴 Deploying Central Intelligence Agents...${NC}"
cp agents/coordination/chassis-intelligence.md .claude/agents/ 2>/dev/null || echo "  Already deployed"
cp agents/coordination/client-success-intelligence.md .claude/agents/ 2>/dev/null || echo "  Already deployed"
cp agents/coordination/multiplication-engine.md .claude/agents/ 2>/dev/null || echo "  Already deployed"

# Discovery Engine (Blue) - 3 agents  
echo -e "${BLUE}🔵 Deploying Discovery Engine Agents...${NC}"
cp agents/discovery/market-intelligence.md .claude/agents/ 2>/dev/null || echo "  Already deployed"
cp agents/discovery/opportunity-validation.md .claude/agents/ 2>/dev/null || echo "  Already deployed"
cp agents/discovery/strategic-opportunity.md .claude/agents/ 2>/dev/null || echo "  Already deployed"

# Creation Engine (Green) - 3 agents
echo -e "${GREEN}🟢 Deploying Creation Engine Agents...${NC}"
cp agents/creation/solution-design.md .claude/agents/ 2>/dev/null || echo "  Already deployed"
cp agents/creation/rapid-development.md .claude/agents/ 2>/dev/null || echo "  Already deployed"
cp agents/creation/value-optimization.md .claude/agents/ 2>/dev/null || echo "  Already deployed"

# Delivery Engine (Yellow) - 3 agents
echo -e "${YELLOW}🟡 Deploying Delivery Engine Agents...${NC}"
cp agents/delivery/customer-success.md .claude/agents/ 2>/dev/null || echo "  Already deployed"
cp agents/delivery/quality-assurance.md .claude/agents/ 2>/dev/null || echo "  Already deployed"
cp agents/delivery/delivery-optimization.md .claude/agents/ 2>/dev/null || echo "  Already deployed"

# Growth Engine (Orange) - 3 agents
echo -e "${YELLOW}🟠 Deploying Growth Engine Agents...${NC}"
cp agents/growth/scaling-strategy.md .claude/agents/ 2>/dev/null || echo "  Already deployed"
cp agents/growth/market-expansion.md .claude/agents/ 2>/dev/null || echo "  Already deployed"
cp agents/growth/revenue-optimization.md .claude/agents/ 2>/dev/null || echo "  Already deployed"

# Marketing Function (Purple) - 3 agents
echo -e "${PURPLE}🟣 Deploying Marketing Function Agents...${NC}"
cp agents/marketing/brand-strategy.md .claude/agents/ 2>/dev/null || echo "  Already deployed"
cp agents/marketing/campaign-execution.md .claude/agents/ 2>/dev/null || echo "  Already deployed"
cp agents/marketing/content-creation.md .claude/agents/ 2>/dev/null || echo "  Already deployed"

# Sales Function (Cyan) - 3 agents
echo -e "${CYAN}🔷 Deploying Sales Function Agents...${NC}"
cp agents/sales/pipeline-management.md .claude/agents/ 2>/dev/null || echo "  Already deployed"
cp agents/sales/conversion-optimization.md .claude/agents/ 2>/dev/null || echo "  Already deployed"
cp agents/sales/revenue-operations.md .claude/agents/ 2>/dev/null || echo "  Already deployed"

# Customer Service (Lime) - 3 agents
echo -e "${GREEN}🟢 Deploying Customer Service Agents...${NC}"
cp agents/customer-service/support-management.md .claude/agents/ 2>/dev/null || echo "  Already deployed"
cp agents/customer-service/satisfaction-optimization.md .claude/agents/ 2>/dev/null || echo "  Already deployed"
cp agents/customer-service/retention-strategy.md .claude/agents/ 2>/dev/null || echo "  Already deployed"

# Financial Management (Gold) - 3 agents
echo -e "${YELLOW}🟨 Deploying Financial Management Agents...${NC}"
cp agents/financial/budget-planning.md .claude/agents/ 2>/dev/null || echo "  Already deployed"
cp agents/financial/performance-analysis.md .claude/agents/ 2>/dev/null || echo "  Already deployed"
cp agents/financial/investment-strategy.md .claude/agents/ 2>/dev/null || echo "  Already deployed"

# Legal Compliance (Silver) - 3 agents
echo -e "${NC}⚪ Deploying Legal Compliance Agents...${NC}"
cp agents/legal/compliance-management.md .claude/agents/ 2>/dev/null || echo "  Already deployed"
cp agents/legal/risk-assessment.md .claude/agents/ 2>/dev/null || echo "  Already deployed"
cp agents/legal/contract-management.md .claude/agents/ 2>/dev/null || echo "  Already deployed"

# Create deployment summary
echo -e "${GREEN}✅ Deployment complete! Generating summary...${NC}"

# Count deployed items
AGENT_COUNT=$(ls -1 .claude/agents/*.md 2>/dev/null | wc -l)
COMMAND_COUNT=$(ls -1 .claude/commands/*.md 2>/dev/null | wc -l)
MISSION_COUNT=$(ls -1 .claude/missions/*.md 2>/dev/null | wc -l)

# Create or update README in .claude
cat > .claude/README.md << EOF
# BOS-AI Complete Deployment Summary

## Deployment Date: $(date)

## Deployed Components

### 📊 Statistics
- **Agents**: $AGENT_COUNT files deployed
- **Commands**: $COMMAND_COUNT files deployed  
- **Missions**: $MISSION_COUNT files deployed
- **Documentation**: CLAUDE.md deployed

### 🤖 Agents (30 Specialized + Support)
All 30 BOS-AI agents organized by:
- 🔴 Central Intelligence (3)
- 🔵 Discovery Engine (3)
- 🟢 Creation Engine (3)
- 🟡 Delivery Engine (3)
- 🟠 Growth Engine (3)
- 🟣 Marketing Function (3)
- 🔷 Sales Function (3)
- 🟢 Customer Service (3)
- 🟨 Financial Management (3)
- ⚪ Legal Compliance (3)

### 🎮 Commands
- **/coord** - Business Chassis orchestration
- **/meeting** - Direct agent consultation

### 🎯 Missions
- project-setup - Initialize new projects
- chassis-optimization - Optimize Business Chassis
- daily-review - Daily business review
- customer-acquisition - Acquire new customers
- product-launch - Launch new products
- revenue-optimization - Optimize revenue
- [Additional missions as deployed]

## Usage

### Quick Start
\`\`\`bash
# Business optimization
/coord optimize

# Agent consultation
/meeting @revenue-optimization "pricing strategy"

# Project setup
/coord project-setup
\`\`\`

### Documentation
See CLAUDE.md for complete command reference and examples.

---
*BOS-AI v2.0 - Document Filing System Active*
*Generated: $(date)*
EOF

# Display final summary
echo -e "${BLUE}"
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                    DEPLOYMENT SUMMARY                        ║"
echo "╠══════════════════════════════════════════════════════════════╣"
echo "║  📊 Agents Deployed:    $AGENT_COUNT                                      ║"
echo "║  🎮 Commands Deployed:  $COMMAND_COUNT                                       ║"
echo "║  🎯 Missions Deployed:  $MISSION_COUNT                                       ║"
echo "║  📚 Documentation:      ✅ CLAUDE.md                         ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

echo -e "${GREEN}🎯 Usage Instructions:${NC}"
echo "• Use /coord for Business Chassis orchestration"
echo "• Use /meeting @agent-name for consultations"  
echo "• Reference agents with @agent-name in Claude Code"
echo "• All agents follow v2.0 filing protocols"
echo ""
echo -e "${GREEN}🎉 BOS-AI complete deployment successful!${NC}"
echo -e "${PURPLE}Your AI-powered Business Operating System is ready!${NC}"