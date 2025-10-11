#!/bin/bash

# BOS-AI Agent Memory Integration Update Script
# Updates all BOS-AI agents to include memory integration protocols

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

echo -e "${BLUE}🔧 BOS-AI Agent Memory Integration Update${NC}"
echo "=============================================="

# Function to add memory integration to an agent file
add_memory_integration() {
    local agent_file="$1"
    local agent_category="$2"
    local agent_name=$(basename "$agent_file" .md)
    
    echo "Updating: $agent_name ($agent_category)"
    
    # Check if already has memory integration
    if grep -q "MEMORY INTEGRATION PROTOCOL" "$agent_file"; then
        echo "  ✓ Already has memory integration, skipping"
        return
    fi
    
    # Find where to insert (after SUCCESS METRICS or similar section)
    local insert_after=""
    if grep -q "SUCCESS METRICS:" "$agent_file"; then
        insert_after="SUCCESS METRICS:"
    elif grep -q "## Success Metrics" "$agent_file"; then
        insert_after="## Success Metrics"
    elif grep -q "CORE RESPONSIBILITY:" "$agent_file"; then
        insert_after="CORE RESPONSIBILITY:"
    elif grep -q "## Core Responsibility" "$agent_file"; then
        insert_after="## Core Responsibility"
    else
        echo "  ⚠️ Could not find insertion point, adding at end"
        insert_after=""
    fi
    
    # Define domain-specific memory configurations
    local memory_config=""
    case "$agent_category" in
        "coordination")
            memory_config="
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
- Log coordination challenges and solutions in failures.xml"
            ;;
        "discovery")
            memory_config="
Essential Memory Access:
- \`/memories/business/markets.xml\` - Market intelligence and competitive landscape
- \`/memories/business/customers.xml\` - Customer insights and behavior patterns
- \`/memories/strategies/growth.xml\` - Market expansion and opportunity strategies
- \`/memories/lessons/insights.xml\` - Market and customer discovery insights
- \`/memories/lessons/patterns.xml\` - Market cycle and customer behavior patterns

Memory Update Responsibilities:
- Document market research findings in markets.xml
- Update customer insights and personas in customers.xml
- Record discovery methodologies and outcomes in insights.xml
- Capture market patterns and trends in patterns.xml"
            ;;
        "marketing")
            memory_config="
Essential Memory Access:
- \`/memories/business/customers.xml\` - Customer personas and journey insights
- \`/memories/business/markets.xml\` - Market positioning and competitive intelligence
- \`/memories/strategies/marketing.xml\` - Marketing campaign performance and strategies
- \`/memories/strategies/failures.xml\` - Marketing failures and lessons learned
- \`/memories/lessons/patterns.xml\` - Customer behavior and campaign performance patterns

Memory Update Responsibilities:
- Document campaign performance and outcomes in marketing.xml
- Update customer journey and persona insights in customers.xml
- Record marketing strategies and results in insights.xml
- Log failed marketing approaches in failures.xml"
            ;;
        "sales")
            memory_config="
Essential Memory Access:
- \`/memories/business/customers.xml\` - Customer personas and buying behavior
- \`/memories/strategies/sales.xml\` - Sales approaches and conversion strategies
- \`/memories/strategies/marketing.xml\` - Lead generation and qualification insights
- \`/memories/strategies/failures.xml\` - Sales failures and lessons learned
- \`/memories/lessons/patterns.xml\` - Sales cycle and conversion patterns

Memory Update Responsibilities:
- Document sales strategies and conversion outcomes in sales.xml
- Update customer buying behavior insights in customers.xml
- Record successful sales approaches in insights.xml
- Log failed sales strategies and prevention in failures.xml"
            ;;
        "customer-service")
            memory_config="
Essential Memory Access:
- \`/memories/business/customers.xml\` - Customer satisfaction and retention data
- \`/memories/business/operations.xml\` - Service delivery and quality metrics
- \`/memories/strategies/failures.xml\` - Service failures and recovery strategies
- \`/memories/lessons/insights.xml\` - Customer service insights and improvements
- \`/memories/lessons/patterns.xml\` - Customer satisfaction and retention patterns

Memory Update Responsibilities:
- Document service delivery improvements in operations.xml
- Update customer satisfaction insights in customers.xml
- Record service recovery strategies in insights.xml
- Log service failures and prevention strategies in failures.xml"
            ;;
        "financial")
            memory_config="
Essential Memory Access:
- \`/memories/business/vision.xml\` - Financial objectives and business model
- \`/memories/business/operations.xml\` - Financial performance and budget history
- \`/memories/strategies/growth.xml\` - Investment and growth financial strategies
- \`/memories/lessons/decisions.xml\` - Financial decision history and outcomes
- \`/memories/lessons/patterns.xml\` - Financial performance and investment patterns

Memory Update Responsibilities:
- Document financial strategies and outcomes in decisions.xml
- Update financial performance patterns in operations.xml
- Record investment strategies and results in growth.xml
- Log financial failures and lessons in failures.xml"
            ;;
        *)
            memory_config="
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
- Log failures and prevention strategies in failures.xml"
            ;;
    esac
    
    # Create the memory integration block
    local memory_block="
MEMORY INTEGRATION PROTOCOL:
**MANDATORY**: Before any business decision or strategy development, read relevant memory files to leverage accumulated business intelligence and prevent repeating past mistakes.
$memory_config

Cross-Session Learning: Reference historical context, successful strategies, failure patterns, and business insights to optimize current domain activities and contribute to institutional learning."
    
    # Add the memory integration block
    if [ -n "$insert_after" ]; then
        # Find the line with the insertion point and add after its section
        awk -v insert_after="$insert_after" -v memory_block="$memory_block" '
            {
                print $0
                if ($0 ~ insert_after) {
                    # Skip forward to find the end of this section
                    while ((getline next_line) > 0) {
                        print next_line
                        # If we hit a blank line followed by a new section, insert here
                        if (next_line == "" && (getline after_blank) > 0) {
                            if (after_blank ~ /^(##|[A-Z][A-Z_]+:)/) {
                                print memory_block
                                print ""
                                print after_blank
                                break
                            } else {
                                print after_blank
                            }
                        }
                    }
                }
            }
        ' "$agent_file" > "$agent_file.tmp" && mv "$agent_file.tmp" "$agent_file"
    else
        # Add at the end of the file
        echo -e "\n$memory_block" >> "$agent_file"
    fi
    
    echo "  ✓ Memory integration added"
}

# Update all agent categories
categories=("coordination" "creation" "customer-service" "delivery" "discovery" "financial" "growth" "legal" "marketing" "sales")

total_updated=0
total_skipped=0

for category in "${categories[@]}"; do
    if [ -d "$AGENTS_DIR/$category" ]; then
        echo -e "\n${GREEN}Processing $category agents:${NC}"
        for agent_file in "$AGENTS_DIR/$category"/*.md; do
            if [ -f "$agent_file" ]; then
                if grep -q "MEMORY INTEGRATION PROTOCOL" "$agent_file"; then
                    echo "  $(basename "$agent_file" .md): ✓ Already integrated"
                    ((total_skipped++))
                else
                    add_memory_integration "$agent_file" "$category"
                    ((total_updated++))
                fi
            fi
        done
    fi
done

echo -e "\n${GREEN}✅ Agent Memory Integration Complete!${NC}"
echo "=============================================="
echo -e "📊 Agents updated: ${BLUE}$total_updated${NC}"
echo -e "📊 Agents skipped (already integrated): ${BLUE}$total_skipped${NC}"
echo -e "🧠 All BOS-AI agents now have access to business memory intelligence"
echo
echo -e "${YELLOW}Next Steps:${NC}"
echo "1. Test agents to ensure memory integration works correctly"
echo "2. Initialize memory files using bootstrap scripts if not already done"
echo "3. Begin using agents - they will now reference business intelligence"
echo "4. Monitor and update memory files as business evolves"
echo
echo -e "${GREEN}🚀 BOS-AI agents now have institutional memory!${NC}"