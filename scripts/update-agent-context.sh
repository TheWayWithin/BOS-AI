#!/bin/bash

# Script to update all BOS-AI agents with mandatory context protocol
# This adds context validation requirements to all agent configurations

echo "🚀 Starting BOS-AI Agent Context Protocol Update"
echo "================================================"

# Define the context protocol text to add to each agent
read -r -d '' CONTEXT_PROTOCOL << 'EOF'

## MANDATORY CONTEXT PROTOCOL

### Required Document Access
Before ANY task execution, you MUST:
1. Read `/workspace/agent-context.md` for mission context and objectives
2. Read `/workspace/handoff-notes.md` for your specific task requirements
3. Read relevant foundation documents based on task type:
   - For strategic work: `/documents/foundation/vision-mission.md`
   - For planning: `/documents/foundation/strategic-roadmap.md`
   - For customer work: `/documents/foundation/client-success-blueprint.md`
   - For market analysis: `/documents/foundation/market-research.md`
4. Read `/workspace/business-plan.md` for current mission state

### Context Documentation Requirements
After completing ANY task, you MUST:
1. Update `/workspace/agent-context.md` with your findings and decisions
2. Create/update `/workspace/handoff-notes.md` for the next agent
3. Update `/workspace/chassis-metrics.md` with relevant metrics
4. Save deliverables to appropriate locations

### Task Validation Checklist
- [ ] Read all required context documents before starting
- [ ] Verified understanding of mission objectives
- [ ] Aligned output with business requirements
- [ ] Updated all handoff documentation
- [ ] Preserved critical context for next agent

---
*AGENT-11 Standard | Business Optimization System | Context Validated*
EOF

# Function to update an agent file
update_agent() {
    local file="$1"
    local agent_name=$(basename "$file" .md)
    
    # Skip if already updated (check for "MANDATORY CONTEXT PROTOCOL")
    if grep -q "MANDATORY CONTEXT PROTOCOL" "$file"; then
        echo "✓ Already updated: $agent_name"
        return
    fi
    
    # Check if file ends with the AGENT-11 standard line
    if grep -q "^\*AGENT-11 Standard" "$file"; then
        # Remove the last line and add context protocol before it
        head -n -1 "$file" > "$file.tmp"
        echo "$CONTEXT_PROTOCOL" >> "$file.tmp"
        mv "$file.tmp" "$file"
        echo "✅ Updated: $agent_name"
    else
        # Just append the context protocol
        echo "$CONTEXT_PROTOCOL" >> "$file"
        echo "✅ Updated: $agent_name (appended)"
    fi
}

# Arrays of agent categories and their agents
declare -a coordination_agents=(
    "client-success-intelligence"
    "multiplication-engine"
)

declare -a discovery_agents=(
    "opportunity-validation"
    "strategic-opportunity"
)

declare -a creation_agents=(
    "rapid-development"
    "value-optimization"
)

declare -a delivery_agents=(
    "customer-success"
    "quality-assurance"
    "delivery-optimization"
)

declare -a growth_agents=(
    "scaling-strategy"
    "market-expansion"
    "revenue-optimization"
)

declare -a marketing_agents=(
    "brand-strategy"
    "campaign-execution"
    "content-creation"
)

declare -a sales_agents=(
    "pipeline-management"
    "conversion-optimization"
    "revenue-operations"
)

declare -a service_agents=(
    "support-management"
    "satisfaction-optimization"
    "retention-strategy"
)

declare -a financial_agents=(
    "budget-planning"
    "performance-analysis"
    "investment-strategy"
)

declare -a legal_agents=(
    "compliance-management"
    "risk-assessment"
    "contract-management"
)

# Update coordination agents
echo -e "\n📁 Updating Coordination Agents..."
for agent in "${coordination_agents[@]}"; do
    update_agent "agents/coordination/$agent.md"
done

# Update discovery agents
echo -e "\n📁 Updating Discovery Agents..."
for agent in "${discovery_agents[@]}"; do
    update_agent "agents/discovery/$agent.md"
done

# Update creation agents
echo -e "\n📁 Updating Creation Agents..."
for agent in "${creation_agents[@]}"; do
    update_agent "agents/creation/$agent.md"
done

# Update delivery agents
echo -e "\n📁 Updating Delivery Agents..."
for agent in "${delivery_agents[@]}"; do
    update_agent "agents/delivery/$agent.md"
done

# Update growth agents
echo -e "\n📁 Updating Growth Agents..."
for agent in "${growth_agents[@]}"; do
    update_agent "agents/growth/$agent.md"
done

# Update marketing agents
echo -e "\n📁 Updating Marketing Agents..."
for agent in "${marketing_agents[@]}"; do
    update_agent "agents/marketing/$agent.md"
done

# Update sales agents
echo -e "\n📁 Updating Sales Agents..."
for agent in "${sales_agents[@]}"; do
    update_agent "agents/sales/$agent.md"
done

# Update customer service agents
echo -e "\n📁 Updating Customer Service Agents..."
for agent in "${service_agents[@]}"; do
    update_agent "agents/customer-service/$agent.md"
done

# Update financial agents
echo -e "\n📁 Updating Financial Agents..."
for agent in "${financial_agents[@]}"; do
    update_agent "agents/financial/$agent.md"
done

# Update legal agents
echo -e "\n📁 Updating Legal Agents..."
for agent in "${legal_agents[@]}"; do
    update_agent "agents/legal/$agent.md"
done

echo -e "\n================================================"
echo "✨ Agent Context Protocol Update Complete!"
echo ""
echo "Next steps:"
echo "1. Review updated agents in /agents/ directory"
echo "2. Run deployment script to update .claude/agents/"
echo "3. Test with a multi-agent mission"
echo ""
echo "Updated files include:"
echo "- Context validation requirements"
echo "- Document access protocols"
echo "- Handoff preservation rules"
echo "- Task validation checklists"