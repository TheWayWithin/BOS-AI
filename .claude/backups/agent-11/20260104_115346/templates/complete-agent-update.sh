#!/bin/bash

# Complete BOS-AI Agent Update Script
# Ensures all agents have memory integration, thinking modes, and tool permissions

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

echo -e "${BLUE}🔧 Complete BOS-AI Agent Update - Claude Code SDK Integration${NC}"
echo "================================================================="

# Function to add memory integration if missing
add_memory_integration() {
    local agent_file="$1"
    local agent_category="$2"
    local agent_name=$(basename "$agent_file" .md)
    
    if ! grep -q "MEMORY INTEGRATION PROTOCOL" "$agent_file"; then
        echo "  Adding memory integration to $agent_name"
        
        # Create memory integration block based on category
        local memory_block=""
        case "$agent_category" in
            "coordination")
                memory_block="
MEMORY INTEGRATION PROTOCOL:
**MANDATORY**: Before any strategic coordination or business decision, read relevant memory files to leverage accumulated business intelligence and prevent repeating past mistakes.

Essential Memory Access:
- \`/memories/business/vision.xml\` - Strategic objectives and business model alignment
- \`/memories/business/operations.xml\` - Operational performance and coordination history
- \`/memories/strategies/growth.xml\` - Growth strategies requiring coordination
- \`/memories/lessons/decisions.xml\` - Strategic decision history and outcomes
- \`/memories/lessons/patterns.xml\` - Coordination effectiveness patterns

Memory Update Responsibilities:
- Document coordination decisions and outcomes in decisions.xml
- Update operational performance patterns in operations.xml
- Record successful coordination strategies in growth.xml
- Log coordination challenges and solutions in failures.xml

Cross-Session Learning: Reference historical coordination challenges, successful multi-agent workflows, resource allocation decisions, and strategic alignment patterns to optimize current coordination activities."
                ;;
            "marketing")
                memory_block="
MEMORY INTEGRATION PROTOCOL:
**MANDATORY**: Before any marketing strategy or campaign decision, read relevant memory files to leverage accumulated marketing intelligence and prevent repeating past mistakes.

Essential Memory Access:
- \`/memories/business/customers.xml\` - Customer personas and journey insights
- \`/memories/business/markets.xml\` - Market positioning and competitive intelligence
- \`/memories/strategies/marketing.xml\` - Marketing campaign performance and strategies
- \`/memories/strategies/failures.xml\` - Marketing failures and lessons learned
- \`/memories/lessons/patterns.xml\` - Customer behavior and campaign performance patterns

Memory Update Responsibilities:
- Document marketing strategies and campaign outcomes in marketing.xml
- Update customer journey and persona insights in customers.xml
- Record marketing insights and brand performance in insights.xml
- Log failed marketing approaches and prevention strategies in failures.xml

Cross-Session Learning: Reference historical marketing campaigns, customer response patterns, competitive positioning strategies, and campaign performance data to optimize current marketing activities."
                ;;
            "sales")
                memory_block="
MEMORY INTEGRATION PROTOCOL:
**MANDATORY**: Before any sales strategy or pipeline decision, read relevant memory files to leverage accumulated sales intelligence and prevent repeating past mistakes.

Essential Memory Access:
- \`/memories/business/customers.xml\` - Customer personas and buying behavior patterns
- \`/memories/strategies/sales.xml\` - Sales approaches and conversion strategies
- \`/memories/strategies/marketing.xml\` - Lead generation and qualification insights
- \`/memories/strategies/failures.xml\` - Sales failures and lessons learned
- \`/memories/lessons/patterns.xml\` - Sales cycle and conversion patterns

Memory Update Responsibilities:
- Document sales strategies and conversion outcomes in sales.xml
- Update customer buying behavior and pipeline insights in customers.xml
- Record successful sales processes and qualification approaches in insights.xml
- Log failed sales strategies and prevention methods in failures.xml

Cross-Session Learning: Reference historical sales performance, customer conversion patterns, pipeline optimization strategies, and qualification frameworks to optimize current sales activities."
                ;;
            "financial")
                memory_block="
MEMORY INTEGRATION PROTOCOL:
**MANDATORY**: Before any financial analysis or planning decision, read relevant memory files to leverage accumulated financial intelligence and prevent repeating past mistakes.

Essential Memory Access:
- \`/memories/business/vision.xml\` - Financial objectives and business model
- \`/memories/business/operations.xml\` - Financial performance and budget history
- \`/memories/strategies/growth.xml\` - Investment and growth financial strategies
- \`/memories/lessons/decisions.xml\` - Financial decision history and outcomes
- \`/memories/lessons/patterns.xml\` - Financial performance patterns

Memory Update Responsibilities:
- Document financial strategies and outcomes in decisions.xml
- Update financial performance patterns in operations.xml
- Record investment strategies and results in growth.xml
- Log financial failures and lessons in failures.xml

Cross-Session Learning: Reference historical financial performance, investment decisions, budget optimization strategies, and financial patterns to optimize current financial activities."
                ;;
            *)
                memory_block="
MEMORY INTEGRATION PROTOCOL:
**MANDATORY**: Before any business decision or strategy development, read relevant memory files to leverage accumulated business intelligence and prevent repeating past mistakes.

Essential Memory Access:
- \`/memories/business/vision.xml\` - Business objectives and strategic alignment
- \`/memories/business/operations.xml\` - Operational performance and procedures
- \`/memories/strategies/growth.xml\` - Growth strategies relevant to domain
- \`/memories/lessons/insights.xml\` - Cross-functional business insights
- \`/memories/lessons/patterns.xml\` - Business patterns affecting domain work

Memory Update Responsibilities:
- Document domain-specific strategies and outcomes in relevant strategy files
- Update operational insights in operations.xml
- Record successful approaches in insights.xml
- Log failures and prevention strategies in failures.xml

Cross-Session Learning: Reference historical context, successful strategies, failure patterns, and business insights to optimize current domain activities."
                ;;
        esac
        
        # Find insertion point and add memory integration
        if grep -q "SUCCESS METRICS:" "$agent_file"; then
            # Add after SUCCESS METRICS section
            awk -v memory_block="$memory_block" '
                /SUCCESS METRICS:/ {
                    print
                    while ((getline) && !/^$/) print
                    print memory_block
                    print ""
                    next
                }
                { print }
            ' "$agent_file" > "$agent_file.tmp" && mv "$agent_file.tmp" "$agent_file"
        else
            # Add at end of file
            echo -e "\n$memory_block" >> "$agent_file"
        fi
        
        echo "    ✓ Memory integration added"
    else
        echo "  $agent_name: ✓ Already has memory integration"
    fi
}

# Process all agent categories
echo -e "\n${GREEN}Updating Agent Memory Integration:${NC}"

for category_dir in "$AGENTS_DIR"/*/; do
    if [ -d "$category_dir" ]; then
        category=$(basename "$category_dir")
        echo -e "\n${YELLOW}Processing $category agents:${NC}"
        
        for agent_file in "$category_dir"*.md; do
            if [ -f "$agent_file" ]; then
                add_memory_integration "$agent_file" "$category"
            fi
        done
    fi
done

# Verify thinking modes are present
echo -e "\n${GREEN}Verifying Thinking Modes:${NC}"
missing_thinking=0
for agent_file in "$AGENTS_DIR"/*/*.md; do
    if [ -f "$agent_file" ]; then
        agent_name=$(basename "$agent_file" .md)
        if ! grep -q "thinking_mode:" "$agent_file"; then
            echo "  ⚠️ $agent_name: Missing thinking_mode"
            ((missing_thinking++))
        fi
    fi
done

if [ $missing_thinking -eq 0 ]; then
    echo "  ✓ All agents have thinking modes assigned"
else
    echo "  ⚠️ $missing_thinking agents missing thinking modes"
fi

# Verify tool permissions are present
echo -e "\n${GREEN}Verifying Tool Permissions:${NC}"
missing_tools=0
for agent_file in "$AGENTS_DIR"/*/*.md; do
    if [ -f "$agent_file" ]; then
        agent_name=$(basename "$agent_file" .md)
        if ! grep -q "tools:" "$agent_file"; then
            echo "  ⚠️ $agent_name: Missing tools declaration"
            ((missing_tools++))
        fi
    fi
done

if [ $missing_tools -eq 0 ]; then
    echo "  ✓ All agents have tool permissions configured"
else
    echo "  ⚠️ $missing_tools agents missing tool permissions"
fi

# Count agents by enhancement status
total_agents=$(find "$AGENTS_DIR" -name "*.md" | wc -l)
memory_agents=$(grep -l "MEMORY INTEGRATION PROTOCOL" "$AGENTS_DIR"/*/*.md | wc -l)
thinking_agents=$(grep -l "thinking_mode:" "$AGENTS_DIR"/*/*.md | wc -l)

echo -e "\n${GREEN}✅ Agent Enhancement Status:${NC}"
echo "================================================================="
echo -e "📊 Total agents: ${BLUE}$total_agents${NC}"
echo -e "🧠 Memory integration: ${BLUE}$memory_agents${NC}/$total_agents"
echo -e "🤔 Thinking modes: ${BLUE}$thinking_agents${NC}/$total_agents"
echo -e "🔧 Tool permissions: ${BLUE}$((total_agents - missing_tools))${NC}/$total_agents"

if [ $memory_agents -eq $total_agents ] && [ $thinking_agents -eq $total_agents ] && [ $missing_tools -eq 0 ]; then
    echo -e "\n${GREEN}🚀 All agents fully enhanced with Claude Code SDK integrations!${NC}"
else
    echo -e "\n${YELLOW}⚠️ Some agents need additional updates. Run specific update scripts if needed.${NC}"
fi

echo -e "\n${BLUE}Next Steps:${NC}"
echo "1. Run ./templates/update-thinking-modes.sh if thinking modes are missing"
echo "2. Run ./templates/update-tool-permissions.sh if tool permissions need updates"
echo "3. Review and update missions with new Task delegation patterns"
echo "4. Test agent functionality with memory integration"