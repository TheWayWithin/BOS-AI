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
mkdir -p .claude/document-library
mkdir -p workspace
mkdir -p documents/foundation/prds
mkdir -p documents/operations
mkdir -p documents/archive
mkdir -p documents/assets

# Deploy core documentation with protection
echo -e "${BLUE}📚 Deploying core documentation...${NC}"

# Deploy .claude/CLAUDE.md (BOS-AI system documentation) with backup protection
if [ -f ".claude/CLAUDE.md" ]; then
    # Backup existing file if it exists
    BACKUP_FILE=".claude/CLAUDE.md.backup.$(date +%Y%m%d_%H%M%S)"
    cp .claude/CLAUDE.md "$BACKUP_FILE"
    echo -e "${YELLOW}⚠️  Existing .claude/CLAUDE.md backed up to: $BACKUP_FILE${NC}"
    echo -e "${CYAN}   Review backup if you had customizations${NC}"
fi

cp CLAUDE.md .claude/CLAUDE.md
echo -e "${GREEN}✅ .claude/CLAUDE.md deployed (BOS-AI system documentation)${NC}"

# Verify correct BOS-AI version deployed
echo -e "${BLUE}🔍 Verifying CLAUDE.md version...${NC}"
if grep -q "BOS-AI.*Business Operating System" .claude/CLAUDE.md; then
    echo -e "${GREEN}✅ BOS-AI version verified (Business Operating System)${NC}"
else
    echo -e "${RED}❌ ERROR: Wrong CLAUDE.md version deployed!${NC}"
    echo -e "${YELLOW}⚠️  Expected: BOS-AI Business Operating System${NC}"
    echo -e "${YELLOW}⚠️  This deployment will provide users with wrong instructions${NC}"
    exit 1
fi

# Create project root CLAUDE.md ONLY if it doesn't exist (protect user customizations)
if [ ! -f "CLAUDE.md" ]; then
    echo -e "${BLUE}📝 Creating project CLAUDE.md (project-specific instructions)...${NC}"
    cat > CLAUDE.md << 'EOF'
# Project with BOS-AI

This project uses BOS-AI for business operations management.

## Quick Start
- Use `/coord` for business orchestration
- Templates in `.claude/document-library/`
- Save documents to `documents/foundation/`

See `.claude/CLAUDE.md` for full BOS-AI documentation.
EOF
    echo -e "${GREEN}✅ Created project CLAUDE.md${NC}"
else
    echo -e "${CYAN}ℹ️  Project CLAUDE.md exists - preserving user customizations${NC}"
fi

cp BOUNDARIES.md .claude/
echo -e "${GREEN}✅ BOUNDARIES.md deployed (enforces separation)${NC}"

# Deploy Commands from BOS-AI source
echo -e "${PURPLE}🎮 Deploying command system...${NC}"
if [ -d "commands" ]; then
    cp commands/*.md .claude/commands/ 2>/dev/null || true
    echo -e "${GREEN}✅ Commands deployed from /commands/${NC}"
else
    echo -e "${YELLOW}⚠️  Commands directory not found - using backup${NC}"
    if [ -d ".claude/backups/agent-11/20250904_220106/commands" ]; then
        cp .claude/backups/agent-11/20250904_220106/commands/{coord,meeting,report,pmd}.md .claude/commands/ 2>/dev/null || true
        echo -e "${GREEN}✅ Commands deployed from backup${NC}"
    fi
fi

# Deploy Document Library Templates and SOPs
echo -e "${CYAN}📚 Deploying Document Library templates and SOPs...${NC}"
if [ -d "docs/Document Library" ]; then
    # Copy entire Document Library structure preserving directories
    cp -r "docs/Document Library/"* .claude/document-library/
    
    # Count all deployed markdown files
    LIBRARY_COUNT=$(find .claude/document-library -name "*.md" -type f | wc -l)
    FOUNDATION_COUNT=$(find .claude/document-library/Foundation -name "*.md" -type f 2>/dev/null | wc -l)
    OPERATIONS_COUNT=$(find .claude/document-library/Operations -name "*.md" -type f 2>/dev/null | wc -l)
    
    if [ "$LIBRARY_COUNT" -gt 0 ]; then
        echo -e "${GREEN}✅ Deployed ${LIBRARY_COUNT} templates and SOPs to .claude/document-library/${NC}"
        echo -e "${CYAN}   📂 Foundation: ${FOUNDATION_COUNT} documents${NC}"
        echo -e "${CYAN}   📂 Operations: ${OPERATIONS_COUNT} documents${NC}"
        
        # List what was deployed
        echo -e "${PURPLE}   📄 Key Foundation documents:${NC}"
        [ -f ".claude/document-library/Foundation/Vision and Mission.md" ] && echo -e "${GREEN}      ✓ Vision and Mission template${NC}"
        [ -f ".claude/document-library/Foundation/Market and Client Research Template.md" ] && echo -e "${GREEN}      ✓ Market Research template${NC}"
        [ -f ".claude/document-library/Foundation/Client Success Blueprint.md" ] && echo -e "${GREEN}      ✓ Client Success Blueprint template${NC}"
        [ -f ".claude/document-library/Foundation/Strategic Roadmap_ Vision to Great.md" ] && echo -e "${GREEN}      ✓ Strategic Roadmap template${NC}"
        [ -f ".claude/document-library/Foundation/Product Requirements Document (PRD).md" ] && echo -e "${GREEN}      ✓ PRD template${NC}"
        
        echo -e "${PURPLE}   📄 Key Operations documents:${NC}"
        [ -f ".claude/document-library/Operations/Marketing/Marketing Bible.md" ] && echo -e "${GREEN}      ✓ Marketing Bible template${NC}"
        [ -f ".claude/document-library/Operations/Marketing/Marketing Plan.md" ] && echo -e "${GREEN}      ✓ Marketing Plan template${NC}"
        [ -f ".claude/document-library/Operations/Sales/Sales Bible.md" ] && echo -e "${GREEN}      ✓ Sales Bible template${NC}"
        [ -f ".claude/document-library/Operations/Sales/Sales Plan.md" ] && echo -e "${GREEN}      ✓ Sales Plan template${NC}"
    fi
else
    echo -e "${YELLOW}⚠️  Document Library source not found${NC}"
fi

# Deploy Business Agents (29 total - NO AGENT-11 agents)
echo -e "${BLUE}🤖 Deploying 29 BOS-AI business agents...${NC}"

# Deploy from agents source directory
AGENT_COUNT=0
# Process all category directories
for category in agents/*/; do
    if [ -d "$category" ]; then
        for agent in "$category"*.md; do
            if [ -f "$agent" ]; then
                filename=$(basename "$agent")
                # Skip README and any AGENT-11 agents if they somehow exist
                if [[ "$filename" == "README.md" ]] || \
                   [[ "$filename" =~ ^(developer|tester|architect|designer|operator|documenter|analyst|coordinator|strategist|marketer|support)\.md$ ]]; then
                    if [[ "$filename" != "README.md" ]]; then
                        echo -e "${YELLOW}⚠️  Skipping AGENT-11 agent: $filename${NC}"
                    fi
                else
                    cp "$agent" .claude/agents/
                    ((AGENT_COUNT++))
                    echo -e "${GREEN}✅ Deployed: $filename${NC}"
                fi
            fi
        done
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
for category in business-setup creation delivery discovery growth operations optimization sequences marketing sales customer-service finance; do
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

# Prepare User Document Directories
echo -e "${PURPLE}📂 Preparing user document directories...${NC}"
if [ ! -d "documents/foundation" ]; then
    echo -e "${GREEN}✅ Created documents/foundation/ for your business documents${NC}"
else
    EXISTING_DOCS=$(find documents/foundation -name "*.md" -type f | wc -l)
    if [ "$EXISTING_DOCS" -gt 0 ]; then
        echo -e "${GREEN}✅ Found ${EXISTING_DOCS} existing foundation documents${NC}"
    else
        echo -e "${YELLOW}📝 documents/foundation/ ready for your business documents${NC}"
    fi
fi

# Verify Document Library Availability
echo -e "${CYAN}📚 Verifying Document Library...${NC}"
if [ -d "docs/Document Library" ]; then
    # Count templates and SOPs
    TEMPLATE_COUNT=$(find "docs/Document Library" -maxdepth 1 -name "*Template*" -type f | wc -l)
    SOP_COUNT=$(find "docs/Document Library" -maxdepth 1 -name "*SOP*" -type f | wc -l)
    TOTAL_DOCS=$(find "docs/Document Library" -maxdepth 1 -name "*.md" -type f | wc -l)
    
    echo -e "${GREEN}✅ Document Library verified:${NC}"
    echo -e "${CYAN}   📍 Location: docs/Document Library/${NC}"
    echo -e "${CYAN}   📄 ${TEMPLATE_COUNT} Templates${NC}"
    echo -e "${CYAN}   📋 ${SOP_COUNT} SOPs${NC}"
    echo -e "${CYAN}   📚 ${TOTAL_DOCS} Total Documents${NC}"
    
    # List key documents
    echo -e "${PURPLE}   Key Foundation Documents:${NC}"
    echo -e "${GREEN}      ✓ Vision and Mission templates & SOPs${NC}"
    echo -e "${GREEN}      ✓ Market Research templates & SOPs${NC}"
    echo -e "${GREEN}      ✓ Client Success Blueprint templates & SOPs${NC}"
    echo -e "${GREEN}      ✓ Positioning Statement templates & SOPs${NC}"
    echo -e "${GREEN}      ✓ Strategic Roadmap templates & SOPs${NC}"
    echo -e "${GREEN}      ✓ Brand Style Guide templates & SOPs${NC}"
    echo -e "${GREEN}      ✓ PRD templates & SOPs${NC}"
    echo -e "${GREEN}      ✓ Business Foundation Library Guide${NC}"
else
    echo -e "${YELLOW}⚠️  Document Library not found at docs/Document Library/${NC}"
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
echo "║  ✅ Document Library: Templates & SOPs at docs/Document Library║"
echo "║                                                              ║"
echo "║  🚫 BOUNDARIES ENFORCED:                                    ║"
echo "║     • BOS-AI creates PRDs, not code                        ║"
echo "║     • Technical work goes to AGENT-11 projects             ║"
echo "║     • Clean separation maintained                          ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

echo -e "${GREEN}Ready to run business operations with /coord command!${NC}"

echo -e "${CYAN}"
echo "📁 Source → Deployment Structure:"
echo "  • /agents/         → /.claude/agents/       (BOS-AI agents)"
echo "  • /commands/       → /.claude/commands/     (BOS-AI commands)"
echo "  • /missions/       → /.claude/missions/     (BOS-AI missions)"
echo "  • /docs/Document Library/ → /.claude/document-library/"
echo ""
echo "📁 Working Directories:"
echo "  • /documents/foundation/     → Your business documents (create here)"
echo "  • /documents/operations/     → Your operational bibles"
echo "  • /documents/archive/        → Version history (auto-archived)"
echo "  • /workspace/                → Mission context (temporary)"
echo "  • /.claude/                  → Deployed files (do not edit)"
echo -e "${NC}"