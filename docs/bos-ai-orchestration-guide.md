# BOS-AI Sequential Orchestration Guide

## Overview

BOS-AI uses a **sequential orchestration model** where business agents are invoked one at a time through the Task tool, with context preserved through markdown files in `/workspace/`. This guide explains how to effectively orchestrate multi-agent business missions.

## Key Concepts

### 1. Sequential Execution Only
- **ONE agent at a time** - No parallel execution
- **Wait for completion** - Each agent must finish before next starts
- **Context preservation** - Knowledge passed through .md files
- **Clear handoffs** - Explicit instructions for next agent

### 2. Context Files as Memory
The `/workspace/` directory contains five context files that serve as persistent memory:

| File | Purpose | Updated By | Used For |
|------|---------|------------|----------|
| `business-plan.md` | Mission tracking | All agents | Task status, sequence |
| `chassis-metrics.md` | Performance data | Analysis agents | Multiplier tracking |
| `agent-context.md` | Shared knowledge | All agents | Findings, decisions |
| `handoff-notes.md` | Agent-to-agent | Completing agent | Next agent instructions |
| `decision-log.md` | Decision audit | Decision makers | Accountability |

### 3. Business Chassis Focus
Everything revolves around the multiplication formula:
```
Profit = Prospects × Lead Conversion × Client Conversion × Average Spend × Transaction Frequency × Margin
```

## Orchestration Workflow

### Phase 1: Context Loading
```python
# Coordinator reads current state
1. Read /workspace/business-plan.md
2. Read /workspace/chassis-metrics.md  
3. Read /workspace/agent-context.md
4. Load any user-provided context files
```

### Phase 2: Sequential Delegation
```python
# For each agent in sequence:
1. Call Task tool with:
   - subagent_type = 'agent-name'
   - description = 'Brief task description'
   - prompt = 'Detailed context including file references'
   
2. Wait for agent completion

3. Update context files:
   - Mark task complete in business-plan.md
   - Record metrics in chassis-metrics.md
   - Add findings to agent-context.md
   - Create handoff-notes.md for next agent
   
4. Proceed to next agent
```

### Phase 3: Mission Completion
```python
1. Generate final report
2. Update all metrics
3. Document lessons learned
4. Archive context for future reference
```

## Available Missions

### Quick Reference
| Mission | Command | Duration | Agents |
|---------|---------|----------|--------|
| Chassis Optimization | `/coord optimize` | 2-3 days | 5 |
| Product Launch | `/coord launch [files]` | 5-7 days | 7 |
| Customer Acquisition | `/coord acquire [files]` | 3-4 days | 6 |
| Retention Improvement | `/coord retention [files]` | 4-5 days | 6 |
| Weekly Review | `/coord weekly` | 4-6 hours | 5 |

## Context File Templates

### Starting a Mission
Create initial `business-plan.md`:
```markdown
# Business Mission: [Name]
Phase: Planning
Next Agent: multiplication-engine

## Upcoming Tasks
- [ ] Identify weakest multiplier
- [ ] Research improvement opportunities
- [ ] Design intervention
- [ ] Implement changes
- [ ] Measure impact
```

### Agent Handoff
Create `handoff-notes.md`:
```markdown
# Handoff from @agent1 to @agent2

## What I Found
- Weakest multiplier: Lead Conversion (2%)
- Industry average: 5-7%
- Improvement potential: 3x

## What You Need To Do
- Research best practices for lead conversion
- Focus on B2B SaaS segment
- Consider automation opportunities

## Key Files
- /workspace/chassis-metrics.md - Updated with analysis
- /documents/market-research.md - Competitor data
```

## Best Practices

### 1. Clear Task Definition
✅ **Good**: "Analyze chassis metrics to identify the single weakest multiplier and calculate improvement potential"

❌ **Bad**: "Look at the metrics and find problems"

### 2. Context References
✅ **Good**: "Read /workspace/handoff-notes.md from market-intelligence for segment analysis, then design retention programs for the high-value segment identified"

❌ **Bad**: "Create some retention programs"

### 3. Success Criteria
✅ **Good**: "Success: Provide 3 specific interventions with projected ROI for each, update chassis-metrics.md with projections"

❌ **Bad**: "Come up with some ideas"

## Common Patterns

### Pattern 1: Analysis → Strategy → Implementation
```
1. Performance-analysis → Measure current state
2. Strategic-opportunity → Identify opportunities  
3. Solution-design → Create intervention plan
4. [Specialist] → Execute implementation
5. Performance-analysis → Measure impact
```

### Pattern 2: Research → Validation → Execution
```
1. Market-intelligence → Research market
2. Opportunity-validation → Validate findings
3. Campaign-execution → Launch initiative
4. Conversion-optimization → Optimize results
```

### Pattern 3: Problem → Root Cause → Solution
```
1. Retention-strategy → Identify churn issues
2. Client-success-intelligence → Understand causes
3. Customer-success → Implement fixes
4. Satisfaction-optimization → Enhance experience
```

## Troubleshooting

### Agent Doesn't Respond Properly
1. **Check context files** - Ensure they exist and contain data
2. **Clarify instructions** - Make prompt more specific
3. **Break down task** - Simplify into smaller steps
4. **Try alternate agent** - Use fallback with similar capabilities

### Context Lost Between Agents
1. **Verify file updates** - Check timestamps on context files
2. **Review handoff notes** - Ensure clear instructions
3. **Add explicit references** - Include file paths in prompts
4. **Increase detail** - Provide more context in handoff

### Mission Stalls
1. **Check decision log** - Look for blocking decisions
2. **Review business plan** - Identify incomplete tasks
3. **Examine metrics** - Spot degrading multipliers
4. **Escalate to human** - Some decisions need human input

## Integration with AGENT-11

### Clear Boundaries
- **BOS-AI**: Business strategy, PRDs, requirements
- **AGENT-11**: Technical implementation, code, deployment

### Handoff Point
When BOS-AI completes a PRD:
```markdown
## PRD Complete
Location: /documents/foundation/prds/product-prd.md
Business Context: /workspace/agent-context.md

Ready for AGENT-11 technical implementation
Next: Use AGENT-11 /coord build command
```

## Performance Optimization

### 1. Minimize Context Size
- Archive old handoff notes
- Summarize lengthy findings
- Focus on actionable data
- Remove redundant information

### 2. Clear Sequential Planning
- Define all tasks upfront
- Identify dependencies early
- Plan fallback sequences
- Set realistic timeframes

### 3. Effective Handoffs
- One primary ask per agent
- Include success criteria
- Reference specific files
- Provide decision authority

## Metrics & Monitoring

### Track Mission Success
- Time to completion
- Multiplier improvements
- Decision velocity
- Context preservation quality
- Agent success rate

### Business Impact
- Profit increase percentage
- Individual multiplier changes
- Compound effect achieved
- ROI on time invested

## Quick Start Checklist

Before starting any mission:
- [ ] `/workspace/` directory exists
- [ ] Context file templates ready
- [ ] Mission type identified
- [ ] Input documents gathered
- [ ] Success criteria defined
- [ ] Fallback sequences planned

## Command Examples

```bash
# Start interactive mission selection
/coord

# Run chassis optimization
/coord optimize

# Launch product with context
/coord launch product-brief.md competitors.md

# Weekly business review
/coord weekly

# Customer acquisition campaign
/coord acquire segments.csv budget.md
```

---

*BOS-AI Orchestration Guide v1.0 | Sequential Business Intelligence*