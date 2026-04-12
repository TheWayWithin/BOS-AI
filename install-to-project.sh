#!/bin/bash

# BOS-AI Installation Script for Target Projects
# Run this FROM your target project directory to install BOS-AI

set -euo pipefail

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
echo "║   BOS-AI: Business Operating System Installation            ║"
echo "║   Installing to Current Project Directory                   ║"
echo "║                                                              ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Get the directory where this script is located (BOS-AI repo)
BOS_AI_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Get the current directory (target project)
TARGET_DIR="$(pwd)"

# Refuse to install into system directories
case "$TARGET_DIR" in
    /etc*|/usr*|/bin*|/sbin*|/var*|/System*|/)
        echo -e "${RED}ERROR: Refusing to install to system directory: ${TARGET_DIR}${NC}"
        exit 1
        ;;
esac

echo -e "${CYAN}📍 BOS-AI Source: ${BOS_AI_DIR}${NC}"
echo -e "${CYAN}📍 Installing to: ${TARGET_DIR}${NC}"
echo ""

# Confirm installation
read -p "Install BOS-AI to ${TARGET_DIR}? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${RED}Installation cancelled${NC}"
    exit 1
fi

# Create directory structure in target project
echo -e "${GREEN}📁 Creating directory structure...${NC}"
mkdir -p .claude/agents
mkdir -p .claude/commands  
mkdir -p .claude/missions
mkdir -p .claude/document-library
mkdir -p workspace
mkdir -p documents/foundation/prds
mkdir -p documents/operations
mkdir -p documents/archive
mkdir -p documents/assets

# Deploy core documentation with protection
echo -e "${BLUE}📚 Deploying core documentation...${NC}"

# Backup existing .claude/CLAUDE.md if it exists (protect customizations)
if [ -f ".claude/CLAUDE.md" ]; then
    BACKUP_FILE=".claude/CLAUDE.md.backup.$(date +%Y%m%d_%H%M%S)"
    cp .claude/CLAUDE.md "$BACKUP_FILE"
    echo -e "${YELLOW}⚠️  Existing .claude/CLAUDE.md backed up to: $(basename $BACKUP_FILE)${NC}"
    echo -e "${CYAN}   Review backup if you had customizations${NC}"
fi

if [ -f "${BOS_AI_DIR}/CLAUDE.md" ]; then
    cp "${BOS_AI_DIR}/CLAUDE.md" .claude/CLAUDE.md
    echo -e "${GREEN}✅ .claude/CLAUDE.md deployed (BOS-AI system documentation)${NC}"
fi

if [ -f "${BOS_AI_DIR}/BOUNDARIES.md" ]; then
    cp "${BOS_AI_DIR}/BOUNDARIES.md" .claude/
    echo -e "${GREEN}✅ BOUNDARIES.md deployed${NC}"
fi

# Deploy Commands
echo -e "${PURPLE}🎮 Deploying command system...${NC}"
if [ -d "${BOS_AI_DIR}/commands" ]; then
    cp "${BOS_AI_DIR}/commands/"*.md .claude/commands/ 2>/dev/null || true
fi
if [ -d "${BOS_AI_DIR}/.claude/commands" ]; then
    # Also pick up any commands only present in the working-squad mirror
    cp -n "${BOS_AI_DIR}/.claude/commands/"*.md .claude/commands/ 2>/dev/null || true
fi
COMMAND_COUNT=$(ls .claude/commands/*.md 2>/dev/null | wc -l)
echo -e "${GREEN}✅ ${COMMAND_COUNT} commands deployed${NC}"

# Deploy shared voice guide for /dailyreport and /blog
# Lives in .claude/data/ (outside .claude/commands/) so Claude Code does not
# auto-index it as a skill in the command palette.
mkdir -p .claude/data
if [ -f "${BOS_AI_DIR}/data/voice-guide-default.md" ]; then
    cp "${BOS_AI_DIR}/data/voice-guide-default.md" .claude/data/voice-guide-default.md
    echo -e "${GREEN}✅ Default voice guide deployed → .claude/data/voice-guide-default.md${NC}"
fi

# Deploy Document Library Templates and SOPs
echo -e "${CYAN}📚 Deploying Document Library templates and SOPs...${NC}"
if [ -d "${BOS_AI_DIR}/docs/Document Library" ]; then
    # Copy all markdown files from Document Library
    find "${BOS_AI_DIR}/docs/Document Library" -maxdepth 1 -name "*.md" -type f -exec cp {} .claude/document-library/ \;
    
    LIBRARY_COUNT=$(ls .claude/document-library/*.md 2>/dev/null | wc -l)
    if [ "$LIBRARY_COUNT" -gt 0 ]; then
        echo -e "${GREEN}✅ Deployed ${LIBRARY_COUNT} templates and SOPs${NC}"
        
        # List key documents
        echo -e "${PURPLE}   📄 Key documents available:${NC}"
        [ -f ".claude/document-library/Vision and Mission.md" ] && echo -e "${GREEN}      ✓ Vision and Mission template${NC}"
        [ -f ".claude/document-library/Market and Client Research Template.md" ] && echo -e "${GREEN}      ✓ Market Research template${NC}"
        [ -f ".claude/document-library/Client Success Blueprint.md" ] && echo -e "${GREEN}      ✓ Client Success Blueprint template${NC}"
        [ -f ".claude/document-library/Positioning Statement Template.md" ] && echo -e "${GREEN}      ✓ Positioning Statement template${NC}"
        [ -f ".claude/document-library/Strategic Roadmap_ Vision to Great.md" ] && echo -e "${GREEN}      ✓ Strategic Roadmap template${NC}"
        [ -f ".claude/document-library/Brand Style Guide.md" ] && echo -e "${GREEN}      ✓ Brand Style Guide template${NC}"
        [ -f ".claude/document-library/Product Requirements Document (PRD).md" ] && echo -e "${GREEN}      ✓ PRD template${NC}"
        [ -f ".claude/document-library/FILING-STANDARDS.md" ] && echo -e "${GREEN}      ✓ Filing Standards guide${NC}"
    fi
else
    echo -e "${YELLOW}⚠️  Document Library source not found${NC}"
fi

# Deploy Business Agents
echo -e "${BLUE}🤖 Deploying BOS-AI business agents...${NC}"
if [ -d "${BOS_AI_DIR}/.claude/agents" ]; then
    AGENT_COUNT=0
    for agent in "${BOS_AI_DIR}/.claude/agents/"*.md; do
        if [ -f "$agent" ]; then
            filename=$(basename "$agent")
            # Skip README and AGENT-11 technical agents
            if [[ "$filename" == "README.md" ]] || \
               [[ "$filename" =~ ^(developer|tester|architect|designer|operator|documenter|analyst|coordinator|strategist|marketer|support)\.md$ ]]; then
                if [[ "$filename" != "README.md" ]]; then
                    echo -e "${YELLOW}⚠️  Skipping AGENT-11 agent: $filename${NC}"
                fi
            else
                cp "$agent" .claude/agents/
                ((AGENT_COUNT++))
            fi
        fi
    done
    echo -e "${GREEN}✅ Deployed ${AGENT_COUNT} business agents${NC}"
fi

# Deploy Missions
echo -e "${YELLOW}🎯 Deploying business missions...${NC}"
if [ -d "${BOS_AI_DIR}/.claude/missions" ]; then
    MISSION_COUNT=0
    for mission in "${BOS_AI_DIR}/.claude/missions/"*.md; do
        if [ -f "$mission" ]; then
            filename=$(basename "$mission")
            # Skip technical missions
            if [[ ! "$filename" =~ ^mission-(build|deploy|fix|integrate|migrate|optimize|refactor|release|security|document|mvp)\.md$ ]] && \
               [[ "$filename" != "operation-genesis.md" ]]; then
                cp "$mission" .claude/missions/
                ((MISSION_COUNT++))
            fi
        fi
    done
    echo -e "${GREEN}✅ Deployed ${MISSION_COUNT} business missions${NC}"
fi

# Deploy workspace templates
echo -e "${PURPLE}📋 Deploying workspace templates...${NC}"
if [ -d "${BOS_AI_DIR}/workspace" ]; then
    cp "${BOS_AI_DIR}/workspace/"*.md workspace/ 2>/dev/null || true
    WORKSPACE_COUNT=$(ls workspace/*.md 2>/dev/null | wc -l)
    if [ "$WORKSPACE_COUNT" -gt 0 ]; then
        echo -e "${GREEN}✅ Deployed ${WORKSPACE_COUNT} workspace templates${NC}"
    fi
fi

# Check for existing documents
echo -e "${CYAN}📄 Checking for existing business documents...${NC}"
if [ -d "documents/foundation" ]; then
    EXISTING_DOCS=$(find documents/foundation -name "*.md" -type f 2>/dev/null | wc -l)
    if [ "$EXISTING_DOCS" -gt 0 ]; then
        echo -e "${GREEN}✅ Found ${EXISTING_DOCS} existing foundation documents${NC}"
        echo -e "${YELLOW}   ℹ️  Use review missions to update them with templates${NC}"
    fi
fi

# Create initial CLAUDE.md if it doesn't exist in project
if [ ! -f "CLAUDE.md" ]; then
    echo -e "${BLUE}📝 Creating project CLAUDE.md...${NC}"
    cat > CLAUDE.md << 'EOF'
# Project Instructions

This project uses BOS-AI for business operations management.

## BOS-AI System
- Templates: `.claude/document-library/`
- Agents: `.claude/agents/`
- Missions: `.claude/missions/`
- Your Documents: `documents/foundation/`

## Quick Start
- Use `/coord` for business orchestration
- Use `/meeting @agent` for specific consultations
- Review templates in `.claude/document-library/`

## Foundation Documents
Create or update your foundation documents using the templates and SOPs provided.
EOF
    echo -e "${GREEN}✅ Created project CLAUDE.md${NC}"
fi

# Summary
echo -e "${BLUE}"
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                  INSTALLATION COMPLETE                       ║"
echo "╠══════════════════════════════════════════════════════════════╣"
printf "║  ✅ Document Library: %-3s templates & SOPs              ║\n" "$LIBRARY_COUNT"
printf "║  ✅ Business Agents: %-3s agents installed               ║\n" "$AGENT_COUNT"
printf "║  ✅ Business Missions: %-3s missions available            ║\n" "$MISSION_COUNT"
printf "║  ✅ Commands: %-3s command files                          ║\n" "$COMMAND_COUNT"
printf "║  ✅ Workspace: %-3s context templates                     ║\n" "$WORKSPACE_COUNT"
echo "║  ✅ Directory Structure: All folders created                ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

echo -e "${GREEN}📁 Directory Structure Created:${NC}"
echo "  • .claude/document-library/ → Templates & SOPs"
echo "  • .claude/agents/          → Business agents"
echo "  • .claude/missions/        → Business missions"
echo "  • documents/foundation/    → Your business documents"
echo "  • documents/operations/    → Operational bibles"
echo "  • documents/archive/       → Version history"
echo "  • workspace/               → Mission context"

echo ""
echo -e "${CYAN}🚀 Next Steps:${NC}"
echo "  1. Open Claude and navigate to this project"
echo "  2. Use /coord to start business orchestration"
echo "  3. Create foundation documents using templates"
echo "  4. Run quarterly reviews to keep documents current"

echo ""
echo -e "${GREEN}✅ BOS-AI successfully installed to ${TARGET_DIR}${NC}"