# Mission Sequence: Weekly Business Review

**Type**: Sequential Performance Review  
**Duration**: 4-6 hours  
**Agents Required**: 5  
**Expected Impact**: Continuous optimization

## Mission Objective
Conduct comprehensive weekly business review to track Business Chassis performance, identify emerging opportunities and threats, and set optimization priorities for the coming week.

## Sequential Agent Flow

### Step 1: Performance Measurement
**Agent**: `performance-analysis`  
**Duration**: 1.5 hours  
**Task**: Analyze weekly metrics

**Context Input**:
- Read `/workspace/chassis-metrics.md`
- Previous week's targets
- KPI dashboard

**Expected Output**:
- Performance report generated
- Variances identified
- Trends analyzed
- Update `/workspace/agent-context.md`

---

### Step 2: Chassis Multiplication Review
**Agent**: `multiplication-engine`  
**Duration**: 1 hour  
**Task**: Assess multiplier performance

**Context Input**:
- Read `/workspace/agent-context.md`
- Performance data from Step 1
- Improvement initiatives

**Expected Output**:
- Multiplier changes tracked
- Compound effects calculated
- Bottlenecks identified
- Update `/workspace/handoff-notes.md`

---

### Step 3: Market Intelligence Update
**Agent**: `market-intelligence`  
**Duration**: 1 hour  
**Task**: Scan market environment

**Context Input**:
- Read `/workspace/handoff-notes.md`
- Competitive landscape
- Industry trends

**Expected Output**:
- Market changes noted
- Opportunities identified
- Threats assessed
- Update `/workspace/business-plan.md`

---

### Step 4: Customer Success Review
**Agent**: `customer-success`  
**Duration**: 45 minutes  
**Task**: Assess customer health

**Context Input**:
- Read `/workspace/business-plan.md`
- Customer metrics
- Support tickets

**Expected Output**:
- Customer health scored
- At-risk accounts flagged
- Success stories captured
- Update `/workspace/agent-context.md`

---

### Step 5: Strategic Planning
**Agent**: `chassis-intelligence`  
**Duration**: 1 hour  
**Task**: Set next week's priorities

**Context Input**:
- Read all `/workspace/*.md` files
- Week's performance summary
- Identified opportunities

**Expected Output**:
- Next week's priorities set
- Resource allocation planned
- Missions scheduled
- Update `/workspace/decision-log.md`
- Weekly report published

## Context File Updates

### Required Updates Per Step:
1. **After Step 1**: Update `/workspace/agent-context.md` with performance data
2. **After Step 2**: Create `/workspace/handoff-notes.md` with multiplier analysis
3. **After Step 3**: Update `/workspace/business-plan.md` with market insights
4. **After Step 4**: Update `/workspace/agent-context.md` with customer status
5. **After Step 5**: Update `/workspace/decision-log.md` with weekly decisions

## Weekly Dashboard Template

### Business Chassis Performance
| Multiplier | Last Week | This Week | Change | Status |
|------------|-----------|-----------|--------|--------|
| Prospects | | | | |
| Lead Conversion | | | | |
| Client Conversion | | | | |
| Average Spend | | | | |
| Transaction Frequency | | | | |
| Margin | | | | |
| **Total Profit** | | | | |

### Key Achievements
1. [Achievement 1 with impact]
2. [Achievement 2 with impact]
3. [Achievement 3 with impact]

### Issues & Blockers
1. [Issue 1 with mitigation plan]
2. [Issue 2 with mitigation plan]

### Next Week Focus
1. **Priority 1**: [Specific mission/task]
2. **Priority 2**: [Specific mission/task]
3. **Priority 3**: [Specific mission/task]

## Success Criteria
- [ ] All metrics reviewed and updated
- [ ] Trends identified and documented
- [ ] Customer health assessed
- [ ] Market changes captured
- [ ] Next week planned
- [ ] Decisions documented

## Quick Wins Identification
Look for opportunities to:
- Improve weakest multiplier by 5-10%
- Capture emerging market opportunity
- Prevent customer churn
- Optimize underperforming campaigns
- Reduce operational inefficiencies

## Escalation Triggers
Escalate to human if:
- Any multiplier drops >15% week-over-week
- Major customer at risk of churning
- Significant market threat emerges
- Resource constraints blocking progress
- Strategic pivot consideration needed

## Historical Tracking
Maintain week-over-week comparisons:
```
Week 1: Baseline established
Week 2: +X% improvement in [multiplier]
Week 3: +Y% improvement in [multiplier]
Week 4: Monthly rollup and analysis
```

## Example Command
```bash
/coord weekly
```

This triggers the complete weekly review sequence automatically every Monday morning or on-demand.