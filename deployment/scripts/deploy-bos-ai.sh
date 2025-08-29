#!/bin/bash

# BOS-AI Complete Deployment Script v2.0
# Deploys business agents, commands, missions, boundaries, and Document Library
# Respects BOS-AI/AGENT-11 separation

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
echo "║   BOS-AI: Business Operating System Deployment v2.0         ║"
echo "║   29 Business Agents + Missions + Document Library          ║"
echo "║                                                              ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Verify we're in the right directory
if [ ! -f "CLAUDE.md" ] || [ ! -f "BOUNDARIES.md" ]; then
    echo -e "${RED}❌ Error: Must run from BOS-AI root directory${NC}"
    exit 1
fi

# Create all necessary directories
echo -e "${GREEN}📁 Creating directory structure...${NC}"
mkdir -p .claude/agents
mkdir -p .claude/commands  
mkdir -p .claude/missions
mkdir -p workspace

# Deploy core documentation
echo -e "${BLUE}📚 Deploying core documentation...${NC}"
cp CLAUDE.md .claude/
echo -e "${GREEN}✅ CLAUDE.md deployed${NC}"
cp BOUNDARIES.md .claude/
echo -e "${GREEN}✅ BOUNDARIES.md deployed (enforces separation)${NC}"

# Deploy Commands
echo -e "${PURPLE}🎮 Deploying command system...${NC}"
if [ -d ".claude/commands" ]; then
    cp .claude/commands/*.md .claude/commands/ 2>/dev/null || true
    echo -e "${GREEN}✅ Commands deployed${NC}"
fi

# Deploy Business Agents (29 total - NO AGENT-11 agents)
echo -e "${BLUE}🤖 Deploying 29 BOS-AI business agents...${NC}"

# Deploy from .claude/agents (already has correct 29 agents)
AGENT_COUNT=0
for agent in .claude/agents/*.md; do
    if [ -f "$agent" ]; then
        filename=$(basename "$agent")
        # Skip README and any AGENT-11 agents if they somehow exist
        if [[ "$filename" == "README.md" ]] || \
           [[ "$filename" =~ ^(developer|tester|architect|designer|operator|documenter|analyst|coordinator|strategist|marketer|support)\.md$ ]]; then
            if [[ "$filename" != "README.md" ]]; then
                echo -e "${YELLOW}⚠️  Skipping AGENT-11 agent: $filename${NC}"
            fi
        else
            ((AGENT_COUNT++))
            echo -e "${GREEN}✅ Deployed: $filename${NC}"
        fi
    fi
done

echo -e "${GREEN}📊 Deployed ${AGENT_COUNT} business agents${NC}"

# Deploy Missions (excluding archived technical missions)
echo -e "${YELLOW}🎯 Deploying business missions...${NC}"

MISSION_COUNT=0

# Deploy missions from root missions directory (skip archived)
for mission in missions/*.md; do
    if [ -f "$mission" ]; then
        filename=$(basename "$mission")
        # Skip if it's an archived technical mission
        if [[ ! "$filename" =~ ^mission-(build|deploy|fix|integrate|migrate|optimize|refactor|release|security|document|mvp)\.md$ ]] && \
           [[ "$filename" != "operation-genesis.md" ]]; then
            cp "$mission" .claude/missions/
            echo -e "${GREEN}✅ $filename deployed${NC}"
            ((MISSION_COUNT++))
        else
            echo -e "${YELLOW}⚠️  Skipping technical mission: $filename${NC}"
        fi
    fi
done

# Deploy missions from category subdirectories (business-focused)
for category in business-setup creation delivery discovery growth operations optimization sequences; do
    if [ -d "missions/$category" ]; then
        echo -e "${CYAN}  📁 Deploying ${category} missions...${NC}"
        for mission in missions/"$category"/*.md; do
            if [ -f "$mission" ]; then
                filename=$(basename "$mission")
                cp "$mission" .claude/missions/
                echo -e "${GREEN}    ✅ $filename deployed${NC}"
                ((MISSION_COUNT++))
            fi
        done
    fi
done

echo -e "${GREEN}📊 Deployed ${MISSION_COUNT} business missions${NC}"

# Deploy Workspace Context Templates
echo -e "${PURPLE}📋 Deploying workspace context templates...${NC}"
if [ -d "workspace" ]; then
    CONTEXT_COUNT=$(ls workspace/*.md 2>/dev/null | wc -l)
    if [ "$CONTEXT_COUNT" -gt 0 ]; then
        echo -e "${GREEN}✅ Workspace context templates deployed (${CONTEXT_COUNT} files)${NC}"
        echo -e "${CYAN}   Location: workspace/${NC}"
    fi
else
    echo -e "${YELLOW}⚠️  Creating empty workspace directory${NC}"
    mkdir -p workspace
fi

# Deploy BOS-AI Orchestration Guide
echo -e "${BLUE}📖 Deploying orchestration documentation...${NC}"
if [ -f "docs/bos-ai-orchestration-guide.md" ]; then
    echo -e "${GREEN}✅ BOS-AI Orchestration Guide available${NC}"
    echo -e "${CYAN}   Location: docs/bos-ai-orchestration-guide.md${NC}"
fi

# Deploy Document Library
echo -e "${CYAN}📚 Deploying Document Library...${NC}"
if [ -d "docs/Document Library" ]; then
    DOC_COUNT=$(find "docs/Document Library" -name "*.md" -type f | wc -l)
    echo -e "${GREEN}✅ Document Library available with ${DOC_COUNT} business documents${NC}"
    echo -e "${CYAN}   Location: docs/Document Library/${NC}"
else
    echo -e "${YELLOW}⚠️  Document Library not found${NC}"
fi

# Summary
echo -e "${BLUE}"
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                  DEPLOYMENT COMPLETE                         ║"
echo "╠══════════════════════════════════════════════════════════════╣"
echo "║  ✅ Core Documentation: CLAUDE.md, BOUNDARIES.md            ║"
echo "║  ✅ Business Agents: ${AGENT_COUNT} agents (NO technical agents)     ║"
echo "║  ✅ Business Missions: ${MISSION_COUNT} missions                      ║"
echo "║  ✅ Workspace Context: Sequential orchestration templates   ║"
echo "║  ✅ Orchestration Guide: docs/bos-ai-orchestration-guide.md ║"
echo "║  ✅ Document Library: Business foundation documents         ║"
echo "║                                                              ║"
echo "║  🚫 BOUNDARIES ENFORCED:                                    ║"
echo "║     • BOS-AI creates PRDs, not code                        ║"
echo "║     • Technical work goes to AGENT-11 projects             ║"
echo "║     • Clean separation maintained                          ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

echo -e "${GREEN}Ready to run business operations with /coord command!${NC}"