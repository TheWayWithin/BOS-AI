# BOS-AI Mission Catalog

Pre-built workflows that coordinate multiple agents to achieve specific business outcomes. Each mission follows a systematic approach with clear phases and deliverables.

## Mission Overview

Missions are multi-agent workflows triggered via `/coord [mission]`. They automate complex business processes by orchestrating specialist agents in sequence.

## Core Mission Library

### 🎯 chassis-optimization
**Purpose**: Analyze and optimize your Business Chassis for maximum growth
**Duration**: 30-45 minutes
**Agents Involved**: @chassis-intelligence, @multiplication-engine, relevant specialists

**Phases**:
1. **Analysis** - Evaluate all six Business Chassis multipliers
2. **Identification** - Find weakest link (biggest constraint)
3. **Strategy** - Develop improvement plan
4. **Implementation** - Create action items
5. **Measurement** - Set tracking metrics

**Usage**:
```
/coord optimize
```

**Deliverables**:
- Business Chassis scorecard
- Bottleneck analysis report
- 30-day improvement plan
- KPI tracking dashboard

---

### 📋 daily-review
**Purpose**: Daily business health check and planning
**Duration**: 15-20 minutes
**Agents Involved**: @chassis-intelligence, @performance-analysis, @pipeline-management

**Phases**:
1. **Metrics Review** - Check key performance indicators
2. **Issue Identification** - Flag problems or opportunities
3. **Priority Setting** - Define day's focus
4. **Task Planning** - Create action list

**Usage**:
```
/coord daily-review
```

**Deliverables**:
- Daily metrics snapshot
- Priority task list
- Issue escalation report

---

### 🚀 product-launch
**Purpose**: Coordinate complete product/service launch
**Duration**: 2-3 hours
**Agents Involved**: @market-intelligence, @solution-design, @campaign-execution, @pipeline-management

**Phases**:
1. **Market Research** - Validate market fit and competition
2. **Product Design** - Finalize features and pricing
3. **Go-to-Market** - Create launch strategy
4. **Campaign Setup** - Prepare marketing materials
5. **Sales Enablement** - Ready sales process
6. **Launch Execution** - Coordinate release

**Usage**:
```
/coord product-launch "product name or description"
```

**Deliverables**:
- Market analysis report
- Product specification
- Launch timeline
- Marketing campaign assets
- Sales playbook
- Success metrics framework

---

### 🎪 customer-acquisition
**Purpose**: Design and execute customer acquisition campaign
**Duration**: 1-2 hours
**Agents Involved**: @market-intelligence, @campaign-execution, @conversion-optimization

**Phases**:
1. **Audience Definition** - Identify target segments
2. **Channel Selection** - Choose acquisition channels
3. **Campaign Design** - Create messaging and offers
4. **Funnel Optimization** - Design conversion path
5. **Launch & Monitor** - Execute and track

**Usage**:
```
/coord customer-acquisition "target market segment"
```

**Deliverables**:
- Customer persona profiles
- Channel strategy document
- Campaign creative brief
- Conversion funnel map
- ROI projections

---

### 💰 revenue-optimization
**Purpose**: Maximize revenue through systematic optimization
**Duration**: 1-2 hours
**Agents Involved**: @revenue-optimization, @pricing-strategy, @retention-strategy

**Phases**:
1. **Revenue Analysis** - Audit current streams
2. **Opportunity Identification** - Find growth levers
3. **Pricing Optimization** - Adjust pricing model
4. **Retention Enhancement** - Reduce churn
5. **Upsell Development** - Create expansion paths

**Usage**:
```
/coord revenue-optimization
```

**Deliverables**:
- Revenue stream analysis
- Pricing strategy document
- Retention program design
- Upsell playbook
- 90-day revenue plan

---

### 🏗️ project-setup
**Purpose**: Initialize new project with complete structure
**Duration**: 30-45 minutes
**Agents Involved**: @chassis-intelligence, @solution-design

**Phases**:
1. **Structure Creation** - Set up directories and files
2. **Documentation** - Create initial docs
3. **Workflow Setup** - Configure processes
4. **Team Alignment** - Define roles and responsibilities
5. **Success Criteria** - Set goals and metrics

**Usage**:
```
/coord project-setup "project name"
```

**Deliverables**:
- Project directory structure
- README and documentation
- Workflow definitions
- Success metrics
- Initial task list

---

### 📈 scaling-strategy
**Purpose**: Develop comprehensive scaling plan
**Duration**: 2-3 hours
**Agents Involved**: @scaling-strategy, @market-expansion, @multiplication-engine

**Phases**:
1. **Readiness Assessment** - Evaluate scaling capacity
2. **Strategy Development** - Create scaling roadmap
3. **Resource Planning** - Identify needs
4. **Risk Analysis** - Assess challenges
5. **Implementation Plan** - Define execution steps

**Usage**:
```
/coord scale
```

**Deliverables**:
- Scaling readiness report
- Growth strategy document
- Resource requirements
- Risk mitigation plan
- 6-month roadmap

---

### 🔥 crisis-management
**Purpose**: Rapid response to business crisis
**Duration**: 30-60 minutes
**Agents Involved**: @chassis-intelligence, @risk-assessment, relevant specialists

**Phases**:
1. **Assessment** - Evaluate crisis impact
2. **Containment** - Stop immediate damage
3. **Communication** - Manage stakeholders
4. **Resolution** - Fix root cause
5. **Recovery** - Restore operations
6. **Learning** - Document lessons

**Usage**:
```
/coord crisis "crisis description"
```

**Deliverables**:
- Crisis assessment report
- Action priority list
- Communication plan
- Recovery timeline
- Post-mortem analysis

---

### 📊 weekly-review
**Purpose**: Comprehensive weekly performance analysis
**Duration**: 45-60 minutes
**Agents Involved**: @performance-analysis, @chassis-intelligence, all function leads

**Phases**:
1. **Metrics Compilation** - Gather week's data
2. **Performance Analysis** - Evaluate against goals
3. **Win/Loss Review** - Analyze outcomes
4. **Bottleneck Identification** - Find constraints
5. **Next Week Planning** - Set priorities

**Usage**:
```
/coord weekly-review
```

**Deliverables**:
- Weekly scorecard
- Performance analysis
- Lessons learned
- Next week priorities
- Action items list

---

### 🎨 brand-development
**Purpose**: Create or refresh brand identity
**Duration**: 2-3 hours
**Agents Involved**: @brand-strategy, @content-creation, @market-intelligence

**Phases**:
1. **Brand Audit** - Assess current state
2. **Market Research** - Understand positioning
3. **Identity Development** - Create brand elements
4. **Messaging Framework** - Define voice
5. **Implementation Guide** - Create standards

**Usage**:
```
/coord brand-development
```

**Deliverables**:
- Brand audit report
- Positioning statement
- Visual identity guide
- Messaging framework
- Brand standards document

## Mission Execution Patterns

### Interactive Mode
Start without parameters for guided execution:
```
/coord
```
System presents menu and guides you through selection.

### Direct Mode
Specify mission and parameters:
```
/coord product-launch "AI automation tool"
```

### Custom Parameters
Some missions accept multiple inputs:
```
/coord customer-acquisition "B2B SaaS" "enterprise" "$100k+ deals"
```

## Creating Custom Missions

### Mission Structure
```markdown
# Mission: [Name]
## Objective
[Clear goal statement]

## Phases
1. [Phase 1 name] - [Description]
2. [Phase 2 name] - [Description]
...

## Agents Required
- @agent1 - [Role]
- @agent2 - [Role]

## Deliverables
- [Deliverable 1]
- [Deliverable 2]
```

### Best Practices
1. **Clear Objectives** - Define specific outcomes
2. **Logical Phases** - Sequential steps that build
3. **Right Agents** - Match expertise to needs
4. **Measurable Results** - Include success metrics
5. **Time Estimates** - Set realistic durations

## Mission Success Metrics

Track mission effectiveness with:
- **Completion Rate** - % of missions finished
- **Time to Value** - Speed of results
- **Outcome Quality** - Achievement of objectives
- **ROI** - Return on time invested
- **Adoption Rate** - Team usage frequency

## Troubleshooting Missions

### Mission Not Starting
```
/coord optimize  # Try simpler mission first
```

### Mission Stuck
- Check agent availability
- Verify required inputs
- Review error messages

### Poor Results
- Ensure clear inputs
- Check agent expertise match
- Review mission parameters

## Advanced Mission Features

### Chaining Missions
Execute missions in sequence:
```
/coord daily-review → /coord customer-acquisition → /coord revenue-optimization
```

### Scheduled Missions
Set up recurring workflows:
- Daily: daily-review
- Weekly: weekly-review
- Monthly: chassis-optimization

### Mission Templates
Save custom mission configurations for reuse.

## Quick Reference

| Mission | Trigger | Duration | Purpose |
|---------|---------|----------|---------|
| optimize | `/coord optimize` | 30-45m | Fix biggest bottleneck |
| daily-review | `/coord daily` | 15-20m | Daily planning |
| product-launch | `/coord launch` | 2-3h | Launch product |
| customer-acquisition | `/coord acquire` | 1-2h | Get customers |
| revenue-optimization | `/coord revenue` | 1-2h | Increase revenue |
| project-setup | `/coord setup` | 30-45m | Start project |
| scale | `/coord scale` | 2-3h | Plan growth |
| crisis | `/coord crisis` | 30-60m | Handle emergency |

---

## See Also

- [Agent Reference](../agents/README.md) - All 30 business specialists
- [Quick Reference](../reference/quick-reference.md) - Command cheat sheet
- [First Mission Guide](../getting-started/first-mission.md) - Hands-on walkthrough
- [Business Chassis](../concepts/business-chassis.md) - The optimization formula

---

[Back to Documentation](../README.md) | [Back to Main README](../../README.md)

---

*For agent details, see [Agent Reference](../agents/README.md). For commands, see [CLAUDE.md](../../CLAUDE.md).*