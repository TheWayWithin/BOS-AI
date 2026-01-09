# Memory Integration Template for BOS-AI Agents

This template provides the standard memory integration protocol to be added to all BOS-AI agents.

## Memory Integration Protocol

**MEMORY ACCESS REQUIREMENT**: Before any business decision or strategy development, ALWAYS read relevant memory files to leverage accumulated business intelligence and prevent repeating past mistakes.

### Essential Memory Files

**Business Foundation** (Read first for context):
- `/memories/business/vision.xml` - Business mission, vision, strategic objectives
- `/memories/business/markets.xml` - Market intelligence and competitive landscape  
- `/memories/business/customers.xml` - Customer personas and journey insights
- `/memories/business/operations.xml` - Operational procedures and performance metrics

**Strategic Intelligence** (Domain-specific):
- `/memories/strategies/growth.xml` - Growth strategies (successful and failed)
- `/memories/strategies/marketing.xml` - Marketing campaign performance and patterns
- `/memories/strategies/sales.xml` - Sales approaches and customer conversion intelligence
- `/memories/strategies/failures.xml` - Critical failure analysis and prevention strategies

**Institutional Learning**:
- `/memories/lessons/insights.xml` - Cross-functional business insights
- `/memories/lessons/decisions.xml` - Strategic decision history and outcomes
- `/memories/lessons/patterns.xml` - Business success and failure patterns

**Technical Context** (as relevant):
- `/memories/technical/integrations.xml` - Business system integrations and automation

### Memory Reference Protocol

1. **Session Start**: Read core business memory files (vision, markets, customers) to understand current business context
2. **Domain Work**: Read domain-specific strategy and lessons files relevant to your specialization
3. **Decision Points**: Reference decision.xml and patterns.xml for similar historical decisions
4. **Strategy Development**: Check strategies files for proven approaches and failures.xml for anti-patterns
5. **Session End**: Update handoff-notes.md with any new insights that should be captured in memory files

### Memory Update Responsibilities

**When to Update Memory Files**:
- New business insights discovered during agent work
- Successful strategies proven effective
- Failed approaches that should be avoided
- Pattern recognition across business operations
- Strategic decisions and their outcomes

**How to Update**:
- Add new entries to appropriate XML sections
- Include full context: business situation, approach taken, outcome, lessons learned
- Quantify business impact when possible (revenue, cost, time, strategic value)
- Reference specific evidence and dates

### Cross-Session Learning Requirements

**MANDATORY**: Each agent must demonstrate learning from memory by:
- Referencing relevant historical context in recommendations
- Avoiding strategies marked as failures in failure.xml
- Building upon successful approaches documented in strategy files
- Incorporating customer and market insights into domain work
- Contributing new learnings back to memory system

This memory integration enables 40% reduction in repeat business mistakes and builds institutional intelligence that multiplies Business Chassis effectiveness over time.