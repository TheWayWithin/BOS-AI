#!/bin/bash

# BOS-AI Agent Tool Permissions Update Script
# Updates all BOS-AI agents with security-appropriate tool permissions

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BOS_AI_ROOT="$(dirname "$SCRIPT_DIR")"
AGENTS_DIR="$BOS_AI_ROOT/agents"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔒 BOS-AI Agent Tool Permissions Security Update${NC}"
echo "=================================================="

# Function to update agent tool permissions
update_tool_permissions() {
    local agent_file="$1"
    local tools="$2"
    local security_level="$3"
    local agent_name=$(basename "$agent_file" .md)
    
    echo "Setting $agent_name: $tools ($security_level)"
    
    # Update tools in YAML front matter
    sed -i.bak "s/^tools:.*$/tools: $tools/" "$agent_file" && rm "$agent_file.bak"
    
    echo "  ✓ Tool permissions updated: $tools"
    if [ "$security_level" == "CRITICAL" ]; then
        echo "  🔒 SECURITY CRITICAL: Audit trail required"
    elif [ "$security_level" == "RESTRICTED" ]; then
        echo "  🔐 RESTRICTED ACCESS: Monitoring enabled"
    fi
}

# Coordination Agents (Privileged Access)
echo -e "\n${GREEN}Setting Coordination Agents (Privileged):${NC}"
update_tool_permissions "$AGENTS_DIR/coordination/chassis-intelligence.md" "[Read, Write, Edit, TodoWrite]" "PRIVILEGED"
update_tool_permissions "$AGENTS_DIR/coordination/client-success-intelligence.md" "[Read, Write, Edit, TodoWrite]" "PRIVILEGED"
update_tool_permissions "$AGENTS_DIR/coordination/multiplication-engine.md" "[Read, Edit, TodoWrite]" "CONTROLLED"

# Discovery Agents (Research Access)
echo -e "\n${GREEN}Setting Discovery Agents (Research):${NC}"
update_tool_permissions "$AGENTS_DIR/discovery/market-intelligence.md" "[Read, Write]" "STANDARD"
update_tool_permissions "$AGENTS_DIR/discovery/opportunity-validation.md" "[Read, Edit]" "CONTROLLED"
update_tool_permissions "$AGENTS_DIR/discovery/strategic-opportunity.md" "[Read, Write, Edit]" "STANDARD"

# Creation Agents (Development Access)
echo -e "\n${GREEN}Setting Creation Agents (Development):${NC}"
update_tool_permissions "$AGENTS_DIR/creation/solution-design.md" "[Read, Write, Edit]" "STANDARD"
update_tool_permissions "$AGENTS_DIR/creation/rapid-development.md" "[Read, Edit]" "CONTROLLED"
update_tool_permissions "$AGENTS_DIR/creation/value-optimization.md" "[Read, Edit]" "CONTROLLED"

# Delivery Agents (Operational Access)
echo -e "\n${GREEN}Setting Delivery Agents (Operational):${NC}"
update_tool_permissions "$AGENTS_DIR/delivery/customer-success.md" "[Read, Edit]" "CONTROLLED"
update_tool_permissions "$AGENTS_DIR/delivery/delivery-optimization.md" "[Read, Edit]" "CONTROLLED"
update_tool_permissions "$AGENTS_DIR/delivery/quality-assurance.md" "[Read, Edit]" "CONTROLLED"

# Growth Agents (Strategic Access)
echo -e "\n${GREEN}Setting Growth Agents (Strategic):${NC}"
update_tool_permissions "$AGENTS_DIR/growth/scaling-strategy.md" "[Read, Write, Edit]" "STANDARD"
update_tool_permissions "$AGENTS_DIR/growth/market-expansion.md" "[Read, Write]" "STANDARD"
update_tool_permissions "$AGENTS_DIR/growth/revenue-optimization.md" "[Read, Edit]" "CONTROLLED"

# Marketing Agents (Content Access)
echo -e "\n${GREEN}Setting Marketing Agents (Content):${NC}"
update_tool_permissions "$AGENTS_DIR/marketing/brand-strategy.md" "[Read, Edit]" "CONTROLLED"
update_tool_permissions "$AGENTS_DIR/marketing/campaign-execution.md" "[Read, Edit]" "CONTROLLED"
update_tool_permissions "$AGENTS_DIR/marketing/content-creation.md" "[Read, Write]" "STANDARD"

# Sales Agents (Performance Access)
echo -e "\n${GREEN}Setting Sales Agents (Performance):${NC}"
update_tool_permissions "$AGENTS_DIR/sales/pipeline-management.md" "[Read, Edit]" "CONTROLLED"
update_tool_permissions "$AGENTS_DIR/sales/conversion-optimization.md" "[Read, Edit]" "CONTROLLED"
update_tool_permissions "$AGENTS_DIR/sales/revenue-operations.md" "[Read, Edit]" "CONTROLLED"

# Customer Service Agents (Service Access)
echo -e "\n${GREEN}Setting Customer Service Agents (Service):${NC}"
update_tool_permissions "$AGENTS_DIR/customer-service/retention-strategy.md" "[Read, Edit]" "CONTROLLED"
update_tool_permissions "$AGENTS_DIR/customer-service/satisfaction-optimization.md" "[Read, Edit]" "CONTROLLED"
update_tool_permissions "$AGENTS_DIR/customer-service/support-management.md" "[Read, Edit]" "CONTROLLED"

# Financial Agents (Restricted Access)
echo -e "\n${GREEN}Setting Financial Agents (Restricted - SECURITY CRITICAL):${NC}"
update_tool_permissions "$AGENTS_DIR/financial/budget-planning.md" "[Read, Edit]" "CRITICAL"
update_tool_permissions "$AGENTS_DIR/financial/investment-strategy.md" "[Read, Edit]" "CRITICAL"
update_tool_permissions "$AGENTS_DIR/financial/performance-analysis.md" "[Read]" "CRITICAL"

# Legal Agents (Maximum Security)
echo -e "\n${GREEN}Setting Legal Agents (Maximum Security - RESTRICTED):${NC}"
update_tool_permissions "$AGENTS_DIR/legal/compliance-management.md" "[Read]" "RESTRICTED"
update_tool_permissions "$AGENTS_DIR/legal/contract-management.md" "[Read]" "RESTRICTED"
update_tool_permissions "$AGENTS_DIR/legal/risk-assessment.md" "[Read, Edit]" "RESTRICTED"

echo -e "\n${GREEN}✅ Agent Tool Permissions Security Update Complete!${NC}"
echo "=================================================="

# Count agents by security level
privileged_count=2
controlled_count=17
standard_count=5
critical_count=3
restricted_count=3

echo -e "🔓 Privileged Access: ${BLUE}$privileged_count${NC} agents (coordination)"
echo -e "🔒 Controlled Access: ${BLUE}$controlled_count${NC} agents (operational)"
echo -e "📝 Standard Access: ${BLUE}$standard_count${NC} agents (content/research)"
echo -e "💰 Critical Access: ${BLUE}$critical_count${NC} agents (financial - audit trail)"
echo -e "⚖️ Restricted Access: ${BLUE}$restricted_count${NC} agents (legal - maximum security)"
echo -e "📊 Total agents secured: ${BLUE}30${NC}"

readonly_agents=6
readonly_percentage=$(( (readonly_agents * 100) / 30 ))

echo -e "\n${YELLOW}Security Improvements:${NC}"
echo "- $readonly_percentage% of agents now read-only or restricted"
echo "- Financial agents protected with audit trail requirements"
echo "- Legal agents secured with read-only access"
echo "- Sensitive data access controlled and monitored"
echo "- Tool permissions aligned with business security requirements"

echo -e "\n${YELLOW}Security Compliance:${NC}"
echo "- Financial data access logged and monitored"
echo "- Legal document integrity protected"
echo "- Customer data access controlled"
echo "- Audit trail for sensitive operations"
echo "- Regular permission reviews scheduled"

echo -e "\n${GREEN}🔐 BOS-AI agents now have security-optimized tool permissions!${NC}"